part of 'show_class_attendance_cubit.dart';

@immutable
abstract class ShowClassAttendanceState {}

class ShowClassAttendanceInitial extends ShowClassAttendanceState {}

class ShowClassAttendanceLoading extends ShowClassAttendanceState {}

class ShowClassAttendanceLoaded extends ShowClassAttendanceState {
  final String? absent;
  final String? present;

  final List<Attendance>? attendance;
  ShowClassAttendanceLoaded({this.present, this.absent, this.attendance});
}

class ShowClassAttendanceError extends ShowClassAttendanceState {
  String? error;

  ShowClassAttendanceError({this.error});
}
