import 'package:get/get.dart';
import 'package:gym_application/repositories/data_service.dart';
import 'package:gym_application/ui/my_diets/my_diets_viewmodel.dart';
import 'package:gym_application/utils/storage_helper.dart';

class MyDietsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
          () => MyDietsViewModel(
        helper: Get.find<StorageHelper>(),
        dataService: Get.find<DataService>(),
      ),
    );
  }
}
