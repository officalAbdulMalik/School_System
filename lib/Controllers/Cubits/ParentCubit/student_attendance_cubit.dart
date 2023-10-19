import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/show_attendance.dart';
import 'package:school_system/models/ParentModels/student_attendance.dart';

part 'student_attendance_state.dart';

class StudentAttendanceCubit extends Cubit<StudentAttendanceState> {
  StudentAttendanceCubit() : super(StudentAttendanceInitial());

  getAttendance(String id) async {
    await Future.delayed(Duration.zero);

    emit(StudentAttendanceLoading());

    try {
      await ShowAttendance.showParentsStudentAttendance(id).then((value) {
        if (value['error'] == false) {
          var attendance = List<ParentStudentAttendance>.from(
              value['data'].map((x) => ParentStudentAttendance.fromMap(x)));

          emit(StudentAttendanceLoaded(attendance: attendance));
        } else {
          emit(StudentAttendanceError(error: value['message']));
        }
      }).catchError((e) {
        emit(StudentAttendanceError(error: 'Some Thing Wrong'));
        throw e;
      });
    } catch (e) {
      emit(StudentAttendanceError(error: e.toString()));
      rethrow;
    }
  }
}
