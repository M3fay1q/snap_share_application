import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_share_application/src/config/routes/app_routes.dart';
import 'package:snap_share_application/src/core/utils/dimensions.dart';
import 'package:snap_share_application/src/core/utils/styles.dart';
import 'package:snap_share_application/src/core/widgets/custom_button.dart';
import 'package:snap_share_application/src/core/widgets/custom_text_field_widget.dart';
import 'package:snap_share_application/src/presentation/sign_in/sign_in_controller.dart';

class SignInScreenView extends GetView<SignInController> {
  const SignInScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(builder: (_) {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Container(
            width: context.width > 700 ? 700 : context.width,
            height: Get.height * 0.8,
            padding: context.width > 700
                ? const EdgeInsets.symmetric(horizontal: 150)
                : null,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 35),
              Text('Login',
                  style: robotoBold.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 32)),
              Text(
                'Please sign in to your account',
                style: robotoMedium.copyWith(
                    height: 1.5,
                    fontSize: Dimensions.subheadingfontSizeDefault,
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(.4)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 35),
              Text('Enter Your Email',
                  style: robotoMedium.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: Dimensions.fontSizeSmall)),
              const SizedBox(height: 15),
              CustomTextFieldWidget(
                hintText: 'Email',
                controller: controller.emailController,
                focusNode: controller.emailFocus,
                inputAction: TextInputAction.done,
                inputType: TextInputType.emailAddress,
                fillColor: Colors.transparent,
                onSubmit: (text) {
                  null;
                },
              ),
              const SizedBox(height: 20),
              Text('Enter Your Password'.tr,
                  style: robotoMedium.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: Dimensions.fontSizeSmall)),
              const SizedBox(height: 15),
              CustomTextFieldWidget(
                hintText: 'password'.tr,
                controller: controller.passwordController,
                focusNode: controller.passwordFocus,
                inputAction: TextInputAction.done,
                inputType: TextInputType.visiblePassword,
                isPassword: true,
                fillColor: Colors.transparent,
                onSubmit: (text) {
                  null;
                },
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Container(
                      width: 1170,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      child: CustomButton(
                          isLoading: controller.isLoading,
                          margin: const EdgeInsets.all(0),
                          height: 50,
                          width: 1170,
                          buttonText: 'Login',
                          isTextBlackColor: true,
                          onPressed: () {
                            controller.loginWithEmail(
                                controller.emailController.text,
                                controller.passwordController.text);
                          })),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.signUpScreen);
                    },
                    child: Text('Don\'t have an account? Register here.',
                        style: robotoMedium.copyWith(
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(0.8),
                            fontSize: Dimensions.fontSizeSmall)),
                  ),
                ],
              ),
            ]),
          ),
        ),
      );
    });
  }
}
