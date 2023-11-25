part of 'add_new_school_cubit.dart';

@immutable
abstract class AddNewSchoolState {}

class AddNewSchoolInitial extends AddNewSchoolState {}

class AddNewSchoolLoading extends AddNewSchoolState {}

class AddNewSchoolLoaded extends AddNewSchoolState {}

class AddNewSchoolError extends AddNewSchoolState {
  final String? error;
  AddNewSchoolError({this.error});
}


