
import 'package:school_system/Controllers/Services/apis.dart';
import 'package:school_system/Controllers/firebase_repos/firebase_notifications.dart';
import 'package:school_system/Data/api_const.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

class LoginApi {
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    String fcmToken = await NotificationServices().getDeviceToken();

    var body = {
      'email': email,
      'password': password,
      'fcm_id': fcmToken,
    };
    var headers = {'Content-Type': 'application/json'};

    // final ioc = HttpClient();
    // ioc.badCertificateCallback =
    //     (X509Certificate cert, String host, int port) => true;
    // final http = IOClient(ioc);

    try {

      return await Api().postApi(url: AppApiUrls.login, body: body).then((value) {
        return value;
      });


      // var request = await http.post(
      //     Uri.parse(AppApiUrls.login),
      //     body: body,
      //     headers: headers);
      //
      // print(request.statusCode);
      // print(request.body);
      // if (request.statusCode == 200) {
      //   Fluttertoast.showToast(msg: 'Login Success');
      //   var data = jsonDecode(request.body);
      //
      //
      //   print(LoginApiShadePreference.preferences!.getString('type'));
      //   print(userId);
      //   print(profileImage);

        // UserModel.fromJson(data['user']);

      //   return jsonDecode(request.body);
      // else {
      //   // var data = jsonDecode(request.body);
      //   // var msg = data['message'];
      //   // print(msg);
      //   // Fluttertoast.showToast(msg: msg);
      //   return jsonDecode(request.body);

    } catch (e) {
      rethrow;
    }
  }
}
