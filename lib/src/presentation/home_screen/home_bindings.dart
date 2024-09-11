import 'package:snap_share_application/src/presentation/home_screen/home_controller.dart';
import 'package:get/get.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
