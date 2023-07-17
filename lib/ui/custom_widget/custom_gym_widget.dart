import 'package:flutter/material.dart';
import 'package:gym_application/gen/assets.gen.dart';
import 'package:gym_application/models/gym.dart';
import 'package:gym_application/ui/custom_widget/custom_text.dart';

class CustomGym extends StatelessWidget {
  final Gym gym;
  final void Function()? onTap;

  const CustomGym({
    super.key,
    required this.gym,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider assetDefault = AssetImage(Assets.images.backgroundImage.path);
    final image = gym.image == null ? null : NetworkImage(gym.image!);
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: gym.name,
              color: Colors.white,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: gym.location,
                  color: Colors.white,
                  alignment: Alignment.topLeft,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                CustomText(
                  text: gym.manager.name,
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
