import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/show_attendance.dart';

part 'show_class_attendance_state.dart';

class ShowClassAttendanceCubit extends Cubit<ShowClassAttendanceState> {
  ShowClassAttendanceCubit() : super(ShowClassAttendanceInitial());

  getAttendance() async {
    await Future.delayed(const Duration(microseconds: 20));

    emit(ShowClassAttendanceLoading());

    try {
      await ShowAttendance.showAttendance('4', DateTime.now().toString())
          .then((value) {
        if (value['error'] != null && value['error'] == false) {
          // var subject = List<TeacherSubject>.from(
          //     value['data']['data'].map((x) => TeacherSubject.fromJson(x)));
          // emit(GetSubjectsLoaded(data: subject));
        } else {
          // emit(GetSubjectsError(error: value['message']));
        }
      }).catchError((e) {
        // emit(GetSubjectsError(error: 'Some Thing Wrong'));
        throw e;
      });
    } catch (e) {
      // emit(GetSubjectsError(error: e.toString()));
      rethrow;
    }
  }
}
