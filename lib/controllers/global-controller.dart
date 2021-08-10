import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tikweb_test_app/screens/splash-screen.dart';
import 'package:tikweb_test_app/services/user-service.dart';

class GlobalController extends GetxController {
  UserService userService = UserService();
  bool isUser = false;
  String userId;

  initController() async {
    final validUser = await userService.loginCheck();
    isUser = validUser;
    log('global isUser>>>>>>>>>>>>>: $isUser');
    update();
    if (isUser) {
      final myId = await userService.getUserId();
      userId = myId;
      update();
    }
  }

  userLogout({BuildContext context}) async {
    await userService.removeSharedPreferenceData();
    isUser = false;
    update();
    Get.offAll(() => SplashScreen());
  }
}
