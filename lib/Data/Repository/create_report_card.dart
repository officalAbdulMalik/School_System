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
      "quarter_id": 'ee77a95a64b33e49dc9fb0320b765149',
      "class_id": "25",
      "subject_id": "2",
      "session_year_id": '1',
      "reports": data1,
    };

    log("data is Here${data.toString()}");

    var headers = {
      'Authorization': 'Bearer 388|ftUXlkAj0qvMee1uzNQUdFw6eE2VuWRFPI085UB9'
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
