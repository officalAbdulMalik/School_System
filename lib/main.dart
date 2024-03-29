import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/add_new_school_cubit.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/notifications_cubit.dart';
import 'package:school_system/Controllers/firebase_repos/firebase_notifications.dart';
import 'package:school_system/Presentation/BottomBarParent/profile_screens/show_teacher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Controllers/Cubits/CommonCubit/accept_reject_mettings_cubit.dart';
import 'Controllers/Cubits/CommonCubit/add_metting_cubit.dart';
import 'Controllers/Cubits/CommonCubit/connect_school_with_us_cubit.dart';
import 'Controllers/Cubits/CommonCubit/create_chat_cubit.dart';
import 'Controllers/Cubits/CommonCubit/delate_account_cubit.dart';
import 'Controllers/Cubits/CommonCubit/edit_profile_cubit.dart';
import 'Controllers/Cubits/CommonCubit/events_newz_cubit.dart';
import 'Controllers/Cubits/CommonCubit/get_all_meetings_cubit.dart';
import 'Controllers/Cubits/CommonCubit/get_all_school_cubit.dart';
import 'Controllers/Cubits/CommonCubit/get_parents_teachers_cubit.dart';
import 'Controllers/Cubits/CommonCubit/get_user_data_cubit.dart';
import 'Controllers/Cubits/CommonCubit/login_cubit.dart';
import 'Controllers/Cubits/CommonCubit/new_password_cubit.dart';
import 'Controllers/Cubits/CommonCubit/send_email_otp_cubit.dart';
import 'Controllers/Cubits/CommonCubit/sign_up_cubit.dart';
import 'Controllers/Cubits/CommonCubit/students_reports_cubit.dart';
import 'Controllers/Cubits/CommonCubit/verify_otp_cubit.dart';
import 'Controllers/Cubits/ParentCubit/add_child_cubit.dart';
import 'Controllers/Cubits/ParentCubit/assign_child_to_class_cubit.dart';
import 'Controllers/Cubits/ParentCubit/get_school_teacher_cubit.dart';
import 'Controllers/Cubits/ParentCubit/student_attendance_cubit.dart';
import 'Controllers/Cubits/ParentCubit/teacher_classes_cubit.dart';
import 'Controllers/Cubits/TeacherCubit/add_attendance_cubit.dart';
import 'Controllers/Cubits/TeacherCubit/add_report_cubit.dart';
import 'Controllers/Cubits/TeacherCubit/add_section_cubit.dart';
import 'Controllers/Cubits/TeacherCubit/class_reports_cubit.dart';
import 'Controllers/Cubits/TeacherCubit/create_subjects_cubit.dart';
import 'Controllers/Cubits/TeacherCubit/get_class_student_cubit.dart';
import 'Controllers/Cubits/TeacherCubit/get_querters_cubit.dart';
import 'Controllers/Cubits/TeacherCubit/get_section_cubit.dart';
import 'Controllers/Cubits/TeacherCubit/get_sessions_cubit.dart';
import 'Controllers/Cubits/TeacherCubit/get_subjects_cubit.dart';
import 'Controllers/Cubits/TeacherCubit/get_teacher_subject_cubit.dart';
import 'Controllers/Cubits/TeacherCubit/show_class_attendance_cubit.dart';
import 'Controllers/Cubits/TeacherCubit/show_teacher_class_cubit.dart';
import 'Controllers/Cubits/TeacherCubit/teacher_create_class_cubit.dart';
import 'Controllers/firebase_repos/firebase_notification_meta.dart';
import 'Presentation/common/views/bottom_bar.dart';
import 'Presentation/common/views/loginScreen.dart';
import 'Presentation/utils/shade_prefrence.dart';
import 'dart:math' as dM;

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("_messaging onBackgroundMessage: ${message.notification!.title!} ${message.notification!.body!}");
  final id = dM.Random().nextInt(20000);
  // var data = await e.notification!.body;
  print("Running Background notification $message");
  if (message.notification != null) {
    //  String? title= e.notification.title;
    NotificationServices().showNotification(
        id,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        payload: message.notification!.title);
  }

  return;
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // AgoraInit().initAgora();
  await Firebase.initializeApp(
  );
  await LoginApiShadePreference.getInit();
  // await tz.initializeTimeZone();
  await NotificationServices().initNotification();

  // await FlutterDownloader.initialize(
  //     debug: true,
  //     ignoreSsl:
  //         true // option: set to false to disable working with http links (default: false)
  //     );

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  print(
      "MESSAGE ${message?.notification?.title} ${message?.notification?.body}");
  String? payloadData = message?.data['info'].toString();

  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  final String? payLoadData;

  const MyApp({super.key, this.payLoadData});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String userExist =
      LoginApiShadePreference.preferences?.getString('api_token') ?? "";

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  void initState() {
    // NotificationMetaServices.remoteMessageCheck.value = widget.payLoadData;
    // initiateAllNotifications();
    _initGoogleMobileAds();
    // TODO: implement initState
    super.initState();
  }

  void initiateAllNotifications() async {
    //print(await NotificationServices.getFcm());
    NotificationMetaServices().messagingInitiation();
    NotificationMetaServices().foregroundNotificationHandler(context: context);
    NotificationMetaServices()
        .backgroundNotificationOnTapHandler(context: context);

    NotificationMetaServices().terminatedFromOnTapStateHandler(
        context: context, payLoadData: widget.payLoadData);
    NotificationMetaServices().notificationPayload(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => GetTeacherSubjectCubit()),
                BlocProvider(create: (context) => TeacherClassesCubit()),
                BlocProvider(create: (context) => GetSchoolTeacherCubit()),
                BlocProvider(create: (context) => GetClassStudentCubit()),
                BlocProvider(create: (context) => GetSectionCubit()),
                BlocProvider(create: (context) => ShowTeacherClassCubit()),
                BlocProvider(create: (context) => GetUserDataCubit()),
                BlocProvider(create: (context) => GetParentsTeachersCubit()),
                BlocProvider(create: (context) => GetAllSchoolCubit()),
                BlocProvider(create: (context) => GetAllMeetingsCubit()),
                BlocProvider(create: (context) => SignUpCubit()),
                BlocProvider(create: (context) => AcceptRejectMeetingsCubit()),
                BlocProvider(create: (context) => AddMettingCubit()),
                BlocProvider(create: (context) => ConnectSchoolWithUsCubit()),
                BlocProvider(create: (context) => LoginCubit()),
                BlocProvider(create: (context) => TeacherCreateClassCubit()),
                BlocProvider(create: (context) => AddSectionCubit()),
                BlocProvider(create: (context) => GetSubjectsCubit()),
                BlocProvider(create: (context) => CreateSubjectsCubit()),
                BlocProvider(create: (context) => ShowClassAttendanceCubit()),
                BlocProvider(create: (context) => GetQuertersCubit()),
                BlocProvider(create: (context) => GetSessionsCubit()),
                BlocProvider(create: (context) => AddReportCubit()),
                BlocProvider(create: (context) => AddAttendanceCubit()),
                BlocProvider(create: (context) => VerifyOtpCubit()),
                BlocProvider(create: (context) => SendEmailOtpCubit()),
                BlocProvider(create: (context) => NewPasswordCubit()),
                BlocProvider(create: (context) => DelateAccountCubit()),
                BlocProvider(create: (context) => StudentsReportsCubit()),
                BlocProvider(create: (context) => AddChildCubit()),
                BlocProvider(create: (context) => AssignChildToClassCubit()),
                BlocProvider(create: (context) => StudentAttendanceCubit()),
                BlocProvider(create: (context) => EditProfileCubit()),
                BlocProvider(create: (context) => EventsNewsCubit()),
                BlocProvider(create: (context) => ClassReportsCubit()),
                BlocProvider(create: (context) => GetParentsTeachersCubit()),
                BlocProvider(create: (context) => CreateChatCubit()),
                BlocProvider<NotificationsCubit>(
                    create: (context) => NotificationsCubit()),
                BlocProvider<AddNewSchoolCubit>(
                    create: (context) => AddNewSchoolCubit()),

              ],
              child: MaterialApp(
                home: userExist.isNotEmpty
                    ?   const BottomBarPages(index: 0,)
                    :  const LogInScreen(),
              ));
        });
  }
}
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(routes: {
//       "/": (_) => const WebviewScaffold(
//             url: "https://shashankpujari.com",
// //        appBar: new AppBar(
// //          title: new Text("WebView"),
// //        ),// AppBar
//           ) // WebviewScaffold
//     }); // MaterialApp
//   }
// }
