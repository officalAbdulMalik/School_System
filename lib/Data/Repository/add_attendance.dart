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
    debugPrint(classId);
    var data = {
      "present_student_ids": jsonEncode(present),
      "absence_student_id": jsonEncode(absent),
      "date": date.toString(),
      "holiday": null,
      "class_id": classId,
    };

    log("data is Here${data.toString()}");

    var headers = {
      'Authorization':
          'Bearer ${LoginApiShadePreference.preferences!.getString('api_token')}'
    };

    try {
      http.Response request = await http.post(
          Uri.parse('$baseUrl/api/teacher/mark-attendance'),
          body: jsonEncode(data),
          headers: headers);

      print(request.statusCode);
      print(request.body);
      log("request body ${request.body}");
      if (request.statusCode == 200) {
        log(request.body);
        var data1 = jsonDecode(request.body);
        return data1;
      } else {
        var data1 = jsonDecode(request.body);
        return data1;
      }
    } catch (e) {
      rethrow;
    }
  }
}
