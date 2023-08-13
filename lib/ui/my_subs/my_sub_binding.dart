import 'package:get/get.dart';
import 'package:gym_application/repositories/data_service.dart';
import 'package:gym_application/ui/my_subs/my_sub_viewmodel.dart';
import 'package:gym_application/utils/storage_helper.dart';

class MySubBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MySubViewModel(
          helper: Get.find<StorageHelper>(),
          dataService: Get.find<DataService>()),
    );
  }
}
