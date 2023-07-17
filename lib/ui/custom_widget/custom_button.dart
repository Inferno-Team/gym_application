import 'package:flutter/material.dart';
import 'package:gym_application/ui/custom_widget/custom_text.dart';

class CustomButton2 extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool hasBorder;
  final double width;
  final double fontSize;
  final Color fontColor;
  final Color backgroundColor;
  final double height;
  final bool disable;
  final double radius;

  const CustomButton2(
      {Key? key,
      this.text = "",
      this.height = 60,
      required this.onPressed,
      this.hasBorder = false,
      this.disable = false,
      this.width = double.infinity,
      this.fontColor = Colors.black,
      this.radius = 10,
      this.backgroundColor = Colors.transparent,
      this.fontSize = 18.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Material(
        borderRadius: BorderRadius.circular(radius),
        child: Ink(
          decoration: BoxDecoration(
            color: hasBorder
                ? Colors.white
                : disable
                    ? Colors.grey
                    : backgroundColor,
            borderRadius: BorderRadius.circular(radius),
            border: hasBorder
                ? Border.all(
                    color: backgroundColor,
                    width: 1.0,
                  )
                : const Border.fromBorderSide(BorderSide.none),
          ),
          child: InkWell(
            onTap: disable ? null : onPressed,
            borderRadius: BorderRadius.circular(radius),
            child: SizedBox(
              height: height,
              child: Center(
                child: CustomText(
                  text: text,
                  color: fontColor,
                  fontSize: fontSize,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
