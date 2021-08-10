import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tikweb_test_app/utils/constraints.dart';
import 'package:tikweb_test_app/utils/images.dart';
import 'package:tikweb_test_app/utils/size-config.dart';

class UserImage extends StatelessWidget {
  final File selectedImage;
  final Function onTap;

  UserImage({this.selectedImage, this.onTap});

  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.screenWidth;
    var block = SizeConfig.block;
    return Stack(
      children: [
        Container(
          height: width / 3,
          width: width / 3,
          padding: EdgeInsets.all(block / 2),
          decoration: BoxDecoration(
            color: transparent,
            shape: BoxShape.circle,
            border: Border.all(color: selectedImage == null ? grey300 : transparent),
          ),
          child: Center(
            child: selectedImage == null
                ? SvgPicture.asset(Images.user, width: block * 22, height: block * 22, color: grey)
                : CircleAvatar(radius: block * 15, backgroundImage: FileImage(selectedImage)),
            //backgroundImage: base64Decode(selectedImage)
          ),
        ),
        Positioned(
          bottom: block * 2,
          left: block * 2,
          child: InkWell(
            onTap: onTap,
            child: CircleAvatar(
              backgroundColor: black,
              radius: block * 4.5,
              child: Icon(Icons.camera_alt_sharp, size: block * 5.5, color: white),
            ),
          ),
        ),
      ],
    );
  }
}
