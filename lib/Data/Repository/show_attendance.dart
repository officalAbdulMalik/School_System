import 'dart:convert';

import 'package:school_system/Data/app_const.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'package:http/http.dart' as http;

class ShowAttendance {
  // for teacher Side

  static showAttendance(String classID, String date) async {
    try {
      var body = {"class_id": classID, "date": date};

      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
      };

      var request = http.Request(
          'GET', Uri.parse('$baseUrl/api/teacher/view-attendance/class'));
      request.body = '''{\n    "class_id": 16,\n    "date": "2023-05-21"\n}''';

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      rethrow;
// Get.snackbar('KASI', 'Exception is $e');
    }
  }
}
