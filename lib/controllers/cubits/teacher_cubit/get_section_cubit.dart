import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/controllers/global_list.dart';
import 'package:school_system/models/get_section_model.dart';
import 'package:http/http.dart' as http;
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

part 'get_section_state.dart';

class GetSectionCubit extends Cubit<GetSectionState> {
  GetSectionCubit() : super(GetSectionInitial());

  Future getSections() async {
    print('data');

    emit(GetSectionLoading());

    print(LoginApiShadePreference.preferences!.getString("api_token"));

    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
    };

    var url = Uri.parse(
        'http://www.dev.schoolsnow.parentteachermobile.com/api/sections');
    var response = await http.get(url, headers: headers);

    print('status code is ${response.statusCode}');
    print('settings body is ${response.body.toString()}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      // var section = data['sections'];
      // print(section);

      Sections sections = Sections.fromJson(data);

      emit(GetSectionLoaded(model: sections));
      // for (var i in section) {
      //   GlobalList.sections.add(i);
      // }
      // Get.snackbar('KASI', 'Settings get successfully');
    } else {
      emit(GetSectionError());
      print('error');
      // var data = jsonDecode(response.body.toString());
      // print(data['message']);
    }
  }
}
