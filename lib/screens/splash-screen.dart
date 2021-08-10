import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tikweb_test_app/controllers/global-controller.dart';
import 'package:tikweb_test_app/screens/landing-screen.dart';
import 'package:tikweb_test_app/screens/welcome-screen.dart';
import 'package:tikweb_test_app/utils/constraints.dart';
import 'package:tikweb_test_app/utils/size-config.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () => Get.offAll(() => Get.put(GlobalController()).isUser ? LandingScreen() : WelcomeScreen()));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;
    return Scaffold(
      appBar: null,
      backgroundColor: white,
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            padding: EdgeInsets.all(block * 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: block * 5),
                Text(
                  'Test Me',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: block * 8, fontWeight: FontWeight.bold, color: black),
                ),
                SizedBox(height: block * 2.5),
                Container(
                  padding: EdgeInsets.all(block * 2),
                  decoration: BoxDecoration(color: black, borderRadius: BorderRadius.circular(block)),
                  child: Text(
                    '  ' + 'User AUTHENTICA' + '  ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: block * 4.5, color: white, letterSpacing: 1.2),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: -block * 15,
            top: -block * 4,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: width / 1.3,
                  width: width / 1.3,
                  decoration: BoxDecoration(color: Color(0xFFEDEDED), shape: BoxShape.circle),
                ),
                SizedBox(width: block * 4),
                Column(
                  children: [
                    Container(
                      height: width / 10,
                      width: width / 10,
                      decoration: BoxDecoration(color: Color(0xFFEDEDED), shape: BoxShape.circle),
                    ),
                    SizedBox(height: 50),
                    Container(
                      height: width / 4.5,
                      width: width / 4.5,
                      decoration: BoxDecoration(color: Color(0xFFEDEDED), shape: BoxShape.circle),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: block * 10,
            child: Center(
              child: Theme(
                data: Theme.of(context).copyWith(accentColor: black),
                child: CircularProgressIndicator(strokeWidth: block),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
