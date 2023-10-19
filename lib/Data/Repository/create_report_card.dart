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
    var data = {
      "quarter_id": querterIO,
      "class_id": classId,
      "subject_id": subjectID,
      "session_year_id": sessionID,
      "reports": jsonEncode(data1),
    };

    print("data is Here${data}");

    var headers = {
      'Authorization':
          'Bearer ${LoginApiShadePreference.preferences!.getString('api_token')}',
    };

    try {
      http.Response request = await http.post(
          Uri.parse('$baseUrl/api/teacher/create/student-report'),
          body: jsonEncode(data),
          headers: headers);
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
