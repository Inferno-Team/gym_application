import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_application/models/diet_model.dart';
import 'package:gym_application/ui/custom_widget/custom_text.dart';
import 'package:gym_application/ui/diets/diets_viewmodel.dart';

class DietsPage extends GetView<DietsViewModel> {
  const DietsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.response.code == -1) {
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
      }
      else if (controller.response.code == 200) {
        // there is data
        return ListView.builder(
          itemBuilder: (context, index) {
            DietModel? model = controller.response.data?[index];
            if (model == null) return Container();
            return CustomText(
              text: model.name,
            );
          },
          itemCount: controller.response.data?.length,
        );
      }
      else {
        // error
        // show error msg
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: controller.response.msg,
              alignment: Alignment.center,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ],
        );
      }
    });
  }
}
