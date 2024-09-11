import 'package:firebase_core/firebase_core.dart';
import 'package:snap_share_application/src/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'src/config/routes/get_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: null,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.topLevel,
      title: "SnapShare App",
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.spalshScreen,
      getPages: Routes.getAllPages(),
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1),
            ),
            child: child!);
      },
    );
  }
}
