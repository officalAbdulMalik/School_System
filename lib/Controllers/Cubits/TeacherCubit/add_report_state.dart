part of 'add_report_cubit.dart';

@immutable
abstract class AddReportState {}

class AddReportInitial extends AddReportState {}

class AddReportLoading extends AddReportState {}

class AddReportLoaded extends AddReportState {}

class AddReportError extends AddReportState {
  String? error;

  AddReportError({this.error});
}
