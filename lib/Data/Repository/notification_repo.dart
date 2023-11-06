import 'dart:convert';

import 'package:school_system/Data/app_const.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'package:http/http.dart' as http;

class Notifications {
  static Future<Map<String, dynamic>> getData() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
      };

      var url = Uri.parse('$baseUrl/api/notifications');
      var response = await http.get(url, headers: headers);

      print('status code is ${response.statusCode}');
      print('settings body is ${response.body.toString()}');

      var data = jsonDecode(response.body.toString());
      return data;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> readNotification(String id) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
      };

      var url =
          Uri.parse('$baseUrl/api/notifications-read?notification_id=$id');
      var response = await http.post(url, headers: headers);

      print('status code is ${response.statusCode}');
      print('settings body is ${response.body.toString()}');

      var data = jsonDecode(response.body.toString());
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
