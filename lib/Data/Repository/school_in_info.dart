import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/io_client.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

class AddSchoolInOverInfo {
  static Future<Map<String, dynamic>> addSchool(int id) async {
    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer  ${LoginApiShadePreference.preferences!.getString('api_token')}'
    };

    var body = json.encode({
      "school_ids": [id]
    });

    var request = await http.post(
        Uri.parse(
            'https://www.dev.schoolsnow.parentteachermobile.com/api/user/schools'),
        body: body,
        headers: headers);
    print(request.statusCode);
    if (request.statusCode == 200) {
      Fluttertoast.showToast(msg: 'School Added SuccessFul');
      print(request.body);
      return jsonDecode(request.body);
    } else {
      print(request.body);
      return jsonDecode(request.body);
    }
  }
}
