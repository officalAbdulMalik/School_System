import 'dart:convert';

import 'package:school_system/Data/app_const.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'package:http/http.dart' as http;

class ShowAttendance {
  // for teacher Side

  static Future showTeacherClassAttendance(String classID, String date) async {
    try {
      var url = Uri.parse(
          '$baseUrl/api/teacher/view-attendance/class?class_id=$classID&date=$date'); // Make sure to use the correct URL

      var headers = {
        'Authorization':
            'Bearer ${LoginApiShadePreference.preferences!.getString('api_token')}',
      };

      var response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        print("here is body${response.body}");
        return jsonDecode(response.body);
      } else {
        print(response.reasonPhrase);
        return jsonDecode(response.body);
      }
    } catch (e) {
      rethrow;
// Get.snackbar('KASI', 'Exception is $e');
    }
  }

  static Future showParentsStudentAttendance(String studentId) async {
    try {
      var url = Uri.parse(
          '$baseUrl/api/parent/student/attendance?student_id=$studentId'); // Make sure to use the correct URL

      var headers = {
        'Authorization':
            'Bearer ${LoginApiShadePreference.preferences!.getString('api_token')}',
      };

      var response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        print("here is body${response.body}");
        return jsonDecode(response.body);
      } else {
        print(response.reasonPhrase);
        return jsonDecode(response.body);
      }
    } catch (e) {
      rethrow;
// Get.snackbar('KASI', 'Exception is $e');
    }
  }
}
