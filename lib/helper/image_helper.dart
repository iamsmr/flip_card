import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static Future<File?> pickImageFromGallery({
    required BuildContext context,
    required CropStyle cropStyle,
    required String title,
  }) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final cropedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        cropStyle: cropStyle,

        androidUiSettings: AndroidUiSettings(
          showCropGrid: true,

          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          toolbarTitle: "",
          hideBottomControls: true,

          // toolbarTitle: title,
          // toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        iosUiSettings: const IOSUiSettings(),
        compressQuality: 70,
      );

      return cropedFile;
    }
  }
}
