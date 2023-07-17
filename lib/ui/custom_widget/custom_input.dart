import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CustomInput extends StatelessWidget {
  final String text;
  final String hint;
  final TextInputType type;
  final IconData? icon;
  final IconData? suffixIcon;
  final bool obscureText;
  final void Function(String?) onChange;
  final Color? fillColor;
  final double width;
  final void Function()? onSuffixIconClick;
  final TextInputAction inputAction;
  final String? errorMsg;

  const CustomInput(
      {Key? key,
      this.text = "",
      this.hint = "",
      required this.onChange,
      this.type = TextInputType.text,
      this.icon,
      this.suffixIcon,
      this.fillColor,
      this.inputAction = TextInputAction.done,
      this.width = double.infinity,
      this.errorMsg,
      this.obscureText = false,
      this.onSuffixIconClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          TextField(
            obscureText: obscureText,
            keyboardType: type,
            onChanged: onChange,
            textInputAction: inputAction,
            decoration: InputDecoration(
              labelText: text,
              labelStyle: const TextStyle(
                color: Colors.white,
              ),
              floatingLabelStyle: const TextStyle(
                color: Colors.white,
              ),
              fillColor: fillColor,
              prefixIcon: Icon(icon, color: Colors.white),
              filled: true,
              suffixIcon: GestureDetector(
                onTap: onSuffixIconClick,
                child: Icon(
                  suffixIcon,
                  size: 24.0,
                  color: Colors.white,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.white),
              ),
              errorText: errorMsg,
              errorBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.redAccent),
              )
            ),
          ),
        ],
      ),
    );
  }
}
