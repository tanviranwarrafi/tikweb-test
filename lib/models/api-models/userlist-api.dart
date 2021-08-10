import 'package:tikweb_test_app/models/user.dart';

class UserListApi {
  List<User> userList;
  String message;

  UserListApi({this.userList, this.message});

  UserListApi.fromJson(Map<String, dynamic> json) {
    if (json['user_list'] != null) {
      userList = new List<User>();
      json['user_list'].forEach((v) {
        userList.add(new User.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userList != null) {
      data['user_list'] = this.userList.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}
