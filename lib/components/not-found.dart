import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tikweb_test_app/utils/constraints.dart';
import 'package:tikweb_test_app/utils/size-config.dart';

class NotFound extends StatelessWidget {
  final String image;
  final String title;

  NotFound({this.image, this.title});

  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.screenWidth;
    var block = SizeConfig.block;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(image, color: red, width: width / 4),
        SizedBox(height: block * 2.5),
        Text(title, style: TextStyle(color: red, fontSize: block * 4)),
      ],
    );
  }
}
