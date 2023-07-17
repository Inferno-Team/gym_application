import 'package:get/get.dart';
import 'package:gym_application/repositories/data_service.dart';
import 'package:gym_application/ui/login/login_viewmodel.dart';
import 'package:gym_application/utils/storage_helper.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>LoginViewModel(
        helper: Get.find<StorageHelper>(),
        dataService: Get.find<DataService>()));
  }
}
