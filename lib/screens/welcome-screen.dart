import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tikweb_test_app/components/custom-button.dart';
import 'package:tikweb_test_app/screens/authentication/login-screen.dart';
import 'package:tikweb_test_app/screens/authentication/signup-screen.dart';
import 'package:tikweb_test_app/utils/constraints.dart';
import 'package:tikweb_test_app/utils/images.dart';
import 'package:tikweb_test_app/utils/size-config.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;
    return DoubleBack(
      message: 'Press back again to close',
      child: Scaffold(
        appBar: null,
        backgroundColor: white,
        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(fit: BoxFit.cover, image: AssetImage(Images.background)),
          ),
          padding: EdgeInsets.all(block * 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(height: block * 5),
              Text(
                'Test Me',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: block * 8, fontWeight: FontWeight.bold, color: white),
              ),
              SizedBox(height: block * 2.5),
              Container(
                padding: EdgeInsets.all(block * 2),
                decoration: BoxDecoration(color: black, borderRadius: BorderRadius.circular(block)),
                child: Text(
                  '  ' + 'USER AUTHENTICA' + '  ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: block * 4.5, color: white, letterSpacing: 1.2),
                ),
              ),
              SizedBox(height: block * 20),
              CustomButton(
                title: 'Login',
                padding: block * 3,
                background: black,
                borderRadius: block * 2,
                fontColor: white,
                fontSize: block * 4,
                fontWeight: FontWeight.w800,
                onTap: () => Get.to(() => LoginScreen()),
              ),
              SizedBox(height: block * 4),
              CustomButton(
                title: 'Sign up',
                padding: block * 3,
                background: white,
                borderRadius: block * 2,
                fontColor: black,
                fontSize: block * 4,
                fontWeight: FontWeight.w800,
                onTap: () => Get.to(() => SignUpScreen()),
              ),
              SizedBox(height: block * 15),
            ],
          ),
        ),
      ),
    );
  }
}
