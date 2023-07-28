import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_application/ui/custom_widget/custom_diet.dart';
import 'package:gym_application/ui/custom_widget/custom_diet_item_table.dart';
import 'package:gym_application/ui/diet/diet_viewmodel.dart';

class DietPage extends GetView<DietViewModel> {
  final arguments;

  const DietPage({super.key, this.arguments});

  @override
  Widget build(BuildContext context) {
    controller.setSelectedDietModel(arguments['selectedDietModel']);
    return Obx(() {
      if (controller.isLoading) {
        // loading state
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          ],
        );
      } else {
        return Stack(
          children: [
            Column(
              children: [
                CustomDiet(
                  diet: controller.selectedDietModel,
                ),
                CustomDietItemTable(items: controller.items),
              ],
            ),
            Obx(
              () => Positioned(
                top: 155,
                right: 30,
                child: GestureDetector(
                  onTap: controller.onSubscribeClick,
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.5),
                      color: Colors.black.withAlpha(140),
                    ),
                    child: Icon(
                      !controller.isUserSubscribed
                          ? Icons.favorite_border
                          : Icons.favorite,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    });
  }
}
