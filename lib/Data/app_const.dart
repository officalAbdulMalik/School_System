import 'package:school_system/Presentation/utils/shade_prefrence.dart';

String baseUrl = 'https://www.dev.schoolsnow.parentteachermobile.com';

class StaticValues {
  String meetingUrl =
      'https://www.dev.schoolsnow.parentteachermobile.com/api/get/meetings';

  static String? userType =
      LoginApiShadePreference.preferences!.getString('type');
}
