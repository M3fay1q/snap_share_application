import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:snap_share_application/src/config/routes/app_routes.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;
  List<String> imageUrls = [];

  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ImagePicker picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    loadImages();
  }

  Future<void> loadImages() async {
    isLoading = true;
    update();
    String userId = FirebaseAuth.instance.currentUser?.uid ?? 'unknown_user';
    QuerySnapshot snapshot = await firestore
        .collection('images')
        .where('userId', isEqualTo: userId)
        .get();
    imageUrls = snapshot.docs.map((doc) => doc['url'] as String).toList();
    log(imageUrls.toList().toString());
    isLoading = false;
    update();
  }

  Future<void> pickImage(ImageSource img) async {
    final XFile? image = await picker.pickImage(source: img);

    if (image != null) {
      final Uint8List? compressedImage = await _compressImage(File(image.path));
      if (compressedImage != null) {
        bool imageExists = await _checkImageExists(image.name);
        if (imageExists) {
          bool shouldUploadAgain = await _showImageExistsDialog();
          if (shouldUploadAgain) {
            isLoading = true;
            update();
            String newFileName = _generateNewFileName(image.name);
            await _uploadImage(compressedImage, newFileName);
          }
        } else {
          isLoading = true;
          update();
          await _uploadImage(compressedImage, image.name);
        }
      }
    }
  }

  Future<bool> _checkImageExists(String fileName) async {
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? 'unknown_user';
      Reference storageRef = storage.ref().child('uploads/$userId/$fileName');
      // Try to get the download URL to check if the image exists
      await storageRef.getDownloadURL();
      return true; // Image exists
    } catch (e) {
      return false; // Image does not exist
    }
  }

  String _generateNewFileName(String originalFileName) {
    String fileNameWithoutExtension = originalFileName.split('.').first;
    String fileExtension = originalFileName.split('.').last;
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    return '$fileNameWithoutExtension-$timestamp.$fileExtension';
  }

  Future<Uint8List?> _compressImage(File imageFile) async {
    final compressedImage = await FlutterImageCompress.compressWithFile(
      imageFile.absolute.path,
      minWidth: 800,
      minHeight: 800,
      quality: 70,
    );
    return compressedImage;
  }

  Future<void> _uploadImage(Uint8List imageBytes, String fileName) async {
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? 'unknown_user';
      Reference storageRef = storage.ref().child('uploads/$userId/$fileName');
      UploadTask uploadTask = storageRef.putData(imageBytes);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        print(
            'Upload progress: ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
      });

      await uploadTask.whenComplete(() async {
        String downloadURL = await storageRef.getDownloadURL();
        print('Download URL: $downloadURL');

        await firestore.collection('images').add({
          'url': downloadURL,
          'userId': userId,
        });
        loadImages();
      });
    } catch (e) {
      isLoading = true;
      update();
      log(e.toString());
      Get.snackbar(
        "Error",
        'Failed to Upload the image. Please try again',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(6),
      );
    }
  }

  Future<void> shareImage(String imageUrl) async {
    try {
      final directory = await getTemporaryDirectory();
      final imagePath =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final File imageFile = File(imagePath);

      final Reference storageRef =
          FirebaseStorage.instance.refFromURL(imageUrl);
      final DownloadTask downloadTask = storageRef.writeToFile(imageFile);

      await downloadTask.whenComplete(() {
        print('Download complete');
      });

      Share.shareXFiles([XFile(imageFile.path)], text: 'Check out this image!');
    } catch (e) {
      log(e.toString());
      Get.snackbar(
        "Error",
        'Failed to share image. Please try again',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(8),
      );
    }
  }

  Future<void> logout() async {
    await auth.signOut();
    imageUrls = [];
    Get.offNamed(AppRoutes.signInScreen);
  }

  Future<bool> _showImageExistsDialog() async {
    return await Get.dialog<bool>(
          AlertDialog(
            title: const Text('Image Already Exists'),
            content: const Text(
                'This image is already in the storage. Do you want to upload it again?'),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () {
                    pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
