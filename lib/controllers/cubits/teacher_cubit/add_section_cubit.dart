import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/assign_subject.dart';
import 'package:school_system/Data/Repository/teacher_add_section.dart';
part 'add_section_state.dart';

class AddSectionCubit extends Cubit<AddSectionState> {
  AddSectionCubit() : super(AddSectionInitial());

  Future getSections(String schoolName, String schoolId) async {
    emit(AddSectionLoading());

    try {
      await TeacherAddSection.addSection(schoolName, schoolId).then((value) {
        if (value['error'] != null && value['error'] != true) {
          emit(AddSectionLoaded());
        } else {
          emit(AddSectionError(error: value['message']));
        }
      }).catchError((e) {
        emit(AddSectionError(error: 'Some Thing Wrong Try Again'));
      });
    } catch (e) {
      emit(AddSectionError(error: e.toString()));
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

  Future addSubjectToClass(String subjectId, String schoolId) async {
    emit(AddSectionLoading());

    try {
      await AssignSubject().assign(subjectId, schoolId).then((value) {
        log(value.toString());

        if (value['error'] != null && value['error'] != true) {
          log(value);

          emit(AddSectionLoaded());
        } else {
          emit(AddSectionError(error: value['message']));
        }
      }).catchError((e) {
        emit(AddSectionError(error: 'Some Thing Wrong Try Again'));
      });
    } catch (e) {
      emit(AddSectionError(error: e.toString()));
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
