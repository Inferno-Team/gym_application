import 'dart:async';
import 'package:flutter/services.dart';
import 'package:gym_application/gen/assets.gen.dart';
import 'package:gym_application/models/check_if_user_subscribed_model.dart';
import 'package:gym_application/models/club_subscription.dart';
import 'package:gym_application/models/user_subscription.dart';
import 'package:gym_application/ui/custom_widget/bottom_sheet_club_subs.dart';
import 'package:gym_application/utils/languages_translator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gym_application/models/data_response.dart';
import 'package:gym_application/models/gym.dart';
import 'package:gym_application/repositories/data_service.dart';
import 'package:gym_application/ui/home/home_viewmodel.dart';
import 'package:gym_application/utils/constances.dart';
import 'package:gym_application/utils/storage_helper.dart';
import 'package:location/location.dart';

class GymsController extends GetxController {
  final StorageHelper helper;
  final DataService dataService;
  final _isMyLocationLoading = false.obs;
  final _isUserSubscribedToSelectedGym = DataResponse<CheckIfSub>.empty(
    data: CheckIfSub.empty()
  ).obs;
  late final Location location;
  late final LocationData myLocation;

  GymsController({required this.helper, required this.dataService});

  final Rx<Gym> _selectedGym = Gym.empty().obs;
  final Rx<MapboxMapController?> _mapController =
      Rx<MapboxMapController?>(null);

  final _response = DataResponse<List<Gym>>.empty().obs;

  DataResponse<List<Gym>> get response => _response.value;

  Gym get selectedGym => _selectedGym.value;

  bool get isMyLocationLoading => _isMyLocationLoading.value;

  bool get isUserSubscribed =>
      _isUserSubscribedToSelectedGym.value.data?.value ?? false;

  final Duration duration = const Duration(milliseconds: 300);

  @override
  void onInit() async {
    location = Location();
    myLocation = await location.getLocation();
    String token = helper.getToken();
    var response = await dataService.getAllGyms(token);
    if (response.code == 200) {
      _response.value = response as DataResponse<List<Gym>>;
    }
    super.onInit();
  }

  void onGymTap(Gym gym) async {
    bool hasPermission = await _checkPermission();

    if (!hasPermission) {
      PermissionStatus status = await location.requestPermission();
      if (status != PermissionStatus.granted) return;
    }
    _selectedGym.value = gym;
    Get.find<HomeController>().changeCurrentRoute('gym');
    Get.toNamed(PagesRouteConst.gymPageRoute, id: 1);
    await checkIfUserSubscribed();
    // Timer(const Duration(seconds: 3), () {
    //   // animationController.forward(from: 0);
    //   // animationController.animateTo(target);
    //   // _gymBoxHeight.value = 250.0;
    //   Fluttertoast.showToast(msg: "changed");
    // });
  }

  LatLng convertGym2LatLng(Gym selectedGym) =>
      LatLng(selectedGym.pos[0], selectedGym.pos[1]);

  Future<Uint8List> loadMarkerImage(String path) async {
    var byteData = await rootBundle.load(path);
    return byteData.buffer.asUint8List();
  }

  void onMapCreated(MapboxMapController? controller) async {
    _mapController.value = controller;
    LatLng latLng = convertGym2LatLng(selectedGym);
    _mapController.value?.animateCamera(
      CameraUpdate.newLatLng(
        latLng,
      ),
    );

    var markerImage = await loadMarkerImage(Assets.images.backgroundImage.path);
    var myLocationImage = await loadMarkerImage(Assets.images.location.path);
    await _mapController.value?.addImage('gym', markerImage);
    await _mapController.value?.addImage('myLocationImage', myLocationImage);
    await _mapController.value?.addSymbol(
      SymbolOptions(
          draggable: false,
          geometry: LatLng(
            myLocation.latitude ?? 0.0,
            myLocation.longitude ?? 0.0,
          ),
          iconSize: 0.15,
          iconImage: "myLocationImage",
          textField: Keys.MYLOCATION.name.tr,
          textOffset: const Offset(0.0, 2),
          textColor: "white",
          textSize: 12),
    );
    await _mapController.value?.addSymbol(
      SymbolOptions(
        draggable: false,
        geometry: latLng,
        iconSize: 0.1,
        iconImage: "gym",
        textField: "${selectedGym.name}\nGym",
        textOffset: const Offset(0.0, 2.5),
        textColor: "white",
        textSize: 12,
      ),
    );
    _isMyLocationLoading.value = false;
  }

  Future<bool> _checkPermission() async {
    final hasPermissions = await location.hasPermission();
    return hasPermissions == PermissionStatus.granted;
  }

  checkIfUserSubscribed() async {
    String token = helper.getToken();
    var response =
        await dataService.checkIfUserSubscribed(token, selectedGym.id,false);
    if (response.code == 200) {
      _isUserSubscribedToSelectedGym.value =
          response as DataResponse<CheckIfSub>;
    }
  }

  void onSubscribeClick() async {
    // get all this gym subscription types
    String token = helper.getToken();
    int id = selectedGym.id;
    var response = await dataService.getClubSubscription(token, id);
    if (response.code == 200) {
      var res = response as DataResponse<List<ClubSubScription>>;
      Get.bottomSheet(
          BottomSheetClubSubscription(
            subs: res.data,
            onTap: onSubscribeTypeTap,
          ),
          isScrollControlled: true,
          isDismissible: false);
    }
  }

  void onSubscribeTypeTap(ClubSubScription sub) async {
    String token = helper.getToken();
    var response = await dataService.customerSubscribe(token, sub.id);
    Fluttertoast.showToast(msg: response.msg);
    Get.back();
  }
}
