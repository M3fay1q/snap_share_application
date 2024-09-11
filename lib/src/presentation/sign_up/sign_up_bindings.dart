import 'package:get/get.dart';
import 'package:snap_share_application/src/presentation/sign_up/sign_up_controller.dart';

class SignUpBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(
      () => SignUpController(),
    );
  }
}
