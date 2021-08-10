import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tikweb_test_app/config/api-urls.dart';
import 'package:tikweb_test_app/controllers/global-controller.dart';
import 'package:tikweb_test_app/models/api-models/userlist-api.dart';
import 'package:tikweb_test_app/models/user.dart';
import 'package:tikweb_test_app/services/api-service.dart';

class UsersController extends GetxController {
  ApiService apiService = ApiService();
  List<User> userList = [];
  List<User> unfilteredUsers = [];
  bool isLoading = true;
  bool commonLoader = false;

  @override
  void onInit() {
    this.getUserList();
    super.onInit();
  }

  @override
  void onClose() {
    isLoading = true;
    commonLoader = false;
    userList = [];
    unfilteredUsers = [];
    super.onClose();
  }

  getUserList() {
    apiService.getRequest(endPoint: ApiUrl.userList).then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        UserListApi userListApi = UserListApi.fromJson(jsonResponse['response']);
        if (userListApi != null && userListApi.userList.length > 0) {
          userList = [];
          unfilteredUsers = [];
          userList.addAll(userListApi.userList);
          unfilteredUsers = userList;
          update();
        }
        isLoading = false;
        commonLoader = false;
        update();
      } else {
        isLoading = false;
        commonLoader = false;
        update();
      }
    });
  }

  searchUser({String text}) {
    if (text.length > 0) {
      List<User> filteredData = [];
      for (int i = 0; i < unfilteredUsers.length; i++) {
        String userName = unfilteredUsers[i].name.toString().toLowerCase();
        String email = unfilteredUsers[i].email.toString().toLowerCase();
        if (userName.contains(text.toLowerCase()) || email.contains(text.toLowerCase())) {
          filteredData.add(unfilteredUsers[i]);
        }
      }
      userList = filteredData;
      update();
    } else {
      userList = unfilteredUsers;
      update();
    }
  }

  checkUser({BuildContext context, User user, int index}) {
    Navigator.of(context).pop();
    String owner = Get.put(GlobalController()).userId;
    if (user.id.toString() == owner) {
      Get.rawSnackbar(message: 'Oops!! You can not delete your own account');
    } else {
      deleteUser(context: context, user: user, index: index);
    }
  }

  deleteUser({BuildContext context, User user, int index}) {
    commonLoader = true;
    update();
    apiService.getRequest(endPoint: ApiUrl.userDelete + user.id.toString()).then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        if (jsonResponse['meta']['status'] == 200) {
          userList.remove(user);
          update();
        } else {
          Get.rawSnackbar(message: 'Something went wrong!! Please try again.');
        }
        commonLoader = false;
        update();
      } else {
        commonLoader = false;
        update();
      }
    });
  }

  replaceUsers({List<User> users}) {
    userList = [];
    userList.addAll(users);
    unfilteredUsers = userList;
    update();
  }
}
