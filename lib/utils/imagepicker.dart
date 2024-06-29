import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

List<XFile>? images = [];
List<String> listImagesPath =[];
List<File> files = [];
String? imagePath = "";

void selectImage() async {
 final logger=Logger();
  bool status = false;
  try {
    if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      if (deviceInfo.version.sdkInt > 32) {
        status = await Permission.photos.request().isGranted;
      } else {
        status = await Permission.storage.request().isGranted;
      }
    } else if (Platform.isIOS) {
      status = await Permission.storage.request().isGranted;
    } else {
      // Handle other platforms
    }
    if (status) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.custom,
          allowedExtensions: ['bmp', 'gif', 'jpeg', 'jpg', 'png', 'heic', 'avi', 'flv', 'mkv', 'mov', 'mp4', 'mpeg', 'webm', 'wmv']
      );
      if(result!=null && result.files.isNotEmpty){
        PlatformFile file = result.files.first;
        imagePath = file.path;
        debugPrint("Permission  $imagePath");
        // for(PlatformFile file in result.files){
        //   logger.d("image path $file");
        //   listImagesPath.add(file.path!);
        // }
      }
    } else {
      debugPrint("Permission denied");
      // Handle permission denied scenario
    }
  } catch (e) {
    logger.e("error in image post in social page $e");
  }
}
