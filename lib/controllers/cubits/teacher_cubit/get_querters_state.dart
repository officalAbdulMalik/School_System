part of 'get_querters_cubit.dart';

@immutable
abstract class GetQuertersState {}

class GetQuertersInitial extends GetQuertersState {}

class GetQuertersLoading extends GetQuertersState {}

class GetQuertersLoaded extends GetQuertersState {
  List<Quarters>? list;

  GetQuertersLoaded({this.list});
}

class GetQuertersError extends GetQuertersState {
  String? error;

  GetQuertersError({this.error});
}
