part of 'get_all_meetings_cubit.dart';

@immutable
abstract class GetAllMeetingsState {}

class GetAllMeetingsInitial extends GetAllMeetingsState {}

class GetAllMeetingsLoading extends GetAllMeetingsState {}

class GetAllMeetingsLoaded extends GetAllMeetingsState {
  GetAllMettings mettings = GetAllMettings();

  GetAllMeetingsLoaded({required this.mettings});
}

class GetAllMeetingsError extends GetAllMeetingsState {
  String error = '';

  GetAllMeetingsError(this.error);
}
