import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:school_system/Data/app_const.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

class TeacherCreateClass {
  static Future<Map<String, dynamic>> createClass(
    String seId,
    String shId,
    String className,
    String grade,
  ) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer  ${LoginApiShadePreference.preferences!.getString('api_token')}'
    };

    var body = json.encode({
      "section_id": seId,
      "school_id": shId,
      "name": className,
      "grade": grade,
    });

    var request = await http.post(
        Uri.parse('$baseUrl/api/teacher/class/create'),
        body: body,
        headers: headers);
    print(request.statusCode);
    if (request.statusCode == 200) {
      // Fluttertoast.showToast(msg: 'Class Added SuccessFul');
      print(request.body);
      return jsonDecode(request.body);
    } else {
      print(request.body);
      return jsonDecode(request.body);
    }
  }
}
