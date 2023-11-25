import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_system/Data/api_const.dart';
import 'package:school_system/Data/app_const.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

class DeleteAccount {
  static Future<Map<String, dynamic>> deleteAccount(String email) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${LoginApiShadePreference.preferences!.getString('api_token')}'
    };
    String? userID = LoginApiShadePreference.preferences!.getString('user_id');

    var body = json.encode({"id": userID});

    http.Response request = await http.delete(
        Uri.parse(AppApiUrls.deleteAccount),
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
