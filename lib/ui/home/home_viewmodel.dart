import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gym_application/repositories/data_service.dart';
import 'package:gym_application/ui/gym_page/gym_page.dart';
import 'package:gym_application/ui/gyms/gyms_bindings.dart';
import 'package:gym_application/ui/gyms/gyms_page.dart';
import 'package:gym_application/ui/home/home_screen.dart';
import 'package:gym_application/utils/constances.dart';
import 'package:gym_application/utils/storage_helper.dart';

class HomeController extends GetxController {
  final StorageHelper helper;
  final DataService dataService;

  final _xOffset = 0.0.obs;
  final _yOffset = 0.0.obs;
  final _xShadowOffset = 0.0.obs;
  final _isDrawerOpen = false.obs;
  final _direction = TextDirection.ltr.obs;
  final _directionString = 'ltr'.obs;
  final _currentRoute = ''.obs;

  String get currentRoute => _currentRoute.value;

  TextDirection get direction => _direction.value;

  String get directionString => _directionString.value;

  bool get isDrawerOpen => _isDrawerOpen.value;

  double get xOffset => _xOffset.value;

  double get yOffset => _yOffset.value;

  double get xShadowOffset => _xShadowOffset.value;

  void gotoGyms() {
    toggleMenu();
    changeCurrentRoute('/home/gym');
    Get.toNamed(PagesRouteConst.gymsPageRoute, id: 1);
  }

  void changeCurrentRoute(String value) => _currentRoute.value = value;

  @override
  void onInit() {
    _direction.value = StorageHelper.getTextDirection();
    _directionString.value = StorageHelper.getTextDirection().name;
    _calcShadowOffset();
    _currentRoute.value = '/home';
    super.onInit();
  }

  void _calcShadowOffset() {
    _directionString.value == TextDirection.ltr.name
        ? _xShadowOffset.value = -10.0
        : _xShadowOffset.value = 10.0;
  }

  void toggleMenu() {
    String lang = StorageHelper.getSavedLanguage() ?? 'en';
    if (lang == 'en') {
      _xOffset.value = 290;
    } else {
      _xOffset.value = 0;
    }
    _yOffset.value = 80;
    if (isDrawerOpen) {
      _yOffset.value = 0;
      _xOffset.value = 0;
    }

    _isDrawerOpen.value = !_isDrawerOpen.value;
  }

  void _toggleDirection() {
    _direction.value = StorageHelper.getTextDirection();
    _directionString.value = StorageHelper.getTextDirection().name;
  }

  void toggleLanguage() {
    toggleMenu();
    Get.locale = StorageHelper.swipeLanguage();
    _toggleDirection();
    _calcShadowOffset();
  }

  void logout() {
    helper.logout();
    Get.toNamed(PagesRouteConst.loginPageRoute);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == PagesRouteConst.homeScreenRoute) {
      return GetPageRoute(
        settings: settings,
        page: () => const HomeScreen(),
        transition: Transition.zoom,
      );
    } else if (settings.name == PagesRouteConst.gymsPageRoute) {
      return GetPageRoute(
        settings: settings,
        page: () => GymsPage(),
        binding: GymsBinding(),
        transition: Transition.zoom,
      );
    } else if (settings.name == PagesRouteConst.gymPageRoute) {
      return GetPageRoute(
        settings: settings,
        page: () => GymPage(),
        transition: Transition.zoom,
      );
    } else {
      return null;
    }
  }

  Future<bool> onBackPressed() async {
    final routes = currentRoute.split('/');
    print(routes.length);
    if (routes.length > 2) {
      _currentRoute.value = '';
      // state: nesting
      // remove last route name.
      routes.removeAt(0);
      routes.removeLast();

      // rebuild the route
      for (var element in routes) {
        _currentRoute.value += '/$element';
      }
      print(currentRoute);
    } else {
      return true;
    }

    Get.back(id: 1);
    return false;
  }

  HomeController({required this.helper, required this.dataService});
}