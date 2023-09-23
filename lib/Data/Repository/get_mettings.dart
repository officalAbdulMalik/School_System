import 'dart:convert';

import 'package:school_system/Data/app_const.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'package:http/http.dart' as http;

class GetMeetings {
  Future getAllMeetings() async {
    Future.delayed(const Duration(milliseconds: 20));
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
      };

      var url = Uri.parse(
          'https://www.dev.schoolsnow.parentteachermobile.com/api/get/meetings?status=');
      var response = await http.get(url, headers: headers);

      print('status code is ${response.statusCode}');
      print('settings body is ${response.body.toString()}');

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body.toString());
        return data;
        // Get.snackbar('KASI', 'Settings get successfully');
      } else {
        Map<String, dynamic> data = jsonDecode(response.body.toString());
        return data;
      }
    } catch (e) {
      var data = {'status': 400, 'error': e.toString()};
      return data;
      // Get.snackbar('KASI', 'Exception is $e');
    }
  }
}
