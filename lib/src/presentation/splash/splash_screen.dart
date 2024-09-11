import 'package:snap_share_application/src/core/utils/app_colors.dart';
import 'package:snap_share_application/src/core/utils/styles.dart';
import 'package:snap_share_application/src/presentation/splash/splash_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldbg,
          body: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Text(
                "SnapShare App",
                style: robotoBold.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: 30,
                  height: 2,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )),
        );
      },
    );
  }
}
