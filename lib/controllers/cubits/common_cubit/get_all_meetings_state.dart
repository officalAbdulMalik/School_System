part of 'get_all_meetings_cubit.dart';

@immutable
abstract class GetAllMeetingsState {}

class GetAllMeetingsInitial extends GetAllMeetingsState {}

class GetAllMeetingsLoading extends GetAllMeetingsState {}

class GetAllMeetingsLoaded extends GetAllMeetingsState {
  List<GetAllMeetings> meetings;

  GetAllMeetingsLoaded({required this.meetings});
}

class GetAllMeetingsError extends GetAllMeetingsState {
  String error = '';

  GetAllMeetingsError(this.error);
}
