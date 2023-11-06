part of 'notifications_cubit.dart';

@immutable
abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationsModel>? notifications;

  final bool? loading;

  NotificationsLoaded({this.notifications, this.loading});
}

class NotificationsError extends NotificationsState {
  final String? error;

  NotificationsError({this.error});
}
