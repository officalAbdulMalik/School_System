import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as dM;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:school_system/Controllers/AgoraIntegration/agora_initlization.dart';
import 'package:school_system/Controllers/firebase_repos/palyodStream.dart';
import 'package:school_system/Models/get_all_mettings.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/common/views/bottom_bar.dart';
import 'package:school_system/Presentation/common/views/dashboard_screen/meeting_details.dart';
import 'package:school_system/Presentation/common/views/loginScreen.dart';
import 'package:school_system/Presentation/common/views/notification_screen/notification_screen.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

import 'firebase_notifications.dart';

// class NotificationMetaServices {
//   static ValueNotifier<String?> remoteMessageCheck = ValueNotifier(null);
//   static ValueNotifier<String?> routeNotifier = ValueNotifier(null);
//   static BuildContext? context;
//   static void setContext(BuildContext context) =>
//       NotificationMetaServices.context = context;
//
//   ///notification initiation
//   void messagingInitiation() async {
//     // String? fcmToken = await FirebaseMessaging.instance.getToken();
//     await Firebase.initializeApp();
//     await FirebaseMessaging.instance.getNotificationSettings();
//
//     // log('FCM Token:$fcmToken');
//
//     // FirebaseMessaging.onMessageOpenedApp.listen((e) async {
//     //   var data = await e.notification!.body;
//     //   print("On Message Opened App $data");
//     //   log("checking logs for messages onMessageOpened ");
//     //   // PushNotificationServices()
//     //   //     .showNotification(1, e.notification!.title!, e.notification!.body!);
//     // });
//   }
//
//   // ///Background/terminated state notification handler for showing only notification
//   // void backgroundNotificationHandler(){
//   //   FirebaseMessaging.onBackgroundMessage((e) async {
//   //     final id = dM.Random().nextInt(20000);
//   //     // var data = await e.notification!.body;
//   //     print("Running Background notification $e");
//   //     if(e.notification != null) {
//   //     //  String? title= e.notification.title;
//   //       NotificationServices()
//   //       .showNotification(id, e.notification!.title.toString(), e.notification!.body.toString());
//   //     }
//   //     return;
//   //   });
//   //
//   //
//   // }
//   ///foreground Notification handler  stream is listen
//   void foregroundNotificationHandler({BuildContext? context}) {
//     FirebaseMessaging.onMessage.listen((e) async {
//       final id = dM.Random().nextInt(2000);
//       print("OnMessage ${e.notification!.title}");
//       // log("checking logs for messages on message ${e.messageId}  ${e.category}  ${e.from}  ${e.messageType}   ${e.contentAvailable}  data  ${e.data.entries}  title: ${e.ttl}");
//       log(e.toMap().toString());
//
//       //print();
//       String payloadData = e.data['info'].toString();
//       String imageUrl = e.data['image'].toString();
//       String notifyId = e.data['notifyURL'].toString();
//
//       print("-----notificationpayload---$payloadData");
//
//       FirebaseNotificationsService().showNotification(
//           id, e.notification!.title!, e.notification!.body!,
//           payload: payloadData);
//
//       // if(payloadData =='request') {
//       //   CustomDialog.dialog(context!,  BannerExample(imageUrl: imageUrl, description: e.notification!.body!),alignment: Alignment.topCenter, barr: true);
//       // }
//
// //       ScaffoldMessenger.of(context!).showMaterialBanner(MaterialBanner(
// //
// //           elevation: 20,
// //           content: BannerExample(), actions: [CustomButton( onTap: () {  }, text: '',)]));
// // ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
// //
// //   width: 1.sw,
// //   content: BannerExample(),behavior: SnackBarBehavior.floating,
// //   duration: const Duration(seconds: 3),
// // ));
//       print(context);
//       // context?.read<NotificationUserCubit>().getUserNotifications(check:false);
//       // context?.read<RequestReceivedCubit>().receivedRequest(check: false);
//
//       // handleMessage(e,context: context);
//     }).onError((error) {
//       print("checking logs $error");
//     });
//   }
//
//   ///backgroundNotification when tap this function will be called'' By background it means the resume state of android/iOS LIFECYCLE
//   void backgroundNotificationOnTapHandler({BuildContext? context}) {
//     FirebaseMessaging.onMessageOpenedApp.listen((e) async {
//       var data = e.notification!.title;
//       print("On Message Opened App $data");
//       // NotificationMetaServices.context?.read<NotificationUserCubit>().getUserNotifications(check:false);
//
//       handleMessage(e, context: NotificationMetaServices.context);
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(
//       //     builder: (context) => NotificationScreen(guest: false),
//       //   ),
//       // );
//     });
//   }
//
//   ///from terminated state opening
//   void terminatedFromOnTapStateHandler(
//       {BuildContext? context, String? payLoadData}) {
//     if (payLoadData != null) {
//       // handleNavigation(context, payLoadData);
//
//       // handleMessage(!,context: context);
//       // if(context!.mounted) {
//       //   if(remoteMessageCheck.value?.notification?.title != null) {
//       //     CustomDialog.dialog(context, Center(child: Text("From Terminated ${remoteMessageCheck.value?.notification!.title}"),));
//       //   }
//       // }
//     }
//   }
//
//   ///HANDLING THE REMOTE MESSAGE FOR NAVIGATION
//   void handleMessage(RemoteMessage message, {BuildContext? context}) {
//     //print(message.data['info']);
//     if (message.notification != null) {
//       String payloadData = message.data['info'].toString();
//       // handleNavigation(context,payloadData);
//     }
//     // if (message.data['type'] == 'chat') {
//     //   // Navigator.pushNamed(context, '/chat',
//     //   //   arguments: ChatArguments(message),
//     //   // );
//     // }
//   }
//
//   ///handling notification from foreground
//   // notificationPayload(
//   //     BuildContext context,
//   //     ) {
//   //   PayloadStream.instance.getPayload.listen((event) {
//   //     String caseCurrent = event.split('.').last;
//   //     print("notification from tap$event");
//   //
//   //     handleNavigation(NotificationMetaServices.context,event);
//   //     switch (caseCurrent) {
//   //       case 'pdf':
//   //         Navigate.to(context, AppPDFView(path: event));
//   //         break;
//   //       default:
//   //     }
//   //   });
//   // }
//   // List<Map<String,Widget>> navigationNotificationListPlayer=[{'all':  const NotificationsDash()},
//   //   {'request':const NotificationsDash(tabIndex: 1,)},
//   //   {'receive_request':const NotificationsDash()},
//   //   {'tournament':const PlayerTournamentListing()},
//   //   {'matches': const PlayerMatchesList()},
//   //   {'training':const PlayerTrainingList()},
//   //   {'goals':const PlayerGoalPlannerScreen()},
//   //   {'task': const PlayerTasksList()},
//   //   {'activity':const PlayerWeeklySchedules()}
//   //
//   // ];
//   // List<Map<String,Widget>> navigationNotificationListCoach=[{'all':  const NotificationsDash()},
//   //   {'request':const NotificationsDash(tabIndex: 1,)},
//   //   {'receive_request':const NotificationsDash()},
//   //   {'tournament':const CoachTrainingListing()},
//   //   {'players': const CoachAllPlayerListing()},
//   //   {'training':const CoachTrainingListing()},
//   //   {'goals':const CoachGoalPlanner()},
//   //   {'task': const CoachTaskList()},
//   //   {'activity':const CoachWeeklySchedules()}
//   // ];
//   // void handleNavigation(BuildContext? context,String cases) {
//   //
//   //   print(cases);
//   //   print(context);
//   //   if(context != null )
//   //   {
//   //
//   //     for(Map<String,Widget> i in SharedPrefs.userData?.user.role == "player"? navigationNotificationListPlayer:navigationNotificationListCoach)
//   //     {
//   //       if(i.containsKey(cases))
//   //       {
//   //         if(routeNotifier.value!=cases) {
//   //           Navigate.to(context, i[cases]!);
//   //         }
//   //
//   //         break;
//   //       }
//   //
//   //
//   //     }
//   //
//   //
//   //
//   //   }
//   //
//   //
//   //
//   // }
//
//   Future<void> sendFCMNotification(
//       String recipientToken, String title, String body) async {
//     final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
//     final serverKey =
//         'YOUR_FIREBASE_SERVER_KEY'; // Replace with your Firebase project's server key
//
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'key=$serverKey',
//     };
//
//     final data = {
//       'notification': {
//         'title': title,
//         'body': body,
//       },
//       'to': recipientToken,
//     };
//
//     final response =
//         await http.post(url, headers: headers, body: jsonEncode(data));
//
//     if (response.statusCode == 200) {
//       print('FCM notification sent successfully.');
//     } else {
//       print('Failed to send FCM notification: ${response.body}');
//     }
//   }
// }

class NotificationMetaServices {
  static ValueNotifier<String?> remoteMessageCheck = ValueNotifier(null);
  static ValueNotifier<String?> routeNotifier = ValueNotifier(null);
  static BuildContext? context;
  static void setContext(BuildContext context) =>
      NotificationMetaServices.context = context;

  ///notification initiation
  void messagingInitiation() async {
    // String? fcmToken = await FirebaseMessaging.instance.getToken();
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.getNotificationSettings();

    // log('FCM Token:$fcmToken');

    // FirebaseMessaging.onMessageOpenedApp.listen((e) async {
    //   var data = await e.notification!.body;
    //   print("On Message Opened App $data");
    //   log("checking logs for messages onMessageOpened ");
    //   // PushNotificationServices()
    //   //     .showNotification(1, e.notification!.title!, e.notification!.body!);
    // });
  }

  // ///Background/terminated state notification handler for showing only notification
  // void backgroundNotificationHandler(){
  //   FirebaseMessaging.onBackgroundMessage((e) async {
  //     final id = dM.Random().nextInt(20000);
  //     // var data = await e.notification!.body;
  //     print("Running Background notification $e");
  //     if(e.notification != null) {
  //     //  String? title= e.notification.title;
  //       NotificationServices()
  //       .showNotification(id, e.notification!.title.toString(), e.notification!.body.toString());
  //     }
  //     return;
  //   });
  //
  //
  // }
  ///foreground Notification handler  stream is listen
  void foregroundNotificationHandler({BuildContext? context}) {
    FirebaseMessaging.onMessage.listen((e) async {
      final id = dM.Random().nextInt(2000);

      // log("checking logs for messages on message ${e.messageId}  ${e.category}  ${e.from}  ${e.messageType}   ${e.contentAvailable}  data  ${e.data.entries}  title: ${e.ttl}");
      // NotificationServices().showNotification(
      //     id, e.notification!.title.toString(), e.notification!.body.toString(),
      //     payload: e.notification!.title);
      //print();

      Timer t = Timer(const Duration(seconds: 5), () {});

      Dialogs.dialog(
          context!,
          Container(
            height: 100,
            width: 200,
            color: Colors.redAccent,
          ),
          bgColor: Colors.transparent,
          alignment: Alignment.topCenter,
          barr: false,
          autoDismiss: true,
          timerDialog: t);

//
//       if(payloadData =='request' || payloadData=='invitation') {
//         Timer t=Timer(const Duration(seconds: 5), () {
//           Navigator.of(context!).pop(true);
//
//         });
//         CustomDialog.dialog(context!,  BannerExample(imageUrl: imageUrl, description: e.notification!.body!,payloadData:payloadData,timerDialog:t),
//
//             bgColor: Colors.transparent,alignment: Alignment.topCenter, barr: false,autoDismiss: true,timerDialog:t);
// // App.instance.snackBar(context!,child: BannerExample(imageUrl: imageUrl, description:  e.notification!.body!, payloadData: payloadData),margin:EdgeInsets.only(
// // bottom: MediaQuery.of(context).size.height - 150,
// //       left: 10,
// //       right: 10));
//         // await Future.delayed(const Duration(milliseconds: 5000));
//         // Navigator.of(context).pop(true);
//       }
//       else
//       {
//         NotificationServices()
//             .showNotification(id, e.notification!.title!, e.notification!.body!,payload: payloadData);
//       }

//       ScaffoldMessenger.of(context!).showMaterialBanner(MaterialBanner(
//
//           elevation: 20,
//           content: BannerExample(), actions: [CustomButton( onTap: () {  }, text: '',)]));
// ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
//
//   width: 1.sw,
//   content: BannerExample(),behavior: SnackBarBehavior.floating,
//   duration: const Duration(seconds: 3),
// ));

      handleMessage(e, context: context);
    }).onError((error) {
      print("checking logs $error");
    });
  }

  ///backgroundNotification when tap this function will be called'' By background it means the resume state of android/iOS LIFECYCLE
  void backgroundNotificationOnTapHandler({BuildContext? context}) {
    FirebaseMessaging.onMessageOpenedApp.listen((e) async {
      var data = e.notification!.title;
      print("On Message Opened App $data");
      // NotificationMetaServices.context?.read<NotificationUserCubit>().getUserNotifications(check:false);

      handleMessage(e, context: NotificationMetaServices.context);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => NotificationScreen(guest: false),
      //   ),
      // );
    });
  }

  ///from terminated state opening
  void terminatedFromOnTapStateHandler(
      {BuildContext? context, String? payLoadData}) {
    if (payLoadData != null) {
      // handleNavigation(context, payLoadData);

      // handleMessage(payLoadData,);
      if (context!.mounted) {
        //   if(remoteMessageCheck.value?.notification?.title != null) {
        //     CustomDialog.dialog(context, Center(child: Text("From Terminated ${remoteMessageCheck.value?.notification!.title}"),));
        //   }
        // }
      }
    }
  }

  ///HANDLING THE REMOTE MESSAGE FOR NAVIGATION
  void handleMessage(RemoteMessage message, {BuildContext? context}) {
    //print(message.data['info']);
    if (message.notification != null) {
      String payloadData = message.data.toString();

      print("here is the payload $payloadData");

      // if (message.data['type'] == 'chat') {
      //   Navigator.push(context!, MaterialPageRoute(
      //     builder: (context) {
      //       return LogInScreen();
      //     },
      //   ));
      // }

      handleNavigation(context, message);
    }
  }

  ///handling notification from foreground
  notificationPayload(
    BuildContext context,
  ) {
    PayloadStream.instance.getPayload.listen((event) {
      String caseCurrent = event.split('.').last;
      print("notification from tap$event");

      // handleNavigation(NotificationMetaServices.context, caseCurrent);
    });
  }

  // List<Map<String,Widget>> navigationNotificationListPlayer=[{'all':  const NotificationsDash()},
  //   {'request':const NotificationsDash(tabIndex: 1,)},
  //   {'receive_request':const NotificationsDash()},
  //   {'tournament':const PlayerTournamentListing()},
  //   {'matches': const PlayerMatchesList()},
  //   {'training':const PlayerTrainingList()},
  //   {'goals':const PlayerGoalPlannerScreen()},
  //   {'task': const PlayerTasksList()},
  //   {'activity':const PlayerWeeklySchedules()}
  //
  // ];
  // List<Map<String,Widget>> navigationNotificationListCoach=[{'all':  const NotificationsDash()},
  //   {'request':const NotificationsDash(tabIndex: 1,)},
  //   {'receive_request':const NotificationsDash()},
  //   {'tournament':const CoachTournamentListing()},
  //   {'players': const CoachAllPlayerListing()},
  //   {'training':const CoachTrainingListing()},
  //   {'goals':const CoachGoalPlanner()},
  //   {'task': const CoachTaskList()},
  //   {'activity':const CoachWeeklySchedules()},
  //   {'tournamentMatches':const CoachTournamentListing()}
  // ];
  void handleNavigation(BuildContext? context, RemoteMessage event) {
    print(event.data['type']);

    String? userExist =
        LoginApiShadePreference.preferences?.getString('api_token') ?? "";

    print(context);

    if (context != null) {
      print((event.data['type'].toString()));

      if (event.data['type'].toString().trim() == 'MEETING') {
        AllMeetings? data = AllMeetings.fromMap(event.data);

        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return MeetingsDetails(meetings: data);
          },
        ));
      } else {
        print('Bottom Bar Navigation');

        if (userExist.isNotEmpty) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const NotificationScreen();
            },
          ));
        } else {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return LogInScreen();
            },
          ));
        }
      }
    }
  }
}
