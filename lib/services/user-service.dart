import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  SharedPreferences prefs;

  saveString({String key, String value}) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  saveBoolean({String key, bool value}) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  loginCheck() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('is-user') != null) {
      return prefs.getBool('is-user');
    } else {
      return false;
    }
  }

  getUserId() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user-id') != null) {
      return prefs.getString('user-id').toString();
    } else {
      return null;
    }
  }

  removeSharedPreferenceData() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove('is-user');
    prefs.remove('user-id');
    prefs.clear();
  }
}
