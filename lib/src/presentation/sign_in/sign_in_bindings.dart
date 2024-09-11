import 'package:get/get.dart';
import 'package:snap_share_application/src/presentation/sign_in/sign_in_controller.dart';

class SignInBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(
      () => SignInController(),
    );
  }
}
