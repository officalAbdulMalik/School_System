import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

class TeacherAddSection {
  static Future<int> addSection(
    String sectionName,
    String schoolId,
  ) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer  ${LoginApiShadePreference.preferences!.getString('api_token')}'
    };

    var body = json.encode({
      "school_id": schoolId,
      "name": sectionName,
    });

    var request = await http.post(
        Uri.parse(
            'https://www.dev.schoolsnow.parentteachermobile.com/api/teacher/school-sections'),
        body: body,
        headers: headers);
    print(request.statusCode);
    if (request.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Section Added SuccessFul');
      print(request.body);
      return request.statusCode;
    } else {
      print(request.body);
      return request.statusCode;
    }
  }
}
