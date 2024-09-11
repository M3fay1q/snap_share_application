import 'package:snap_share_application/src/config/routes/app_routes.dart';
import 'package:snap_share_application/src/core/utils/dimensions.dart';
import 'package:snap_share_application/src/core/utils/styles.dart';
import 'package:snap_share_application/src/core/widgets/custom_shimmer_widget.dart';
import 'package:snap_share_application/src/presentation/home_screen/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_share_application/src/presentation/home_screen/widget/home_screen_photo_view.dart';

class HomeScreenView extends GetView<HomeController> {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return controller.isLoading == true
          ? const CustomShimmerWidget()
          : controller.imageUrls.isEmpty
              ? Center(
                  child: Text('No images added yet!',
                      style: robotoMedium.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: Dimensions.fontSizeSmall)),
                )
              : GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 columns
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      mainAxisExtent: 180),
                  itemCount: controller.imageUrls.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.homeScreenPhotoView,
                            parameters: {
                              'imageUrl': controller.imageUrls[index],
                            },
                          );
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                controller.imageUrls[index],
                                fit: BoxFit.cover,
                                height: 180,
                                width: double.infinity,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller
                                    .shareImage(controller.imageUrls[index]);
                              },
                              child: const Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.share),
                                  )),
                            ),
                          ],
                        ));
                  },
                );
    });
  }
}
