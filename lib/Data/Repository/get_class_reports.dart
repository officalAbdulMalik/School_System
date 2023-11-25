import 'package:school_system/Data/api_const.dart';
import 'package:school_system/Data/app_const.dart';
import 'package:school_system/controllers/services/apis.dart';

class GetClassReports {
  static Future<Map<String, dynamic>> getData(String classID) async {
    try {


      var url =
          Uri.parse('$baseUrl/api/teacher/reports/count?class_id=$classID');
      return await Api().getApi(url: "${AppApiUrls.getClassReport}$classID");
    } catch (e) {
      rethrow;
// Get.snackbar('KASI', 'Exception is $e');
    }
  }
}
