

import 'package:get/get.dart';
import 'package:gym_application/repositories/data_service.dart';
import 'package:gym_application/ui/diet/diet_viewmodel.dart';
import 'package:gym_application/utils/storage_helper.dart';

class DietBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DietViewModel(
      helper: Get.find<StorageHelper>(),
      dataService: Get.find<DataService>(),
    ));
  }
}