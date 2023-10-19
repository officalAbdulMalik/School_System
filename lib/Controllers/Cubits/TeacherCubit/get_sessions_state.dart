part of 'get_sessions_cubit.dart';

@immutable
abstract class GetSessionsState {}

class GetSessionsInitial extends GetSessionsState {}

class GetSessionsLoading extends GetSessionsState {}

class GetSessionsLoaded extends GetSessionsState {
  List<GetSessiosn>? data;

  GetSessionsLoaded({this.data});
}

class GetSessionsError extends GetSessionsState {
  String? error;

  GetSessionsError({this.error});
}
