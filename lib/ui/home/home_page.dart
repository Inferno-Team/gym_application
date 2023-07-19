import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_application/ui/custom_widget/custom_text.dart';
import 'package:gym_application/ui/drawer/drawer_screen.dart';
import 'package:gym_application/ui/home/home_viewmodel.dart';
import 'package:gym_application/utils/languages_translator.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: controller.onBackPressed,
      child: Obx(
        () => Directionality(
          textDirection: controller.direction,
          child: Scaffold(
            body: Stack(
              children: [
                DrawerScreen(),
                Obx(
                  () => AnimatedContainer(
                    transform: Matrix4.translationValues(
                      controller.xOffset,
                      controller.yOffset,
                      0,
                    )
                      ..scale(controller.isDrawerOpen ? 0.80 : 1.00)
                      ..rotateZ(controller.isDrawerOpen ? -50 : 0.00),
                    duration: const Duration(milliseconds: 200),
                    height: size.height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: controller.isDrawerOpen
                          ? BorderRadius.circular(40)
                          : BorderRadius.circular(0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          offset: Offset(controller.xShadowOffset, 0),
                        )
                      ],
                    ),
                    child: SingleChildScrollView(
                      physics:const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            height: 30,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: controller.toggleMenu,
                                  child: Icon(controller.isDrawerOpen
                                      ? Icons.arrow_back_ios
                                      : Icons.menu),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(0.0),
                                  width: size.width - 64,
                                  child: CustomText(
                                    text: Keys.App_Name.name.tr,
                                    alignment: Alignment.center,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height-1,
                            child: Navigator(
                              key: Get.nestedKey(1),
                              initialRoute: '/home-screen',
                              onGenerateRoute: controller.onGenerateRoute,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
