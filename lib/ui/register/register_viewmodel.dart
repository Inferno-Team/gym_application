import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gym_application/models/data_response.dart';
import 'package:gym_application/models/error_response.dart';
import 'package:gym_application/models/errors_type.dart';
import 'package:gym_application/models/login_type.dart';
import 'package:gym_application/models/user_type.dart';
import 'package:gym_application/repositories/data_service.dart';
import 'package:gym_application/utils/constances.dart';
import 'package:gym_application/utils/languages_translator.dart';
import 'package:gym_application/utils/storage_helper.dart';
import 'package:gym_application/models/response.dart' as res;

class RegisterViewModel extends GetxController {
  final StorageHelper helper;
  final DataService dataService;

  RegisterViewModel({required this.helper, required this.dataService});

  final _passwordState = true.obs;
  final _loginButtonState = false.obs;
  final _emailHolder = ''.obs;
  final Rx<String?> _phoneHolder = null.obs;
  final _nameHolder = ''.obs;
  final _passwordHolder = ''.obs;
  final _errorBag = Errors.empty().obs;

  bool get passwordState => _passwordState.value;

  bool get loginState => _loginButtonState.value;

  Errors get errors => _errorBag.value;

  void toggleState() => _passwordState.value = !_passwordState.value;

  void onEmailChange(String? value) => _emailHolder.value = value ?? "";

  void onPhoneChange(String? value) => _phoneHolder.value = value ?? "";

  void onNameChange(String? value) => _nameHolder.value = value ?? "";

  void onPasswordChange(String? value) => _passwordHolder.value = value ?? "";

  void registerButtonCLicked() async {
    _loginButtonState.value = !_loginButtonState.value;
    _errorBag.value = Errors.empty();
    res.Response response = await dataService.register(
      _emailHolder.value,
      _passwordHolder.value,
      _nameHolder.value,
      _phoneHolder.value,
    );
    _loginButtonState.value = !_loginButtonState.value;
    print(response.runtimeType);
    if (response.code == 200) {
      // data response
      DataResponse<LoginType> data = response as DataResponse<LoginType>;
      if (data.data?.user.type != UserType.customer) {
        Fluttertoast.showToast(msg: Keys.NOT_CUSTOMER.name.tr);
      } else {
        Fluttertoast.showToast(msg: response.msg);

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
}
