part of 'get_subjects_cubit.dart';

@immutable
abstract class GetSubjectsState {}

class GetSubjectsInitial extends GetSubjectsState {}

class GetSubjectsLoading extends GetSubjectsState {}

class GetSubjectsLoaded extends GetSubjectsState {
  List<TeacherSubject>? data;

  GetSubjectsLoaded({this.data});
}

class GetSubjectsError extends GetSubjectsState {
  String? error;

  GetSubjectsError({this.error});
}
