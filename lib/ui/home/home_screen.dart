import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_application/ui/custom_widget/custom_text.dart';
import 'package:gym_application/ui/home/home_viewmodel.dart';
import 'package:gym_application/gen/assets.gen.dart';
import 'package:gym_application/utils/languages_translator.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height - 150,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  offset: const Offset(0, 0),
                )
              ],
            ),
            child: Image.asset(
              Assets.images.backgroundImage.path,
              height: size.height * 0.55,
            ),
          ),
        ),
      ),
    );
  }
}
