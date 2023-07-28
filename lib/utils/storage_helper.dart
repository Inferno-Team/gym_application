import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gym_application/utils/constances.dart';

class StorageHelper {
  void login(String token) {
    GetStorage storage = GetStorage();
    storage.write(LOGIN_STATE, true);
    storage.write(TOKEN_VALUE, token);
  }

  static bool isLoggedIn() {
    GetStorage storage = GetStorage();
    // print(storage.read(LANGUAGE_VALUE));
    // if(storage.read(LOGIN_STATE) == null)
    //   return false;
    // else return storage.read(LOGIN_STATE);
    return storage.read(LOGIN_STATE) ?? false;
  }

  String getToken() {
    GetStorage storage = GetStorage();
    return storage.read(TOKEN_VALUE) ?? "";
  }

  static String? getSavedLanguage() {
    GetStorage storage = GetStorage();
    String? lang = storage.read(LANGUAGE_VALUE);
    return lang;
  }

  static Locale? getLanguage() {
    String? lang = getSavedLanguage();
    print(lang);
    //null safety
    if (lang == null) {
      String? ln = Get.deviceLocale?.languageCode;
      _changeLanguage(ln ?? 'en');
      return Get.deviceLocale;
    }
    if (lang == 'ar') {
      return const Locale('ar', 'SY');
    } else {
      return const Locale('en', 'US');
    }
  }

  static TextDirection getTextDirection() {
    String lang = getSavedLanguage() ?? "en";
    return lang == 'en' ? TextDirection.ltr : TextDirection.rtl;
  }

  static void _changeLanguage(String code) {
    GetStorage storage = GetStorage();
    storage.write(LANGUAGE_VALUE, code);
  }

  static Locale swipeLanguage() {
    GetStorage storage = GetStorage();
    String? lang = storage.read(LANGUAGE_VALUE);

    if (lang == null || lang == 'ar') {
      _changeLanguage('en');
      return const Locale('en', 'US');
    }
    _changeLanguage('ar');
    return const Locale('ar', 'SY');
  }

  void logout() {
    GetStorage storage = GetStorage();
    storage.remove(LOGIN_STATE);
    storage.remove(TOKEN_VALUE);
  }
}
