import 'package:get/get.dart';
import 'package:gym_application/repositories/data_service.dart';
import 'package:gym_application/ui/register/register_viewmodel.dart';
import 'package:gym_application/utils/storage_helper.dart';

class RegisterBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => RegisterViewModel(
        helper: Get.find<StorageHelper>(),
        dataService: Get.find<DataService>(),
      ),
    );
  }
}
