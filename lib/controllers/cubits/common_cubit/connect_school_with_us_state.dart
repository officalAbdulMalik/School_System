part of 'connect_school_with_us_cubit.dart';

@immutable
abstract class ConnectSchoolWithUsState {}

class ConnectSchoolWithUsInitial extends ConnectSchoolWithUsState {}

class ConnectSchoolLoading extends ConnectSchoolWithUsState {}

class ConnectSchoolWithUsLoaded extends ConnectSchoolWithUsState {}

class ConnectSchoolWithUsError extends ConnectSchoolWithUsState {
  String? error;

  ConnectSchoolWithUsError({this.error});
}
