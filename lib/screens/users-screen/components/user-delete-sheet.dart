import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tikweb_test_app/components/custom-button.dart';
import 'package:tikweb_test_app/controllers/users-controller.dart';
import 'package:tikweb_test_app/models/user.dart';
import 'package:tikweb_test_app/utils/constraints.dart';
import 'package:tikweb_test_app/utils/size-config.dart';

void userDeleteSheet({BuildContext context, User user, int index}) {
  var width = SizeConfig.screenWidth;
  var height = SizeConfig.screenHeight;
  var block = SizeConfig.block;
  showModalBottomSheet(
    backgroundColor: white,
    context: context,
    elevation: 5,
    isDismissible: true,
    isScrollControlled: true,
    builder: (context) => GetBuilder<UsersController>(
      init: UsersController(),
      builder: (users) => Container(
        width: width,
        height: height * 0.25,
        padding: EdgeInsets.all(block * 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Are you sure to delete ${user.name}?', style: TextStyle(fontSize: block * 5)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: width, height: block / 2, color: grey100),
                SizedBox(height: block * 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      width: width / 2.5,
                      title: 'Cancel',
                      padding: block * 2.8,
                      background: Color(0xFFE0E0E0),
                      borderRadius: block * 2,
                      fontColor: white,
                      fontSize: block * 4,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    CustomButton(
                        width: width / 2.5,
                        title: 'Remove',
                        padding: block * 2.8,
                        background: Color(0xFFF49D9D),
                        borderRadius: block * 2,
                        fontColor: white,
                        fontSize: block * 4,
                        onTap: () => users.checkUser(context: context, user: user, index: index)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
