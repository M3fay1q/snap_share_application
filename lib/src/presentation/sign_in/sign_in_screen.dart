import 'package:snap_share_application/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:snap_share_application/src/presentation/sign_in/sign_in_controller.dart';
import 'package:snap_share_application/src/presentation/sign_in/widget/sign_in_screen_view.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});

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
      body: const SafeArea(child: SignInScreenView()),
    );
  }
}
