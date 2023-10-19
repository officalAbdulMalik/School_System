part of 'class_reports_cubit.dart';

@immutable
abstract class ClassReportsState {}

class ClassReportsInitial extends ClassReportsState {}

class ClassReportsLoading extends ClassReportsState {}

class ClassReportsLoaded extends ClassReportsState {
  List<ShowClassReports>? reports;

  String? counts;
  String? published;
  ClassReportsLoaded({this.reports, this.counts, this.published});
}

class ClassReportsError extends ClassReportsState {
  String? error;

  ClassReportsError({this.error});
}
