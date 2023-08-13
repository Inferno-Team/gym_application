import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:gym_application/models/data_response.dart';
import 'package:gym_application/models/errors_type.dart';
import 'package:gym_application/models/login_type.dart';
import 'package:gym_application/models/user_type.dart';
import 'package:gym_application/repositories/data_service.dart';
import 'package:gym_application/utils/constances.dart';
import 'package:gym_application/utils/languages_translator.dart';
import 'package:gym_application/utils/storage_helper.dart';
import 'package:gym_application/models/response.dart' as res;

import '../../models/error_response.dart';

class LoginViewModel extends GetxController {
  final StorageHelper helper;
  final DataService dataService;

  final _passwordState = true.obs;
  final _loginButtonState = false.obs;
  final Rx<String> _emailHolder = Rx<String>('');
  final _passwordHolder = ''.obs;
  final _errorBag = Errors.empty().obs;

  bool get passwordState => _passwordState.value;

  bool get loginState => _loginButtonState.value;

  Errors get errors => _errorBag.value;

  void toggleState() => _passwordState.value = !_passwordState.value;

  void onEmailChange(String? value) => _emailHolder.value = value ?? "";

  void onPasswordChange(String? value) => _passwordHolder.value = value ?? "";

  LoginViewModel({required this.helper, required this.dataService});

  void loginButtonCLicked() async {
    _loginButtonState.value = !_loginButtonState.value;
    _errorBag.value = Errors.empty();
    res.Response response = await dataService.login(
      _emailHolder.value,
      _passwordHolder.value,
    );


    _loginButtonState.value = !_loginButtonState.value;

    if (response.code == 200) {
      // data response
      DataResponse<LoginType> data = response as DataResponse<LoginType>;
      if (data.data?.user.type != UserType.customer) {
        Fluttertoast.showToast(msg: Keys.NOT_CUSTOMER.name.tr);
      } else {
        Fluttertoast.showToast(msg: response.msg);
        // print(data.data?.token);
        helper.login(data.data!.token);
        Get.offAllNamed(PagesRouteConst.homePageRoute);
      }
    } else {
      Fluttertoast.showToast(msg: response.msg);
      // error response
      _errorBag.value = ((response) as ErrorResponse).errors;
    }
  }

  void changeLanguage() {
    Locale locale = StorageHelper.swipeLanguage();
    Get.updateLocale(locale);
  }

  void gotoRegisterPage() => Get.toNamed(PagesRouteConst.registerPageRoute);
}
