import 'package:school_system/Controllers/Services/apis.dart';
import 'package:school_system/Data/api_const.dart';


class ForgetPasswordApi {
  static Future<Map<String, dynamic>> sendEmail(String email) async {
    var body = {
      'email': email,
    };

    print(body);


    try {
      return await Api().postApi(url: AppApiUrls.forgetPassword, body: body).then((value) {
        return value;
      });
    } catch (E) {
      print(E.toString());

      return {
        "status": '300',
        "message": E.toString(),
      };
    }
  }

  static Future<Map<String, dynamic>> verifyOtp(
      String otp, String email) async {
    var body = {'email': email, 'otp': otp};
    try {
      return await Api().postApi(url: AppApiUrls.verifyOtp, body: body).then((value) {
        return value;
      });
    } catch (E) {
      print(E.toString());

      return {
        "status": '300',
        "message": E.toString(),
      };
    }
  }

  static Future<Map<String, dynamic>> setPassword(
      String password, String repPassowrd, String email) async {


    var body = {
      'new_password': password,
      'new_confirm_password': repPassowrd,
      'email': email
    };

    try {
      return await Api().postApi(url: AppApiUrls.setPassword, body: body).then((value) {
        return value;
      });
    } catch (E) {
      return {
        "status": '300',
        "message": E.toString(),
      };
    }

    // http.Response request = await http.post(
    //     Uri.parse('$baseUrl/api/set-password'),
    //     body: body,
    //     headers: headers);
    //
    // print(request.statusCode);
    // print(request.body);
    // if (request.statusCode == 200) {
    //   var data = jsonDecode(request.body);
    //   return data;
    //   print(request.body);
    // } else {
    //   var data = jsonDecode(request.body);
    //
    //   return data;
    // }
  }
}
