import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gym_application/models/gym.dart';
import 'package:gym_application/ui/custom_widget/custom_gym_widget.dart';
import 'package:gym_application/ui/custom_widget/custom_text.dart';
import 'package:gym_application/ui/gyms/gyms_viewmodel.dart';

class GymsPage extends GetView<GymsController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
      } else if (controller.response.code == 200) {
        // there is data
        return ListView.builder(
          itemBuilder: (context, index) {
            Gym? gym = controller.response.data?[index];
            if (gym == null) return Container();
            return CustomGym(
              gym: gym,
              onTap: () => controller.onGymTap(gym),
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
