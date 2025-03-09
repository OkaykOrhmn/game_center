import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class PickFile {
  static Future<PlatformFile?> pickExeFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['exe'],
    );

    if (result != null) {
      // Handle the picked file
      PlatformFile file = result.files.first;
      if (kDebugMode) {
        print('Picked file: ${file.path}');
      }
      return file;
    } else {
      // User canceled the picker
      if (kDebugMode) {
        print('No file selected');
      }
    }
    return null;
  }

  static Future<PlatformFile?> pickImageFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      // Handle the picked file
      PlatformFile file = result.files.first;
      if (kDebugMode) {
        print('Picked image file: ${file.path}');
      }
      return file;
    } else {
      // User canceled the picker
      if (kDebugMode) {
        print('No image file selected');
      }
    }
    return null;
  }
}
