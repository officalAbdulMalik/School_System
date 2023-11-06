import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/notification_repo.dart';
import 'package:school_system/Models/notifications_model.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  getNotifications({bool? loading}) async {
    await Future.delayed(Duration.zero);

    if (loading == null) {
      emit(NotificationsLoading());
    }

    try {
      await Notifications.getData().then((value) {
        if (value['code'] == 200) {
          var notifications = List<NotificationsModel>.from(
              value['data'].map((x) => NotificationsModel.fromMap(x)));
          emit(NotificationsLoaded(
              notifications: notifications, loading: loading));
        } else {
          emit(NotificationsError(error: value['message']));
        }
      }).catchError((e) {
        emit(NotificationsError(error: 'Some Thing Wrong'));
        throw e;
      });
    } catch (e) {
      emit(NotificationsError(error: e.toString()));
      rethrow;
    }
  }
}
