import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageTranslator extends Translations {
  final Map<String, Map<String, String>> _keys = {
    "ar_SY": {
      Keys.LANGUAGE.name: 'English',
      Keys.LOGIN.name: 'تسجيل الدخول',
      Keys.Email.name: 'بريد الكتروني',
      Keys.Password.name: 'كلمة المرور',
      Keys.NOT_CUSTOMER.name:
          "هذا الحساب ليس حساب مستخدم يرجى استخدام الموقع بدل من التطبيق",
      Keys.App_Name.name: "تطبيق النوادي",
      Keys.Gyms.name: "النوادي",
      Keys.My_diets.name: "حمياتي",
      Keys.Diets.name: "الحميات",
      Keys.TOGGLE_LANGUAGE.name: "اللغة",
      Keys.Logout.name: "تسجيل الخروج",
    },
    "en_US": {
      Keys.LANGUAGE.name: 'العربية',
      Keys.LOGIN.name: 'Login',
      Keys.Email.name: 'Email',
      Keys.Password.name: 'Password',
      Keys.NOT_CUSTOMER.name: "you are not a customer please use our website.",
      Keys.App_Name.name: 'Gym Application',
      Keys.Gyms.name: 'Gyms',
      Keys.My_diets.name: 'My diets',
      Keys.Diets.name: 'Diets',
      Keys.TOGGLE_LANGUAGE.name: 'Language',
      Keys.Logout.name: 'Logout',
    }
  };

  @override
  Map<String, Map<String, String>> get keys => _keys;
}

enum Keys {
  LANGUAGE,
  TOGGLE_LANGUAGE,
  LOGIN,
  Email,
  Password,
  NOT_CUSTOMER,
  App_Name,
  Gyms,
  My_diets,
  Diets,
  Logout,
}
