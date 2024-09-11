import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:snap_share_application/src/config/routes/app_routes.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  AnimationController? animationController;
  FirebaseAuth auth = FirebaseAuth.instance;
  var user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();

    user.bindStream(auth.authStateChanges());

    animationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this)
          ..forward()
          ..addStatusListener(
            (status) {
              if (status == AnimationStatus.completed) {
                handleAuthChanged(user.value);
              }
            },
          );
  }

  void handleAuthChanged(User? user) {
    if (user == null) {
      Get.offNamed(AppRoutes.signInScreen);
    } else {
      Get.offNamed(AppRoutes.homeScreen);
    }
  }

  @override
  void onClose() {
    animationController?.dispose();
    super.onClose();
  }
}
