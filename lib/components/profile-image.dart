import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tikweb_test_app/utils/constraints.dart';
import 'package:tikweb_test_app/utils/images.dart';
import 'package:tikweb_test_app/utils/size-config.dart';

class ProfileImage extends StatelessWidget {
  final double radius;
  final double imageSize;

  ProfileImage({this.radius, this.imageSize});

  @override
  Widget build(BuildContext context) {
    var block = SizeConfig.block;
    return CircleAvatar(
      radius: radius == null ? block * 6 : radius,
      child: SvgPicture.asset(
        Images.user,
        color: grey,
        width: imageSize == null ? block * 8 : imageSize,
        height: imageSize == null ? block * 8 : imageSize,
      ),
    );
  }
}
