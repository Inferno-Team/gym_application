import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_application/ui/custom_widget/custom_text.dart';
import 'package:gym_application/ui/custom_widget/drawer_item.dart';
import 'package:gym_application/ui/home/home_viewmodel.dart';
import 'package:gym_application/utils/languages_translator.dart';

class DrawerScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: Colors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 50, 20, 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: Keys.App_Name.name.tr,
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                alignment: controller.directionString == 'ltr'
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
              ),
              Column(
                children: [
                  CustomDrawerItem(
                    icon: Icons.pedal_bike,
                    text: Keys.Gyms.name.tr,
                    fontSize: 14,
                    onClick: controller.gotoGyms,
                  ),
                  CustomDrawerItem(
                    icon: Icons.no_food_sharp,
                    text: Keys.My_diets.name.tr,
                    fontSize: 14,
                  ),
                  CustomDrawerItem(
                    icon: Icons.fastfood,
                    text: Keys.Diets.name.tr,
                    fontSize: 14,
                  ),
                  CustomDrawerItem(
                    icon: Icons.language,
                    text: Keys.TOGGLE_LANGUAGE.name.tr,
                    fontSize: 14,
                    onClick: controller.toggleLanguage,
                  ),
                ],
              ),
              CustomDrawerItem(
                icon: Icons.cancel,
                text: Keys.Logout.name.tr,
                fontSize: 14,
                fontColor: Colors.white.withOpacity(0.5),
                iconColor: Colors.white.withOpacity(0.5),
                onClick: controller.logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
