import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

class Api {
  Future<Map<String, dynamic>> postApi(
      {required String url, required Map<String, dynamic> body}) async {
    var url1 = Uri.parse(url); // Make sure to use the correct URL

    var headers = {
      'Authorization': 'Bearer ${LoginApiShadePreference.preferences!.getString('api_token')}',
      'Content-Type': 'application/json', // Set the content type accordingly
    };

    var response = await http.post(
      url1,
      headers: headers,
      body: json.encode(body), // Encode the request body as JSON
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.reasonPhrase);
      return jsonDecode(response.body);
    }
  }

  Future<Map<String, dynamic>> getApi(
      {required String url}) async {
    var url1 = Uri.parse(url); // Make sure to use the correct URL

    var headers = {
      'Authorization': 'Bearer ${LoginApiShadePreference.preferences!.getString('api_token')}',
      'Content-Type': 'application/json', // Set the content type accordingly
    };

    var response = await http.get(
      url1,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.reasonPhrase);
      return jsonDecode(response.body);
    }
  }

}
