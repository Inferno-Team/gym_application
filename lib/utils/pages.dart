import 'package:get/get.dart';
import 'package:gym_application/repositories/data_service.dart';
import 'package:gym_application/ui/home/home_binding.dart';
import 'package:gym_application/ui/home/home_page.dart';
import 'package:gym_application/ui/login/login_binding.dart';
import 'package:gym_application/ui/login/login_page.dart';
import 'package:gym_application/ui/register/register_binding.dart';
import 'package:gym_application/ui/register/register_page.dart';
import 'package:gym_application/utils/constances.dart';
import 'package:gym_application/utils/storage_helper.dart';

List<GetPage> getPages() {
  return [
    GetPage(
      name: PagesRouteConst.loginPageRoute,
      page: () => const LoginPage(),
      binding: LoginBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: PagesRouteConst.registerPageRoute,
      page: () => const RegisterPage(),
      binding: RegisterBindings(),
      transition: Transition.zoom,
    ),
    GetPage(
        name: PagesRouteConst.homePageRoute,
        page: () => const HomePage(),
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
