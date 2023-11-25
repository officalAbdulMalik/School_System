import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:school_system/Data/api_const.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

class AssignSubject {
  assign(String classID, String subjectID) async {
    var body = json.encode({'subject_id': subjectID, 'class_id': classID});

    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${LoginApiShadePreference.preferences!.getString('api_token')}'
    };
    try {
      http.Response request = await http.post(
        Uri.parse(AppApiUrls.assignSubject),
        body: body,
        headers: headers,
      );
      // var data = jsonDecode(request.body);
      // print(request.statusCode);

      print(request.statusCode);

      log(request.body);

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
