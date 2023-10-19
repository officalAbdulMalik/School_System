part of 'get_user_data_cubit.dart';

@immutable
abstract class GetUserDataState {}

class GetUserDataInitial extends GetUserDataState {}

class GetUserDataLoading extends GetUserDataState {}

class GetUserDataLoaded extends GetUserDataState {
  UserData? model;

  GetUserDataLoaded({this.model});
}

class GetUserDataError extends GetUserDataState {
  String? error;

  GetUserDataError({this.error});
}
