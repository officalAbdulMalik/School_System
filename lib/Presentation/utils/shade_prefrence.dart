import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginApiShadePreference {
  static SharedPreferences? preferences;


  // Obtain shared preferences.
  static Future getInit() async {
    preferences = await SharedPreferences.getInstance();
  }
}
