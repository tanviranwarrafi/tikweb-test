import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tikweb_test_app/components/loaders/circle-loader.dart';
import 'package:tikweb_test_app/components/not-found.dart';
import 'package:tikweb_test_app/components/text-field-materials.dart';
import 'package:tikweb_test_app/controllers/users-controller.dart';
import 'package:tikweb_test_app/screens/add-user-screen.dart';
import 'package:tikweb_test_app/screens/user-details-screen.dart';
import 'package:tikweb_test_app/screens/users-screen/components/user-card.dart';
import 'package:tikweb_test_app/screens/users-screen/components/user-delete-sheet.dart';
import 'package:tikweb_test_app/utils/constraints.dart';
import 'package:tikweb_test_app/utils/images.dart';
import 'package:tikweb_test_app/utils/size-config.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final controller = Get.put(UsersController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;
    return GetBuilder<UsersController>(
      init: UsersController(),
      builder: (users) => Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: white,
          centerTitle: true,
          title: Text('Users List', style: TextStyle(color: black)),
        ),
        body: users.isLoading
            ? Container(
                height: height,
                width: width,
                color: white,
                child: Center(child: CircleLoader()),
              )
            : Stack(
                children: [
                  Container(
                    height: height,
                    width: width,
                    color: white,
                    padding: EdgeInsets.all(block * 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(Images.userNav, width: block * 10, height: block * 10, color: grey),
                                SizedBox(height: block),
                                Text('Total User', style: TextStyle(fontSize: block * 4, fontWeight: FontWeight.bold)),
                                SizedBox(height: block),
                                Text(
                                  users.userList.length.toString(),
                                  style: TextStyle(fontSize: block * 4.5, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () => Get.to(() => AddUserScreen()),
                              child: Container(
                                padding: EdgeInsets.all(block * 2),
                                decoration: BoxDecoration(color: black, borderRadius: BorderRadius.circular(block * 2)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: block * 2),
                                    SvgPicture.asset(Images.userNav, height: block * 3, width: block * 3, color: white),
                                    SizedBox(width: block * 2),
                                    Text('Add New User', style: TextStyle(color: white)),
                                    SizedBox(width: block * 2),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: block * 2.5),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: black,
                          style: labelStyle(color: black),
                          decoration: InputDecoration(
                            hintText: 'Search',
                            filled: true,
                            fillColor: Color(0xFFECECEC),
                            hintStyle: hintStyle(color: grey),
                            labelStyle: labelStyle(color: black),
                            errorStyle: errorStyle(color: red),
                            prefixIcon: Icon(Icons.search, color: grey),
                            contentPadding: EdgeInsets.fromLTRB(block * 5, block * 2.5, block * 5, block * 2.5),
                            border: outlineBorder(radius: block, color: transparent, width: 2),
                            enabledBorder: outlineBorder(radius: block * 2, color: transparent, width: 2),
                            focusedBorder: outlineBorder(radius: block * 2, color: transparent, width: 2),
                            errorBorder: outlineBorder(radius: block * 2, color: red, width: 1.5),
                            focusedErrorBorder: outlineBorder(radius: block * 2, color: red, width: 1.5),
                          ),
                          onEditingComplete: () => FocusScope.of(context).unfocus(),
                          onChanged: (text) => controller.searchUser(text: text),
                        ),
                        SizedBox(height: block * 2.5),
                        Expanded(
                          child: users.userList.length < 1
                              ? NotFound(title: 'Oops!! No User Found', image: Images.user)
                              : ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  padding: EdgeInsets.zero,
                                  itemCount: users.userList.length,
                                  primary: false,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return UserCard(
                                      listIndex: index,
                                      listLength: users.userList.length,
                                      user: users.userList[index],
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        Get.to(() => UserDetailsScreen(userId: users.userList[index].id.toString()));
                                      },
                                      onDelete: () {
                                        FocusScope.of(context).unfocus();
                                        userDeleteSheet(context: context, user: users.userList[index], index: index);
                                      },
                                    );
                                  }),
                        ),
                      ],
                    ),
                  ),
                  users.commonLoader
                      ? Positioned(
                          child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white60,
                              child: Center(child: CircleLoader())),
                        )
                      : SizedBox.shrink(),
                ],
              ),
      ),
    );
  }
}
