import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:school_system/Data/app_const.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

class AddAttendance {
  static Future addValue({
    required String date,
    required String classId,
    required List<String>? present,
    required List<String>? absent,
  }) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${LoginApiShadePreference.preferences!.getString('api_token')}'
      };
      var request = http.Request(
          'POST', Uri.parse('$baseUrl/api/teacher/mark-attendance'));
      request.body = json.encode({
        "present_student_ids": present,
        "absence_student_id": absent,
        "date": date,
        "holiday": null,
        "class_id": classId,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());

        return {
          "success": true,
          "status": response.statusCode,
          "message": "Data Success",
        };
      } else {
        print(response.reasonPhrase);
        return {
          "success": false,
          "status": response.statusCode,
          "message": "Data Error"
        };
      }
    } catch (e) {
      rethrow;
    }
  }
}
