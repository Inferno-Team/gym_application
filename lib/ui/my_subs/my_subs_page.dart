import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_application/models/my_sub_model.dart';
import 'package:gym_application/models/user_subscription.dart';
import 'package:gym_application/ui/custom_widget/my_sub_custom_widget.dart';
import 'package:gym_application/ui/my_subs/my_sub_viewmodel.dart';

class MySubPage extends GetView<MySubViewModel> {
  const MySubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.subs.value.code == -1) {
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
        return ListView.builder(
            itemCount: controller.subs.value.data!.length,
            itemBuilder: (context, index) {
              MySubModel subscription = controller.subs.value.data![index];
              return MySubCustom(userSubscription: subscription);
            });
      }
    });
  }
}
