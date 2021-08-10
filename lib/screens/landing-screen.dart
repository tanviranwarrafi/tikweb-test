import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tikweb_test_app/controllers/global-controller.dart';
import 'package:tikweb_test_app/screens/profile-screen.dart';
import 'package:tikweb_test_app/screens/users-screen/users-screen.dart';
import 'package:tikweb_test_app/utils/constraints.dart';
import 'package:tikweb_test_app/utils/images.dart';
import 'package:tikweb_test_app/utils/size-config.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int selectedIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  logoutDialog() async {
    var block = SizeConfig.block;
    await Future.delayed(Duration(milliseconds: 10));
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
          setState(() => selectedIndex = 1);
          return Future.value(false);
        },
        child: AlertDialog(
          title: Text('Do you really want to logout?', style: TextStyle(color: black, fontSize: block * 4)),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context, false);
                setState(() => selectedIndex = 1);
              },
              child: Container(
                  padding: EdgeInsets.all(block),
                  decoration: BoxDecoration(color: black, borderRadius: BorderRadius.circular(block / 2)),
                  child: Text('     ' + 'No' + '     ', style: TextStyle(color: white, fontSize: block * 4))),
            ),
            FlatButton(
              onPressed: () => Get.put(GlobalController()).userLogout(context: context),
              child: Container(
                padding: EdgeInsets.all(block),
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(block / 2)),
                child: Text('     ' + 'Yes' + '     ', style: TextStyle(color: white, fontSize: block * 4)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> onBackPress() async {
    var block = SizeConfig.block;
    await Future.delayed(Duration(milliseconds: 10));
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Do you really want to exit this app?', style: TextStyle(color: black, fontSize: block * 4)),
        actions: [
          FlatButton(
            onPressed: () => Navigator.pop(context, false),
            child: Container(
                padding: EdgeInsets.all(block),
                decoration: BoxDecoration(color: black, borderRadius: BorderRadius.circular(block / 2)),
                child: Text('     ' + 'No' + '     ', style: TextStyle(color: white, fontSize: block * 4))),
          ),
          FlatButton(
            onPressed: () => SystemNavigator.pop(),
            child: Container(
              padding: EdgeInsets.all(block),
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(block / 2)),
              child: Text('     ' + 'Yes' + '     ', style: TextStyle(color: white, fontSize: block * 4)),
            ),
          ),
        ],
      ),
    );
  }

  void showTestDialog(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 10));
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Wrap(
          children: <Widget>[
            Container(
              width: 200.0,
              height: 200.0,
              color: Colors.orange,
            ),
          ],
        );
      },
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black,
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  bottomNavigationCallPage({int currentIndex}) {
    switch (currentIndex) {
      case 0:
        return logoutScreenWidget();
      case 1:
        return UsersScreen();
      case 2:
        return ProfileScreen();
      default:
        return UsersScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var block = SizeConfig.block;
    return WillPopScope(
      onWillPop: () {
        if (selectedIndex != 1) {
          setState(() => selectedIndex = 1);
          return null;
        } else {
          return onBackPress();
        }
      },
      child: Scaffold(
        body: bottomNavigationCallPage(currentIndex: selectedIndex),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(block * 12.5),
            topRight: Radius.circular(block * 12.5),
          ),
          child: SizedBox(
            width: width,
            height: block * 13,
            child: BottomNavigationBar(
              elevation: 1,
              onTap: (int index) => setState(() => selectedIndex = index),
              currentIndex: selectedIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: black,
              showSelectedLabels: true,
              selectedItemColor: white,
              unselectedItemColor: Colors.grey[500],
              selectedFontSize: block * 3,
              unselectedFontSize: block * 3,
              selectedIconTheme: IconThemeData(color: colorPrimaryDark, size: 20),
              unselectedIconTheme: IconThemeData(color: textColor, size: 20),
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(Images.logout, height: block * 6, color: Colors.grey[700]),
                  activeIcon: SvgPicture.asset(Images.logout, height: block * 6, color: white),
                  label: 'Logout',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(Images.userNav, height: block * 6, color: Colors.grey[700]),
                  activeIcon: SvgPicture.asset(Images.userNav, height: block * 6, color: white),
                  label: 'Users',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(Images.user, height: block * 6, color: Colors.grey[700]),
                  activeIcon: SvgPicture.asset(Images.user, height: block * 6, color: white),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  logoutScreenWidget() {
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    logoutDialog();
    return Container(height: height, width: width, color: white);
  }
}
