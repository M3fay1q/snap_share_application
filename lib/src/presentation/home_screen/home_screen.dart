import 'package:snap_share_application/src/core/utils/app_colors.dart';
import 'package:snap_share_application/src/core/utils/dimensions.dart';
import 'package:snap_share_application/src/core/utils/styles.dart';
import 'package:snap_share_application/src/presentation/home_screen/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:snap_share_application/src/presentation/home_screen/widget/home_screen_view.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldbg,
      appBar: AppBar(
        leadingWidth: 30,
        title: Text("SnapShare App",
            style: robotoMedium.copyWith(
                color: Theme.of(context).primaryColor,
                fontSize: Dimensions.fontSizeExtraLarge)),
        backgroundColor: AppColors.scaffoldbg,
        elevation: 0,
        leading: Icon(
          Icons.image_outlined,
          color: Theme.of(context).primaryColor,
          size: 30,
        ).paddingOnly(
          left: 10,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              controller.logout();
            },
            child: Row(
              children: [
                Text(
                  "Logout",
                  style: robotoMedium.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: Dimensions.fontSizeDefault),
                ),
                Icon(
                  Icons.logout,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                )
              ],
            ),
          )
        ],
      ),
      body: const SafeArea(child: HomeScreenView()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.showPicker(context);
        },
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
