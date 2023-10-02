import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'package:school_system/controllers/cubits/common_cubit/login_cubit.dart';

class CreateSubjectsRepo {
  createSubjects(
      String nameOFSub, String classID, String type, String code) async {
    var headers = {
      'Authorization':
          'Bearer ${LoginApiShadePreference.preferences!.getString('api_token')}'
    };

    var body = {
      'name': nameOFSub,
      'type': type,
      'class_id': classID,
      'code': code,
    };

    log(body.toString());

    var request = await http.post(
        Uri.parse(
            'https://www.dev.schoolsnow.parentteachermobile.com/api/teacher/subject'),
        headers: headers,
        body: jsonEncode(body));

    if (request.statusCode == 200) {
      return jsonEncode(request.body);
    } else {
      return jsonEncode(request.body);
      // print(response.reasonPhrase);
    }
  }
}
