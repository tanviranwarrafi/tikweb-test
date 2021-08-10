import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tikweb_test_app/config/api-urls.dart';
import 'package:tikweb_test_app/controllers/global-controller.dart';
import 'package:tikweb_test_app/models/user.dart';
import 'package:tikweb_test_app/screens/landing-screen.dart';
import 'package:tikweb_test_app/services/api-service.dart';
import 'package:tikweb_test_app/services/user-service.dart';

class LoginController extends GetxController {
  ApiService apiService = ApiService();
  UserService userService = UserService();
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: '_LoginFormState');
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool obscureText = false;
  bool isLoading = false;

  @override
  void onInit() {
    isLoading = false;
    super.onInit();
  }

  @override
  void onClose() {
    isLoading = false;
    email.clear();
    password.clear();
    super.onClose();
  }

  showPassword() {
    obscureText = !obscureText;
    update();
  }

  loginOnTap({BuildContext context}) {
    if (formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      formKey.currentState.save();
      isLoading = true;
      update();
      Map body = {'email': email.text, 'password': password.text};
      String encodedBody = json.encode(body);
      apiService.postRequest(endPoint: ApiUrl.login, body: encodedBody).then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          if (jsonResponse['meta']['status'] != 100) {
            User user = User.fromJson(jsonResponse['response']['user']);
            userService.saveBoolean(key: 'is-user', value: true);
            userService.saveString(key: 'user-id', value: user.id.toString());
            Get.put(GlobalController()).initController();
            Get.to(() => LandingScreen());
          } else {
            Get.rawSnackbar(message: 'Incorrect email or password!! Please try again.');
          }
          isLoading = false;
          update();
        } else {
          isLoading = false;
          update();
        }
      });
    }
  }
}
