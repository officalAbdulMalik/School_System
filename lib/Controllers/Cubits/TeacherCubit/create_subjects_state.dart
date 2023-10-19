part of 'create_subjects_cubit.dart';

@immutable
abstract class CreateSubjectsState {}

class CreateSubjectsInitial extends CreateSubjectsState {}

class CreateSubjectsLoading extends CreateSubjectsState {}

class CreateSubjectsLoaded extends CreateSubjectsState {}

class CreateSubjectsError extends CreateSubjectsState {
  String? error;

  CreateSubjectsError({this.error});
}
