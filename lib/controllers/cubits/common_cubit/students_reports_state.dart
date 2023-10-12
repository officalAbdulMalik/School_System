part of 'students_reports_cubit.dart';

@immutable
abstract class StudentsReportsState {}

class StudentsReportsInitial extends StudentsReportsState {}

class StudentsReportsLoading extends StudentsReportsState {}

class StudentsReportsLoaded extends StudentsReportsState {
  List<StudentReports>? reports;

  StudentsReportsLoaded({this.reports});
}

class StudentsReportsError extends StudentsReportsState {
  String? error;

  StudentsReportsError({this.error});
}
