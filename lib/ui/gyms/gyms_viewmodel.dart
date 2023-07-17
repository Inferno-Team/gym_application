import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gym_application/models/data_response.dart';
import 'package:gym_application/models/gym.dart';
import 'package:gym_application/repositories/data_service.dart';
import 'package:gym_application/ui/home/home_viewmodel.dart';
import 'package:gym_application/utils/constances.dart';
import 'package:gym_application/utils/storage_helper.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:location/location.dart';

class GymsController extends GetxController {
  final StorageHelper helper;
  final DataService dataService;

  GymsController({required this.helper, required this.dataService});

  final Rx<Gym> _selectedGym = Gym.empty().obs;
  final Rx<MapboxMapController?> _mapController = Rx<MapboxMapController?>(null);

  final _response = DataResponse<List<Gym>>.empty().obs;

  DataResponse<List<Gym>> get response => _response.value;

  Gym get selectedGym => _selectedGym.value;

  void onMapCreated(MapboxMapController? cont) => _mapController.value = cont;

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
    Get.find<HomeController>().changeCurrentRoute('/home/gyms/gym');
    Get.toNamed(PagesRouteConst.gymPageRoute, id: 1);
  }

  LatLng convertGym2LatLng(Gym selectedGym) =>
      LatLng(selectedGym.pos[0], selectedGym.pos[1]);
}
