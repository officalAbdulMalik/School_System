import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'package:school_system/controllers/cubits/common_cubit/login_cubit.dart';
import 'package:school_system/controllers/services/apis.dart';

class CreateSubjectsRepo {
  createSubjects(
      String nameOFSub, String classID, String type, String code) async {
    try {
      var body = {
        'name': nameOFSub,
        'type': type,
        'class_id': classID,
        'code': code,
        'bg_color': 'red',
      };

      log(body.toString());

      String url =
          'https://www.dev.schoolsnow.parentteachermobile.com/api/teacher/subject';

      return await Api().postApi(url: url, body: body).then((value) {
        return value;
      });
    } catch (e) {
      rethrow;
    }
  }
}
