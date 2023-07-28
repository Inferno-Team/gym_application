import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gym_application/utils/constances.dart';
import 'package:gym_application/utils/languages_translator.dart';
import 'package:gym_application/utils/pages.dart';
import 'package:gym_application/utils/storage_helper.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = StorageHelper.isLoggedIn();

    return GetMaterialApp(
      getPages: getPages(),
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn
          ? PagesRouteConst.homePageRoute
          : PagesRouteConst.loginPageRoute,
      themeMode: ThemeMode.light,
      initialBinding: InitialGetBinding(),
      translations: LanguageTranslator(),
      locale: StorageHelper.getLanguage(),
      fallbackLocale: const Locale('en', 'US'),
      builder: (context, child) {
        return child ?? Container();
      },
    );
  }
}
