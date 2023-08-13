import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_application/gen/assets.gen.dart';
import 'package:gym_application/models/my_sub_model.dart';
import 'package:gym_application/models/user_subscription.dart';
import 'package:gym_application/ui/custom_widget/custom_text.dart';
import 'package:gym_application/utils/languages_translator.dart';

class MySubCustom extends StatelessWidget {
  final MySubModel userSubscription;
  final void Function()? onTap;
  final double height;

  MySubCustom({
    super.key,
    required this.userSubscription,
    this.onTap,
    this.height = 170.0,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider assetDefault = AssetImage(Assets.images.backgroundImage.path);
    final image = userSubscription.gym.image == null
        ? null
        : NetworkImage(userSubscription.gym.image!);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: image ?? assetDefault,
            fit: BoxFit.cover,
            colorFilter:
                const ColorFilter.mode(Color(0x60212121), BlendMode.darken),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: userSubscription.sub.name,
                  color: Colors.white,
                  alignment: Alignment.topLeft,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
                Row(
                  children: [
                    Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: userSubscription.isApproved == 'yes'
                            ? Colors.greenAccent
                            : Colors.red,
                      ),
                    ),
                    CustomText(
                      text: userSubscription.isApproved == 'yes'
                          ? Keys.Active.name.tr
                          : Keys.Not_Active.name.tr,
                      color: userSubscription.isApproved == 'yes'
                          ? Colors.greenAccent
                          : Colors.red,
                      margin: const EdgeInsets.only(right: 18, left: 10),
                      fontSize: 17,
                    ),
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: userSubscription.gym.name,
                  color: Colors.white,
                  alignment: Alignment.topLeft,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                CustomText(
                  text: "${userSubscription.price} SYP",
                  color: Colors.white,
                  alignment: Alignment.topLeft,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  isItalic: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
