import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageService {
  /*getImageFileFromAssets({Asset imageAsset}) async {
    final filePath = await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);
    File tempFile = File(filePath);
    return tempFile;
  }*/

  Future<String> networkImageToBase64({String imageUrl}) async {
    http.Response response = await http.get(imageUrl);
    final bytes = response?.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }

  Future<File> fileFromImageUrl({String imageUrl, int index}) async {
    final response = await http.get(imageUrl);
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File(join(documentDirectory.path, 'myStoreShop$index.png'));
    file.writeAsBytesSync(response.bodyBytes);
    return file;
  }

  cropImage({File image}) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 1000, ratioY: 1000),
      maxHeight: 625,
      maxWidth: 1000,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true),
      iosUiSettings: IOSUiSettings(
        title: 'Cropper',
      ),
    );
    return croppedFile;
  }

  /*selectMultipleImages({BuildContext context}) async {
    List<Asset> resultList = [];
    try {
      resultList = await MultiImagePicker.pickImages(
        // maxImages: 10 - sliderImages.length,
        maxImages: 10,
        enableCamera: false,
        // selectedAssets: demoSliders,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#4CAF50",
          actionBarTitle: "Task Manager",
          allViewTitle: "All Photos",
          autoCloseOnSelectionLimit: true,
          lightStatusBar: true,
          statusBarColor: "#4CAF50",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      print(e);
    }
    List<Asset> selectedImages = resultList;
    if (selectedImages != null && selectedImages.length > 0) {
      List<File> imageFiles = [];
      for (int i = 0; i < selectedImages.length; i++) {
        imageFiles.add(await getImageFileFromAssets(imageAsset: selectedImages[i]));
      }
      return imageFiles;
    } else {
      Navigator.pop(context);
    }
  }*/
}
