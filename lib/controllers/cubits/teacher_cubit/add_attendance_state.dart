part of 'add_attendance_cubit.dart';

@immutable
abstract class AddAttendanceState {}

class AddAttendanceInitial extends AddAttendanceState {}

class AddAttendanceLoading extends AddAttendanceState {}

class AddAttendanceLoaded extends AddAttendanceState {}

class AddAttendanceError extends AddAttendanceState {
  String? error;

  AddAttendanceError({this.error});
}
