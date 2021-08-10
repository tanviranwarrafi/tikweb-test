import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tikweb_test_app/components/loaders/circle-loader.dart';
import 'package:tikweb_test_app/components/loaders/image-loader.dart';
import 'package:tikweb_test_app/components/profile-image.dart';
import 'package:tikweb_test_app/controllers/profile-controller.dart';
import 'package:tikweb_test_app/utils/constraints.dart';
import 'package:tikweb_test_app/utils/size-config.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (profile) => Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: white,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text('Profile', style: TextStyle(color: black)),
        ),
        body: profile.isLoading
            ? Container(
                height: height,
                width: width,
                color: white,
                child: Center(child: CircleLoader()),
              )
            : Container(
                height: height,
                width: width,
                color: white,
                padding: EdgeInsets.all(block * 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    profile.userData?.profileImage == null
                        ? ProfileImage(radius: block * 20, imageSize: block * 28)
                        : CircularProfileAvatar(
                            profile.userData.profileImage,
                            radius: block * 20,
                            backgroundColor: Colors.transparent,
                            borderWidth: 2,
                            borderColor: white,
                            elevation: 2,
                            cacheImage: false,
                            placeHolder: (context, url) => ImageLoader(color: black, size: block * 3.5),
                            errorWidget: (context, url, error) => ProfileImage(radius: block * 20, imageSize: block * 28),
                          ),
                    SizedBox(height: block * 3),
                    Text(
                      profile.userData.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: black, fontWeight: FontWeight.w500, fontSize: block * 8),
                    ),
                    SizedBox(height: block * 2.5),
                    Text(
                      profile.userData.email,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: black, fontWeight: FontWeight.w500, fontSize: block * 4),
                    ),
                    SizedBox(height: block),
                    Text(
                      'Password: ${profile.userData.password}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: black, fontWeight: FontWeight.w500, fontSize: block * 4),
                    ),
                    SizedBox(height: block),
                    Text(
                      'Phone: ${profile.userData.phone}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: black, fontWeight: FontWeight.w500, fontSize: block * 5),
                    ),
                    SizedBox(height: block * 2.5),
                    Container(
                      width: width,
                      padding: EdgeInsets.all(block * 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(block),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 2, blurRadius: 3, offset: Offset(0, 2)),
                        ],
                      ),
                      child: Text(
                        'Created Date & Time: ' +
                            DateFormat('yMd').format(DateTime.parse(profile.userData.createdAt)) +
                            '  ' +
                            DateFormat('HH:mm a').format(DateTime.parse(profile.userData.createdAt)),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: grey, fontWeight: FontWeight.w500, fontSize: block * 4),
                      ),
                    ),
                    SizedBox(height: block * 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on, color: grey),
                        SizedBox(width: block * 2),
                        Text('Location', style: TextStyle(color: grey, fontSize: block * 4.2, fontWeight: FontWeight.w500))
                      ],
                    ),
                    SizedBox(height: block * 2.5),
                    Expanded(
                      child: Container(
                        width: width,
                        padding: EdgeInsets.all(block * 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(block),
                          boxShadow: [
                            BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 1, blurRadius: 1, offset: Offset(0, 1)),
                          ],
                        ),
                        child: GoogleMap(
                          minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                          onMapCreated: (GoogleMapController mapController) => profile.controller.complete(mapController),
                          initialCameraPosition: CameraPosition(target: profile.center, zoom: 11.0),
                          mapType: profile.currentMapType,
                          markers: profile.marker,
                          onCameraMove: (CameraPosition position) => profile.lastMapPosition = position.target,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
