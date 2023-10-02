part of 'get_all_school_cubit.dart';

@immutable
abstract class GetAllSchoolState {}

class GetAllSchoolInitial extends GetAllSchoolState {}

class GetAllSchoolLoading extends GetAllSchoolState {}

class GetAllSchoolLoaded extends GetAllSchoolState {
  GetAllSchools model = GetAllSchools();

  GetAllSchoolLoaded({required this.model});
}

class GetAllSchoolError extends GetAllSchoolState {
  String? error;

  GetAllSchoolError({this.error});
}
