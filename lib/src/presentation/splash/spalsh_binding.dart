import 'package:snap_share_application/src/presentation/splash/splash_controller.dart';
import 'package:get/get.dart';

class SpalshBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
  }
}
