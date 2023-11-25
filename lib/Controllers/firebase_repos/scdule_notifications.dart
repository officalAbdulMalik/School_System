import 'package:firebase_messaging/firebase_messaging.dart';

class ScheduleNotifications{

  // Future<void> sendScheduledNotification() async {
  //   final FirebaseMessaging messaging = FirebaseMessaging.instance;
  //
  //   // Create a new topic for the notification
  //   final String topic = 'scheduled_notification';
  //
  //   // Set the time when the notification should be sent
  //   final DateTime scheduledTime = DateTime.now().add(Duration(minutes: 30));
  //
  //   // Calculate the number of seconds until the notification should be sent
  //   final int delay = scheduledTime.difference(DateTime.now()).inSeconds;
  //
  //   // Create the notification message
  //   final RemoteMessage message = RemoteMessage(
  //     data: <String, String>{
  //       'title': 'Scheduled Notification',
  //       'body': 'This is a scheduled notification',
  //     },
  //
  //   );
  //
  //   // Send the notification
  //   await messaging.se;
  // }

}