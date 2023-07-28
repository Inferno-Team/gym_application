import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gym_application/models/diet_model.dart';
import 'package:gym_application/ui/custom_widget/custom_diet.dart';
import 'package:gym_application/ui/custom_widget/custom_text.dart';
import 'package:gym_application/ui/my_diets/my_diets_viewmodel.dart';
import 'package:gym_application/utils/languages_translator.dart';

class MyDietsPage extends GetView<MyDietsViewModel> {
  const MyDietsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      } else if (controller.response.code == 200) {
        if (controller.response.data!.isEmpty) {
          return Center(
            child: CustomText(
              text: Keys.No_Fav.name.tr,
              color: Colors.black45,
              fontSize: 23,
              fontWeight: FontWeight.bold,
              alignment: Alignment.center,
            ),
          );
        }
        // there is data
        return ListView.builder(
          itemBuilder: (context, index) {
            DietModel? model = controller.response.data?[index];
            if (model == null) return Container();
            return CustomDiet(
              diet: model,
              onTap: () => controller.gotoDietPage(model),
            );
          },
          itemCount: controller.response.data?.length,
        );
      } else {
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
