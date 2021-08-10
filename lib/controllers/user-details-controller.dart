import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tikweb_test_app/config/api-urls.dart';
import 'package:tikweb_test_app/models/user.dart';
import 'package:tikweb_test_app/services/api-service.dart';

class UserDetailsController extends GetxController {
  ApiService apiService = ApiService();
  Set<Marker> markerList = {};
  Completer<GoogleMapController> controller = Completer();
  LatLng center = LatLng(40.4088582, 49.8683759);
  MapType currentMapType = MapType.normal;
  LatLng lastMapPosition = LatLng(40.4088582, 49.8683759);
  Set<Marker> marker;
  bool isLoading = true;
  User userData;

  initController({String userId}) {
    getUserDetailsData(userId: userId);
  }

  @override
  void onClose() {
    isLoading = true;
    super.onClose();
  }

  setInitialMarker({double lat, double lang}) {
    marker = {
      Marker(
        flat: true,
        draggable: true,
        position: LatLng(lat, lang),
        markerId: MarkerId('$lat-$lang'),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: '', snippet: ''),
      )
    };
    update();
  }

  onMapTypeButtonPressed() {
    if (currentMapType == MapType.normal) {
      currentMapType = MapType.satellite;
      update();
    } else {
      currentMapType = MapType.normal;
      update();
    }
  }

  getUserDetailsData({String userId}) {
    apiService.getRequest(endPoint: ApiUrl.userDetails + userId).then((response) {
      print(response);
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        userData = User.fromJson(jsonResponse['response']['user_data']);
        isLoading = false;
        if (userData?.latitude != null && userData?.longitude != null) {
          center = LatLng(double.parse(userData.latitude), double.parse(userData.longitude));
          double latitude = double.parse(userData.latitude);
          double longitude = double.parse(userData.longitude);
          setInitialMarker(lat: latitude, lang: longitude);
        }
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
      }
    });
  }
}
