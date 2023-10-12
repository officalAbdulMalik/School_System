import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:school_system/Data/app_const.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

class AddAttendance {
  static Future addValue({
    required String date,
    required String classId,
    required List<int>? present,
    required List<int>? absent,
  }) async {
    var data = {
      "present_student_ids": [94],
      "absence_student_id": [],
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
          Uri.parse('$baseUrl/api/teacher/create/student-report'),
          body: json.encode(data),
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
