part of 'accept_reject_mettings_cubit.dart';

@immutable
abstract class AcceptRejectMeetingsState {}

class AcceptRejectMeetingsInitial extends AcceptRejectMeetingsState {}

class AcceptRejectMeetingsLoading extends AcceptRejectMeetingsState {}

class AcceptRejectMeetingsLoaded extends AcceptRejectMeetingsState {}

class AcceptRejectMeetingsError extends AcceptRejectMeetingsState {
  String? error;

  AcceptRejectMeetingsError({this.error});
}
