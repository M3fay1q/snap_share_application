import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:snap_share_application/src/presentation/home_screen/home_controller.dart';

class HomeScreenPhotoView extends GetView<HomeController> {
  final String imageUrls;
  const HomeScreenPhotoView(this.imageUrls, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PhotoView(
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        imageProvider: NetworkImage(imageUrls),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2,
      ),
    );
  }
}
