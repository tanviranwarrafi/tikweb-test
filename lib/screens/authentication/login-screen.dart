import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tikweb_test_app/components/custom-button.dart';
import 'package:tikweb_test_app/components/loaders/circle-loader.dart';
import 'package:tikweb_test_app/components/text-field-materials.dart';
import 'package:tikweb_test_app/controllers/login-controller.dart';
import 'package:tikweb_test_app/screens/authentication/signup-screen.dart';
import 'package:tikweb_test_app/services/validators.dart';
import 'package:tikweb_test_app/utils/constraints.dart';
import 'package:tikweb_test_app/utils/size-config.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Validators validators = Validators();
  final controller = Get.put(LoginController());

  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (login) => Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: InkWell(
            onTap: () => Get.back(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.arrow_back_ios_sharp, color: blue),
                Text('Back', style: TextStyle(color: blue)),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              width: width,
              height: height,
              color: white,
              padding: EdgeInsets.only(left: block * 5, right: block * 5),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: block * 15),
                    Text('Login', style: TextStyle(fontWeight: FontWeight.w500, fontSize: block * 6)),
                    SizedBox(height: block * 2.5),
                    Text(
                      'Enter your email address and password to access your account',
                      style: TextStyle(fontSize: block * 3.8, color: grey),
                    ),
                    SizedBox(height: block * 20),
                    Form(
                      key: login.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: controller.email,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            obscureText: false,
                            cursorColor: Colors.black,
                            style: labelStyle(color: black),
                            decoration: InputDecoration(
                              hintText: 'Email',
                              filled: true,
                              fillColor: Color(0xFFF2F2F7),
                              hintStyle: hintStyle(color: grey),
                              labelStyle: labelStyle(color: grey),
                              errorStyle: errorStyle(color: red),
                              contentPadding: EdgeInsets.fromLTRB(block * 5, block * 2.5, block * 5, block * 2.5),
                              border: outlineBorder(radius: block * 2, color: transparent, width: 2),
                              enabledBorder: outlineBorder(radius: block * 2, color: transparent, width: 2),
                              focusedBorder: outlineBorder(radius: block * 2, color: transparent, width: 2),
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
                            autofocus: false,
                            obscureText: login.obscureText,
                            cursorColor: Colors.black,
                            style: labelStyle(color: black),
                            decoration: InputDecoration(
                              hintText: 'Password',
                              filled: true,
                              fillColor: Color(0xFFF2F2F7),
                              hintStyle: hintStyle(color: grey),
                              labelStyle: labelStyle(color: black),
                              errorStyle: errorStyle(color: red),
                              suffixIcon: InkWell(
                                onTap: () => controller.showPassword(),
                                splashColor: null,
                                child: login.obscureText
                                    ? Icon(Icons.visibility, color: Colors.grey[600])
                                    : Icon(Icons.visibility_off, color: Colors.grey[600]),
                              ),
                              contentPadding: EdgeInsets.fromLTRB(block * 5, block * 2.5, block * 5, block * 2.5),
                              border: outlineBorder(radius: block * 2, color: transparent, width: 2),
                              enabledBorder: outlineBorder(radius: block * 2, color: transparent, width: 2),
                              focusedBorder: outlineBorder(radius: block * 2, color: transparent, width: 2),
                              errorBorder: outlineBorder(radius: block * 2, color: red, width: 1.5),
                              focusedErrorBorder: outlineBorder(radius: block * 2, color: red, width: 1.5),
                            ),
                            onEditingComplete: () => FocusScope.of(context).requestFocus(FocusNode()),
                            validator: (text) => validators.validatePassword(value: text),
                            onSaved: (text) => controller.password.text = text,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: block * 4),
                    CustomButton(
                      title: 'Log In',
                      padding: block * 3,
                      background: black,
                      borderRadius: block * 2,
                      fontColor: white,
                      fontSize: block * 4,
                      onTap: () => controller.loginOnTap(context: context),
                    ),
                    SizedBox(height: block * 10),
                  ],
                ),
              ),
            ),
            login.isLoading
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
          height: block * 15,
          color: transparent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account?' + ' ',
                style: TextStyle(color: black, fontSize: block * 4),
              ),
              InkWell(
                onTap: () {
                  Get.off(() => SignUpScreen());
                  FocusScope.of(context).unfocus();
                },
                child: Text('Sign Up', style: TextStyle(color: blue, fontSize: block * 4, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
