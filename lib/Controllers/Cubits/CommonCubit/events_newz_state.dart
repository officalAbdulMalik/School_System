part of 'events_newz_cubit.dart';

@immutable
abstract class EventsNewsState {}

class EventsNewsInitial extends EventsNewsState {}

class EventsNewsLoading extends EventsNewsState {}

class EventsNewsLoaded extends EventsNewsState {
  List<NewsEvents>? newsEvents;

  EventsNewsLoaded({this.newsEvents});
}

class EventsNewsError extends EventsNewsState {
  String? error;

  EventsNewsError({this.error});
}
