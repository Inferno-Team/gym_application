import 'package:get/get.dart';
import 'package:gym_application/repositories/data_service.dart';
import 'package:gym_application/ui/gyms/gyms_bindings.dart';
import 'package:gym_application/ui/gyms/gyms_page.dart';
import 'package:gym_application/ui/home/home_binding.dart';
import 'package:gym_application/ui/home/home_page.dart';
import 'package:gym_application/ui/login/login_binding.dart';
import 'package:gym_application/ui/login/login_page.dart';

import 'package:gym_application/utils/constances.dart';
import 'package:gym_application/utils/storage_helper.dart';

List<GetPage> getPages() {
  return [

    GetPage(
      name: PagesRouteConst.loginPageRoute,
      page: () => LoginPage(),
      binding: LoginBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
        name: '/home',
        page: () => HomePage(),
        binding: HomeBindings(),
        transition: Transition.zoom),
  ];
}

class InitialGetBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StorageHelper());
    Get.put(DataService());
  }
}
