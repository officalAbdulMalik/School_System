import 'dart:developer';
import 'package:school_system/Data/api_const.dart';
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
          AppApiUrls.createSubject;

      return await Api().postApi(url: url, body: body).then((value) {
        return value;
      });
    } catch (e) {
      rethrow;
    }
  }
}
