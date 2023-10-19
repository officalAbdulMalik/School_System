import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  Future<Map<String, dynamic>> postApi(
      {required String url, required Map<String, dynamic> body}) async {
    var url1 = Uri.parse(url); // Make sure to use the correct URL

    var headers = {
      'Authorization': 'Bearer 366|8qVNznhtEx9QmnytNsri2aItOKhFDfsN5Ny9Fu58',
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
}
