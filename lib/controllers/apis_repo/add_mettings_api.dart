import 'package:http/http.dart' as http;
import 'package:school_system/views/utils/shade_prefrence.dart';

class AddMeetings {
  static Future sendMeetingRequest(
      String title, taecherid, parentId, date, time, desc) async {
    var headers = {
      'Authorization':
          'Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://schoolsnow.parentteachermobile.com/api/add/meetings'));
    request.fields.addAll({
      'title': title,
      'teacher_id': taecherid,
      'parent_id': parentId,
      'meeting_date': time,
      'meeting_time': date,
      'description': desc,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
