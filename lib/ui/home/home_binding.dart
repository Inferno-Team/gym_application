import 'package:get/get.dart';
import 'package:gym_application/repositories/data_service.dart';
import 'package:gym_application/ui/home/home_viewmodel.dart';
import 'package:gym_application/utils/storage_helper.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
        ()=>HomeController(
        helper: Get.find<StorageHelper>(),
        dataService: Get.find<DataService>(),
      ),
    );

  }
}
