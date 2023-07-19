import 'dart:async';
import 'package:flutter/services.dart';
import 'package:gym_application/gen/assets.gen.dart';
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

  GymsController({required this.helper, required this.dataService});

  final Rx<Gym> _selectedGym = Gym.empty().obs;
  final Rx<MapboxMapController?> _mapController =
      Rx<MapboxMapController?>(null);

  final _response = DataResponse<List<Gym>>.empty().obs;

  DataResponse<List<Gym>> get response => _response.value;

  Gym get selectedGym => _selectedGym.value;

  bool get isMyLocationLoading => _isMyLocationLoading.value;

  final Duration duration = const Duration(milliseconds: 300);

  @override
  void onInit() async {
    String token = helper.getToken();
    var response = await dataService.getAllGyms(token);
    if (response.code == 200) {
      _response.value = response as DataResponse<List<Gym>>;
    }
    super.onInit();
  }

  void onGymTap(Gym gym) async {
    final location = Location();
    final hasPermissions = await location.hasPermission();
    if (hasPermissions != PermissionStatus.granted) {
      PermissionStatus status = await location.requestPermission();
      if (status != PermissionStatus.granted) return;
    }

    _selectedGym.value = gym;
    Get.find<HomeController>().changeCurrentRoute('gym');
    Get.toNamed(PagesRouteConst.gymPageRoute, id: 1);
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
    final location = Location();
    _mapController.value = controller;
    LatLng latLng = convertGym2LatLng(selectedGym);
    _mapController.value?.animateCamera(
      CameraUpdate.newLatLng(
        latLng,
      ),
    );
    LocationData myLocation = await location.getLocation();
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

}
