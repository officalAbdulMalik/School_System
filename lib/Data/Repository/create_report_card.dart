import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:school_system/Data/app_const.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

class CreateCard {
  static Future createCard({
    required String querterIO,
    required String classId,
    required String sessionID,
    required String subjectID,
    required String comments,
    required List<Map<String, dynamic>>? data1,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${LoginApiShadePreference.preferences!.getString('api_token')}'
    };
    var request = http.Request(
        'POST', Uri.parse('$baseUrl/api/teacher/create/student-report'));
    request.body = json.encode({
      "quarter_id": querterIO,
      "class_id": classId,
      "subject_id": subjectID,
      "session_year_id": sessionID,
      "reports": data1,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());

      return {
        "success": true,
        'status': response.statusCode,
        "message": 'Data Success'
      };
    } else {
      return {
        "success": false,
        'status': response.statusCode,
        "message": 'Data Not Added'
      };
    }
  }
}
