import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePick {
  static Future<File?> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage == null) return null;

    return File(pickedImage.path);
  }
}
