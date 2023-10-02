import 'dart:convert';

import 'package:school_system/Data/app_const.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'package:http/http.dart' as http;

class GetSubjects {
  static Future<Map<String, dynamic>> getData() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
      };

      var url = Uri.parse('$baseUrl/api/subjects');
      var response = await http.get(url, headers: headers);

      print('status code is ${response.statusCode}');
      print('settings body is ${response.body.toString()}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        return data;
// Get.snackbar('KASI', 'Settings get successfully');
      } else {
        return jsonDecode(response.body);
        print('error');
// var data = jsonDecode(response.body.toString());
// print(data['message']);
      }
    } catch (e) {
      rethrow;
// Get.snackbar('KASI', 'Exception is $e');
    }
  }
}
