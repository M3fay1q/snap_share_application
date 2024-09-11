import 'package:snap_share_application/src/config/routes/app_routes.dart';

import 'package:snap_share_application/src/presentation/home_screen/home_bindings.dart';
import 'package:snap_share_application/src/presentation/home_screen/home_screen.dart';
import 'package:snap_share_application/src/presentation/home_screen/widget/home_screen_photo_view.dart';
import 'package:snap_share_application/src/presentation/sign_in/sign_in_bindings.dart';
import 'package:snap_share_application/src/presentation/sign_in/sign_in_screen.dart';
import 'package:snap_share_application/src/presentation/sign_up/sign_up_bindings.dart';
import 'package:snap_share_application/src/presentation/sign_up/sign_up_screen.dart';

import 'package:snap_share_application/src/presentation/splash/spalsh_binding.dart';
import 'package:snap_share_application/src/presentation/splash/splash_screen.dart';
import 'package:get/get.dart';

class Routes {
  static List<GetPage> getAllPages() {
    return [
      GetPage(
        name: AppRoutes.spalshScreen,
        binding: SpalshBinding(),
        page: () => const SplashScreen(),
      ),
      GetPage(
        name: AppRoutes.homeScreen,
        binding: HomeBindings(),
        page: () => HomeScreen(),
      ),
      GetPage(
        name: AppRoutes.signUpScreen,
        binding: SignUpBindings(),
        page: () => const SignUpScreen(),
      ),
      GetPage(
        name: AppRoutes.signInScreen,
        binding: SignInBindings(),
        page: () => const SignInScreen(),
      ),
      GetPage(
        name: AppRoutes.homeScreenPhotoView,
        binding: HomeBindings(),
        page: () {
          final imageUrls = Get.parameters['imageUrl'] ?? '';
          return HomeScreenPhotoView(
            imageUrls,
          );
        },
      )
    ];
  }
}
