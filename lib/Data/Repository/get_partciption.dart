import 'dart:convert';

import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'package:http/http.dart' as http;
import 'package:school_system/models/teacher_parents_data_model.dart';

class GetParticipation {
  static Future<Map<String, dynamic>> getData() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
      };

      var url = Uri.parse(
          'https://schoolsnow.parentteachermobile.com/api/get/parents');
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
