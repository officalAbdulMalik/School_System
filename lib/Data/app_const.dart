import 'package:school_system/Presentation/utils/shade_prefrence.dart';

String baseUrl = 'https://www.dev.schoolsnow.parentteachermobile.com';

String noDataString = 'Data not found';

class StaticValues {
  static String? userType =
      LoginApiShadePreference.preferences!.getString('type');
}
