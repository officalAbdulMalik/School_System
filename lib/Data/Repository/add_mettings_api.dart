import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:school_system/Data/app_const.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

import 'auth_apis.dart';

class AddMeetings {
  static Future<Map<String, dynamic>> sendMeetingRequest(
      String title,
      List<String> id,
      String stdId,
      String date,
      String sTime,
      String eTime,
      String desc) async {
    String? userType = LoginApiShadePreference.preferences!.getString('type');

    print(userType);

    List teacherIds = [];

    for (int i = 0; i < id.length; i++) {
      teacherIds.add({"parent_id": id[i], "student_id": null});
    }

    var body = json.encode({
      "title": title,
      "meeting_date": date,
      "meeting_time": sTime,
      "meeting_end_time": eTime,
      "student_parent_ids": userType == 'teacher' ? teacherIds : [],
      "teacher_id": userType != 'teacher'
          ? id.first
          : null, // if you are a teacher, send teacher_id as empty.
      "description": desc,
    });

    print(body);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${LoginApiShadePreference.preferences!.getString('api_token')}'
    };
    try {
      http.Response request = await http.post(
          Uri.parse('$baseUrl/api/add/meetings'),
          body: body,
          headers: headers);
      // var data = jsonDecode(request.body);
      // print(request.statusCode);
      print(request.body);
      if (request.statusCode == 200) {
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
