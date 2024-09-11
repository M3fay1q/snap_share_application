import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:snap_share_application/src/config/routes/app_routes.dart';

class SignUpController extends GetxController {
  late TextEditingController emailController, passwordController;
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> registerWithEmail(String email, String password) async {
    if (!validateData()) {
      return;
    }
    isLoading = true;
    update();
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      isLoading = false;
      update();
      Get.offNamed(AppRoutes.signInScreen);
      Get.snackbar('Success', 'Registration successful',
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(6));
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      if (e.code == 'email-already-in-use') {
        errorMessage =
            "This email address is already in use. Please use different email address";
      } else {
        errorMessage = "An unexpected error occurred. Please try again.";
      }
      isLoading = false;
      update();
      Get.snackbar(
        "Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(6),
      );
    }
  }

  bool validateData() {
    bool isValid = true;

    if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter email Address',
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(6));
      isValid = false;
    } else if (!isValidEmail(emailController.text)) {
      Get.snackbar('Error', 'Please enter a valid email address',
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(6));
      isValid = false;
    } else if (passwordController.text.isEmpty) {
      Get.snackbar("Error!", "Please enter a password",
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(6));
      isValid = false;
    } else if (passwordController.text.length <= 6) {
      Get.snackbar("Error!", "Password should be greater than 6 characters",
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(6));
      isValid = false;
    }

    return isValid;
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
      multiLine: false,
    );
    return emailRegex.hasMatch(email);
  }
}
