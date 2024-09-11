import 'package:snap_share_application/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:snap_share_application/src/presentation/sign_up/sign_up_controller.dart';
import 'package:snap_share_application/src/presentation/sign_up/widget/sign_up_screen_view.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldbg,
      // appBar: AppBar(
      //     toolbarHeight: 50,
      //     leading: IconButton(
      //       onPressed: () => Get.back(),
      //       icon: Icon(Icons.arrow_back,
      //           color: Theme.of(context).textTheme.bodyLarge!.color),
      //     ),
      //     elevation: 0,
      //     backgroundColor: Colors.transparent),
      body: const SafeArea(child: SignUpScreenView()),
    );
  }
}
