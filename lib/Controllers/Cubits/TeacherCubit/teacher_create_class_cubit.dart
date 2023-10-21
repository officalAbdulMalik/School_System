import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/teacher_create_class.dart';

part 'teacher_create_class_state.dart';

class TeacherCreateClassCubit extends Cubit<TeacherCreateClassState> {
  TeacherCreateClassCubit() : super(TeacherCreateClassInitial());

  Future addClass(
      String sectionId, String shId, String className, String grade) async {
    await Future.delayed(const Duration(microseconds: 20));

    emit(TeacherCreateClassLoading());

    try {
      await TeacherCreateClass.createClass(sectionId, shId, className, grade)
          .then((value) {
        if (value['status'] != null && value['status'] == 200) {
          print(value);
          emit(TeacherCreateClassLoaded());
        } else {
          emit(TeacherCreateClassError(error: value['message']));
        }
      }).catchError((e) {
        emit(TeacherCreateClassError(error: 'Some Thing Wrong'));
      });
    } catch (e) {
      emit(TeacherCreateClassError(error: e.toString()));
    }
  }
}
