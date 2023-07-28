import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_application/gen/assets.gen.dart';
import 'package:gym_application/models/diet_model.dart';
import 'package:gym_application/ui/custom_widget/custom_text.dart';
import 'package:gym_application/utils/languages_translator.dart';

class CustomDiet extends StatelessWidget {
  final DietModel diet;
  final void Function()? onTap;
  final double height;

  const CustomDiet({
    super.key,
    required this.diet,
    this.onTap,
    this.height = 170.0,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider assetDefault = AssetImage(Assets.images.backgroundImage.path);
    final image =
        diet.background == null ? null : NetworkImage(diet.background!);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 170,
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: diet.name,
              color: Colors.white,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
            // const SizedBox(height: 9,),
            CustomText(
              text: diet.trainerName,
              color: Colors.white,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: diet.gym,
                  color: Colors.white,
                  alignment: Alignment.topLeft,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                CustomText(
                  text: "${Keys.ItemCount.name.tr} : ${diet.itemsCount}",
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
