import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_application/gen/assets.gen.dart';
import 'package:gym_application/models/errors_type.dart';
import 'package:gym_application/ui/custom_widget/custom_background.dart';
import 'package:gym_application/ui/custom_widget/custom_button.dart';
import 'package:gym_application/ui/custom_widget/custom_input.dart';
import 'package:gym_application/ui/custom_widget/custom_text.dart';
import 'package:gym_application/ui/register/register_viewmodel.dart';
import 'package:gym_application/utils/languages_translator.dart';

class RegisterPage extends GetWidget<RegisterViewModel> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          children: [
            CustomBackground(size: size),
            Positioned(
              left: 0,
              right: 0,
              top: size.height * 0.34,
              child: Image.asset(
                Assets.images.backgroundImage.path,
                height: size.height * 0.35,
              ),
            ),
            Positioned(
              top: size.height * 0.24,
              left: size.width * 0.1,
              right: size.width * 0.1,
              child: Obx(
                () => Container(
                  height: controller.errors.id == -1
                      ? // -1 is empty errors bag
                      size.height * 0.65
                      : size.height * 0.72,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(190),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.065,
                      ),
                      CustomText(
                        text: Keys.REGISER.name.tr,
                        color: Colors.black.withAlpha(140),
                        fontSize: 31,
                        fontWeight: FontWeight.bold,
                        alignment: Alignment.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => CustomInput(
                          width: size.width * 0.72,
                          inputAction: TextInputAction.next,
                          onChange: controller.onNameChange,
                          text: Keys.Name.name.tr,
                          type: TextInputType.text,
                          errorMsg: controller.errors.name?.first,
                          fillColor: Colors.grey.withAlpha(119),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => CustomInput(
                          width: size.width * 0.72,
                          inputAction: TextInputAction.next,
                          onChange: controller.onPhoneChange,
                          text: Keys.Phone.name.tr,
                          type: TextInputType.phone,
                          errorMsg: controller.errors.phone?.first,
                          fillColor: Colors.grey.withAlpha(119),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => CustomInput(
                          width: size.width * 0.72,
                          inputAction: TextInputAction.next,
                          onChange: controller.onEmailChange,
                          text: Keys.Email.name.tr,
                          type: TextInputType.emailAddress,
                          errorMsg: controller.errors.email?.first,
                          fillColor: Colors.grey.withAlpha(119),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => CustomInput(
                          width: size.width * 0.72,
                          onChange: controller.onPasswordChange,
                          text: Keys.Password.name.tr,
                          obscureText: controller.passwordState,
                          suffixIcon: controller.passwordState
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onSuffixIconClick: controller.toggleState,
                          errorMsg: controller.errors.password?.first,
                          fillColor: Colors.grey.withAlpha(119),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => Column(
                          children: [
                            CustomButton2(
                              text: Keys.REGISER.name.tr,
                              onPressed: controller.registerButtonCLicked,
                              backgroundColor: const Color(0xFF7D7AE5),
                              width: size.width * 0.4,
                              height: 45,
                              hasBorder: false,
                              fontColor: Colors.white,
                              disable: controller.loginState,
                            ),
                            const SizedBox(height: 20),
                            controller.loginState
                                ? const SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator(
                                      color: Color(0xFF7D7AE5),
                                    ),
                                  )
                                : const SizedBox(
                                    width: 25,
                                    height: 25,
                                  )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
