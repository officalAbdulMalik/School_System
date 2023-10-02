import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/get_subjects.dart';
import 'package:school_system/models/teacher_subject.dart';

part 'get_subjects_state.dart';

class GetSubjectsCubit extends Cubit<GetSubjectsState> {
  GetSubjectsCubit() : super(GetSubjectsInitial());

  getSubjects() async {
    await Future.delayed(Duration(microseconds: 20));

    emit(GetSubjectsLoading());

    try {
      await GetSubjects.getData().then((value) {
        if (value['error'] != null && value['error'] == false) {
          var subject = List<TeacherSubject>.from(
              value['data']['data'].map((x) => TeacherSubject.fromJson(x)));
          emit(GetSubjectsLoaded(data: subject));
        } else {
          emit(GetSubjectsError(error: value['message']));
        }
      }).catchError((e) {
        emit(GetSubjectsError(error: 'Some Thing Wrong'));
        throw e;
      });
    } catch (e) {
      emit(GetSubjectsError(error: e.toString()));
      rethrow;
    }
  }
}
