part of 'student_attendance_cubit.dart';

@immutable
abstract class StudentAttendanceState {}

class StudentAttendanceInitial extends StudentAttendanceState {}

class StudentAttendanceLoading extends StudentAttendanceState {}

class StudentAttendanceLoaded extends StudentAttendanceState {
  List<ParentStudentAttendance>? attendance;

  StudentAttendanceLoaded({this.attendance});
}

class StudentAttendanceError extends StudentAttendanceState {
  String? error;

  StudentAttendanceError({this.error});
}
