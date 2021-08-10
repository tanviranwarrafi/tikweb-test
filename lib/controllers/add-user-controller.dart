import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:tikweb_test_app/config/api-urls.dart';
import 'package:tikweb_test_app/controllers/users-controller.dart';
import 'package:tikweb_test_app/models/api-models/userlist-api.dart';
import 'package:tikweb_test_app/models/user.dart';
import 'package:tikweb_test_app/services/api-service.dart';
import 'package:tikweb_test_app/services/image-service.dart';

class AddUserController extends GetxController {
  ApiService apiService = ApiService();
  ImageService imageService = ImageService();
  ImagePicker picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  File selectedImage;
  String selectedGender;
  double latitude;
  double longitude;
  bool showPassword = true;
  bool isLoading = false;

  @override
  void onInit() {
    // getCurrentDateTime();
    getLocationData();
    print('init-forgot password');
    super.onInit();
  }

  @override
  void onClose() {
    name.clear();
    phone.clear();
    email.clear();
    password.clear();
    isLoading = false;
    showPassword = false;
    super.onClose();
  }

  passwordVisibility() {
    showPassword = !showPassword;
    update();
  }

  selectProfileImage() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery, maxHeight: 1000, maxWidth: 1000);
    if (pickedImage != null) {
      File selectedImageFile = File(pickedImage.path);
      File croppedImage = await imageService.cropImage(image: selectedImageFile);
      if (croppedImage != null) {
        selectedImage = croppedImage;
        update();
      } else {
        Get.rawSnackbar(message: 'Image not cropped');
      }
    } else {
      Get.rawSnackbar(message: 'No Image picked');
    }
  }

  selectGenderOnTap({String gender}) {
    selectedGender = gender;
    update();
  }

  /*getCurrentDateTime() {
    final now = new DateTime.now();
    selectedDate = DateFormat('yMd').format(now);
    selectedTime = DateFormat('HH:mm a').format(now);
    print(selectedDate);
    print(selectedTime);
    update();
  }*/

  getLocationData() async {
    Location location = new Location();
    LocationData locationData = await location.getLocation();
    latitude = locationData.latitude;
    longitude = locationData.longitude;
    print(latitude);
    print(longitude);
    update();
  }

  addUserOnTap({BuildContext context}) async {
    if (formKey.currentState.validate()) {
      if (selectedImage != null) {
        if (selectedGender != null) {
          if (latitude == null || longitude == null) {
            getLocationData();
            Get.rawSnackbar(message: 'Getting location data. Please try again');
          } else {
            FocusScope.of(context).unfocus();
            formKey.currentState.save();
            multipartRequest();
          }
        } else {
          Get.rawSnackbar(message: 'Please select your gender');
        }
      } else {
        Get.rawSnackbar(message: 'Please select your profile image');
      }
    }
  }

  multipartRequest() async {
    isLoading = true;
    update();
    Map<String, String> headers = {'Content-Disposition': 'form-data'};
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + ApiUrl.signUp));
    request.headers.addAll(headers);
    request.fields['name'] = name.text;
    request.fields['email'] = email.text;
    request.fields['latitude'] = latitude.toString();
    request.fields['longitude'] = longitude.toString();
    request.fields['gender'] = selectedGender == 'Male' ? '1' : '0';
    request.fields['phone'] = phone.text;
    request.fields['password'] = password.text;
    request.fields['password_confirmation'] = password.text;
    request.files.add(
      http.MultipartFile(
        'profile_image',
        selectedImage.readAsBytes().asStream(),
        selectedImage.lengthSync(),
        filename: selectedImage.path.split("/").last,
      ),
    );
    var res = await request.send();
    res.stream.transform(utf8.decoder).listen((response) async {
      if (response != null) {
        final jsonResponse = json.decode(response);
        print(jsonResponse);
        if (jsonResponse['meta']['status'] != 100) {
          getUserList();
        } else {
          Get.rawSnackbar(message: jsonResponse['response']['message']);
        }
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
        Get.rawSnackbar(message: 'Something went wrong!! Please try again.');
      }
    });
  }

  getUserList() {
    apiService.getRequest(endPoint: ApiUrl.userList).then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        UserListApi userListApi = UserListApi.fromJson(jsonResponse['response']);
        List<User> demoUsers = [];
        if (userListApi != null && userListApi.userList.length > 0) {
          demoUsers.addAll(userListApi.userList);
          Get.put(UsersController()).replaceUsers(users: demoUsers);
        }
        isLoading = false;
        update();
        Get.back();
      } else {
        isLoading = false;
        update();
      }
    });
  }
}
