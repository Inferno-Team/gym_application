import 'package:flutter/material.dart';
import 'package:gym_application/ui/custom_widget/custom_text.dart';

class CustomDrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final double fontSize;
  final Color fontColor;
  final Color iconColor;
  final void Function()? onClick;

  const CustomDrawerItem({super.key,
    required this.icon,
    required this.text,
    this.fontSize = 16,
    this.fontColor = Colors.white,
    this.iconColor = Colors.white,
    this.onClick
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Icon(icon,color: iconColor,),
            const SizedBox(
              width: 20,
            ),
            CustomText(
              text: text,
              color: fontColor,
              fontSize: fontSize,
            ),
          ],
        ),
      ),
    );
  }
}
