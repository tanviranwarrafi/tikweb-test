import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tikweb_test_app/components/custom-button.dart';
import 'package:tikweb_test_app/components/loaders/circle-loader.dart';
import 'package:tikweb_test_app/components/text-field-materials.dart';
import 'package:tikweb_test_app/components/user-image.dart';
import 'package:tikweb_test_app/controllers/add-user-controller.dart';
import 'package:tikweb_test_app/screens/authentication/components/gender-item.dart';
import 'package:tikweb_test_app/services/validators.dart';
import 'package:tikweb_test_app/utils/constraints.dart';
import 'package:tikweb_test_app/utils/size-config.dart';

class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  Validators validators = Validators();
  final controller = Get.put(AddUserController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;
    return GetBuilder<AddUserController>(
      init: AddUserController(),
      builder: (addUser) => Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: white,
          centerTitle: true,
          title: Text('Add New User', style: TextStyle(color: black)),
        ),
        body: Stack(
          children: [
            Container(
              width: width,
              height: height,
              color: white,
              padding: EdgeInsets.all(block * 4),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: block * 4),
                    Center(child: UserImage(selectedImage: addUser.selectedImage, onTap: () => controller.selectProfileImage())),
                    SizedBox(height: block * 4),
                    Form(
                      key: addUser.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: controller.name,
                            keyboardType: TextInputType.name,
                            cursorColor: black,
                            style: labelStyle(color: black),
                            decoration: InputDecoration(
                              hintText: 'Name',
                              hintStyle: hintStyle(color: grey),
                              labelStyle: labelStyle(color: black),
                              errorStyle: errorStyle(color: red),
                              contentPadding: EdgeInsets.fromLTRB(block * 5, block * 2.5, block * 5, block * 2.5),
                              border: outlineBorder(radius: block, color: null, width: 2),
                              enabledBorder: outlineBorder(radius: block * 2, color: null, width: 2),
                              focusedBorder: outlineBorder(radius: block * 2, color: null, width: 2),
                              errorBorder: outlineBorder(radius: block * 2, color: red, width: 1.5),
                              focusedErrorBorder: outlineBorder(radius: block * 2, color: red, width: 1.5),
                            ),
                            onEditingComplete: () => FocusScope.of(context).unfocus(),
                            validator: (text) => validators.validateName(value: text),
                            onSaved: (text) => controller.name.text = text,
                          ),
                          SizedBox(height: block * 3),
                          TextFormField(
                            controller: controller.email,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: black,
                            style: labelStyle(color: black),
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: hintStyle(color: grey),
                              labelStyle: labelStyle(color: black),
                              errorStyle: errorStyle(color: red),
                              contentPadding: EdgeInsets.fromLTRB(block * 5, block * 2.5, block * 5, block * 2.5),
                              border: outlineBorder(radius: block, color: null, width: 2),
                              enabledBorder: outlineBorder(radius: block * 2, color: null, width: 2),
                              focusedBorder: outlineBorder(radius: block * 2, color: null, width: 2),
                              errorBorder: outlineBorder(radius: block * 2, color: red, width: 1.5),
                              focusedErrorBorder: outlineBorder(radius: block * 2, color: red, width: 1.5),
                            ),
                            onEditingComplete: () => FocusScope.of(context).unfocus(),
                            validator: (text) => validators.validateEmail(value: text),
                            onSaved: (text) => controller.email.text = text,
                          ),
                          SizedBox(height: block * 3),
                          TextFormField(
                            controller: controller.password,
                            obscureText: addUser.showPassword,
                            cursorColor: black,
                            style: labelStyle(color: black),
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: hintStyle(color: grey),
                              labelStyle: labelStyle(color: black),
                              errorStyle: errorStyle(color: red),
                              suffixIcon: InkWell(
                                onTap: () => controller.passwordVisibility(),
                                splashColor: null,
                                child: addUser.showPassword
                                    ? Icon(Icons.visibility_rounded, color: Colors.grey[600])
                                    : Icon(Icons.visibility_off_rounded, color: Colors.grey[600]),
                              ),
                              contentPadding: EdgeInsets.fromLTRB(block * 5, block * 2.5, block * 5, block * 2.5),
                              border: outlineBorder(radius: block, color: null, width: 2),
                              enabledBorder: outlineBorder(radius: block, color: null, width: 2),
                              focusedBorder: outlineBorder(radius: block, color: null, width: 2),
                              errorBorder: outlineBorder(radius: block * 2, color: red, width: 1.5),
                              focusedErrorBorder: outlineBorder(radius: block * 2, color: red, width: 1.5),
                            ),
                            onEditingComplete: () => FocusScope.of(context).requestFocus(FocusNode()),
                            validator: (text) => validators.validatePassword(value: text),
                            onSaved: (text) => controller.password.text = text,
                          ),
                          SizedBox(height: block * 3),
                          TextFormField(
                            controller: controller.phone,
                            keyboardType: TextInputType.phone,
                            cursorColor: black,
                            style: labelStyle(color: black),
                            decoration: InputDecoration(
                              hintText: 'Mobile Number',
                              hintStyle: hintStyle(color: grey),
                              labelStyle: labelStyle(color: black),
                              errorStyle: errorStyle(color: red),
                              contentPadding: EdgeInsets.fromLTRB(block * 5, block * 2.5, block * 5, block * 2.5),
                              border: outlineBorder(radius: block, color: null, width: 2),
                              enabledBorder: outlineBorder(radius: block * 2, color: null, width: 2),
                              focusedBorder: outlineBorder(radius: block * 2, color: null, width: 2),
                              errorBorder: outlineBorder(radius: block * 2, color: red, width: 1.5),
                              focusedErrorBorder: outlineBorder(radius: block * 2, color: red, width: 1.5),
                            ),
                            onEditingComplete: () => FocusScope.of(context).unfocus(),
                            validator: (text) => validators.validatePhone(value: text),
                            onSaved: (text) => controller.phone.text = text,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: block * 4),
                    Text('Gender', style: TextStyle(fontWeight: FontWeight.w500, fontSize: block * 4.5)),
                    SizedBox(height: block * 2.5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GenderItem(
                          title: 'Male',
                          selectedItem: addUser.selectedGender,
                          onTap: () => addUser.selectGenderOnTap(gender: 'Male'),
                        ),
                        SizedBox(width: block * 2.5),
                        GenderItem(
                          title: 'Female',
                          selectedItem: addUser.selectedGender,
                          onTap: () => addUser.selectGenderOnTap(gender: 'Female'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            addUser.isLoading
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
        bottomNavigationBar: Container(
          margin: EdgeInsets.all(block * 4),
          child: CustomButton(
            title: 'Save',
            padding: block * 2.8,
            background: black,
            borderRadius: block * 2,
            fontColor: white,
            fontSize: block * 4,
            onTap: () => controller.addUserOnTap(context: context),
          ),
        ),
      ),
    );
  }
}
