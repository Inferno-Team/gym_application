import 'package:flutter/material.dart';
import 'package:get/get.dart';

String LOGIN_STATE = 'login_state';
String TOKEN_VALUE = 'token_value';
String LANGUAGE_VALUE = 'language';

class PagesRouteConst {
  static const String homePageRoute = '/home';
  static const String loginPageRoute = '/login';
  static const String gymsPageRoute = '/gyms';
  static const String gymPageRoute = '/gym';
  static const String homeScreenRoute = '/home-screen';
}

ThemeData myLightTheme() {
  return ThemeData(
    colorScheme:  ColorScheme.light(
      primary: Colors.grey.shade200,
      error: Colors.redAccent,
    ),
    textTheme: const TextTheme(
      labelMedium: TextStyle(
        color: Colors.black,
        fontSize: 14.0,
      )
    )

  );
}

ThemeData myDarkTheme() {
  return ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Colors.grey,
      error: Colors.redAccent,
    ),
    buttonTheme: const ButtonThemeData(
      colorScheme: ColorScheme.light(
        background: Colors.grey,
      ),
      hoverColor: Colors.black12,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
