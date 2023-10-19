import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/get_secstions.dart';
import 'package:school_system/Data/global_list.dart';
import 'package:school_system/models/get_section_model.dart';
import 'package:http/http.dart' as http;
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

part 'get_section_state.dart';

class GetSectionCubit extends Cubit<GetSectionState> {
  GetSectionCubit() : super(GetSectionInitial());

  Future getSections() async {
    emit(GetSectionLoading());

    try {
      await GetSections.getData().then((value) {
        if (value['error'] != null && value['error'] == false) {
          var section = List<Sections>.from(
              value['sections'].map((x) => Sections.fromJson(x)));
          emit(GetSectionLoaded(sections: section));
        } else {
          emit(GetSectionError(error: value['message']));
        }
      }).catchError((e) {
        emit(GetSectionError(error: 'Some Thing Wrong Try Again'));
      });
    } catch (e) {
      emit(GetSectionError(error: e.toString()));
    }

    //   if (response.statusCode == 200) {
    //     emit(GetSectionLoaded(sections: sections));
    //     // for (var i in section) {
    //     //   GlobalList.sections.add(i);
    //     // }
    //     // Get.snackbar('KASI', 'Settings get successfully');
    //   } else {
    //     var data = jsonDecode(response.body.toString());
    //     print(data['message']);
    //     emit(GetSectionError(error: data['message']));
    //     print('error');
    //   }
    // }
  }
}
