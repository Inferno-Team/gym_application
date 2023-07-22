import 'package:get/get.dart';
import 'package:gym_application/repositories/data_service.dart';
import 'package:gym_application/ui/diets/diets_viewmodel.dart';
import 'package:gym_application/utils/storage_helper.dart';

class DietsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => DietsViewModel(
        helper: Get.find<StorageHelper>(),
        dataService: Get.find<DataService>(),
      ),
    );
  }
}
