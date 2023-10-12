import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_system/Data/app_const.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

class DeleteAccount {
  static Future<Map<String, dynamic>> deleteAccount(String email) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${LoginApiShadePreference.preferences!.getString('api_token')}'
    };

    var body = json.encode(
        {"id": LoginApiShadePreference.preferences!.getString('user_id')});

    http.Response request = await http.delete(
        Uri.parse('$baseUrl/api/auth/delete'),
        body: body,
        headers: headers);

    print(request.statusCode);
    print(request.body);
    if (request.statusCode == 200) {
      var data = jsonDecode(request.body);
      return data;
    } else {
      var data = jsonDecode(request.body);

      return data;
    }
  }
}
