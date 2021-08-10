import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:tikweb_test_app/components/loaders/image-loader.dart';
import 'package:tikweb_test_app/components/profile-image.dart';
import 'package:tikweb_test_app/models/user.dart';
import 'package:tikweb_test_app/utils/constraints.dart';
import 'package:tikweb_test_app/utils/size-config.dart';

class UserCard extends StatelessWidget {
  final int listIndex;
  final int listLength;
  final User user;
  final Function onTap;
  final Function onDelete;

  UserCard({this.listIndex, this.listLength, this.user, this.onTap, this.onDelete});

  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.screenWidth;
    var block = SizeConfig.block;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.all(block),
        margin: EdgeInsets.only(bottom: listIndex == listLength - 1 ? 0 : block * 2.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  user?.profileImage == null
                      ? ProfileImage(radius: block * 6, imageSize: block * 8)
                      : CircularProfileAvatar(
                          user.profileImage,
                          radius: block * 6,
                          backgroundColor: Colors.transparent,
                          borderWidth: 1,
                          borderColor: white,
                          elevation: 0,
                          cacheImage: false,
                          placeHolder: (context, url) => ImageLoader(color: colorPrimary, size: block * 3.5),
                          errorWidget: (context, url, error) => ProfileImage(radius: block * 6, imageSize: block * 8),
                        ),
                  SizedBox(width: block * 2),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: block * 4, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: block * 2),
                        Text(
                          user.email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: block * 3.8, color: grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: block * 2),
            InkWell(
              onTap: onDelete,
              child: Container(
                padding: EdgeInsets.all(block * 1.5),
                decoration: BoxDecoration(color: Color(0xFFE0E0E0), borderRadius: BorderRadius.circular(block * 2)),
                child: Text('   ' + 'Remove' + '   ', style: TextStyle(color: black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
