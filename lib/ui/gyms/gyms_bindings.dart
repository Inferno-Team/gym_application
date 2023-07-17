


import 'package:get/get.dart';
import 'package:gym_application/repositories/data_service.dart';
import 'package:gym_application/ui/gyms/gyms_viewmodel.dart';
import 'package:gym_application/utils/storage_helper.dart';

class GymsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>GymsController(
      helper: Get.find<StorageHelper>(),
      dataService: Get.find<DataService>(),
    ));
  }

}