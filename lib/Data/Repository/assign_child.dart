import 'dart:convert';
import 'dart:developer';

import 'package:school_system/Data/api_const.dart';
import 'package:school_system/Data/app_const.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'package:http/http.dart' as http;

class AssignChild {
  static Future assign({
    required String classId,
    required String studentId,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
    };
    var data = {
      "user_id": studentId, // student id
      "class_id": classId,
    };

    log("data is Here${data.toString()}");

    try {
      http.Response request = await http.post(
          Uri.parse(AppApiUrls.assignStudentClass),
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
      throw e;
    }
  }
}
