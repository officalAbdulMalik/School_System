import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_system/controllers/cubits/common_cubit/get_all_meetings_cubit.dart';
import 'package:school_system/controllers/cubits/common_cubit/get_all_school_cubit.dart';
import 'package:school_system/controllers/cubits/common_cubit/send_email_otp_cubit.dart';
import 'package:school_system/controllers/cubits/common_cubit/sign_up_cubit.dart';
import 'Presentation/common/views/all_school_screen.dart';
import 'Presentation/common/views/bottom_bar.dart';
import 'Presentation/common/views/loginScreen.dart';
import 'Presentation/utils/shade_prefrence.dart';
import 'controllers/agora_integration/agora_initlization.dart';
import 'controllers/cubits/common_cubit/accept_reject_mettings_cubit.dart';
import 'controllers/cubits/common_cubit/add_metting_cubit.dart';
import 'controllers/cubits/common_cubit/connect_school_with_us_cubit.dart';
import 'controllers/cubits/common_cubit/delate_account_cubit.dart';
import 'controllers/cubits/common_cubit/login_cubit.dart';
import 'controllers/cubits/common_cubit/new_password_cubit.dart';
import 'controllers/cubits/common_cubit/students_reports_cubit.dart';
import 'controllers/cubits/common_cubit/verify_otp_cubit.dart';
import 'controllers/cubits/parent_cubit/add_child_cubit.dart';
import 'controllers/cubits/parent_cubit/assign_child_to_class_cubit.dart';
import 'controllers/cubits/parent_cubit/get_school_teacher_cubit.dart';
import 'controllers/cubits/parent_cubit/teacher_classes_cubit.dart';
import 'controllers/cubits/teacher_cubit/add_attendance_cubit.dart';
import 'controllers/cubits/teacher_cubit/add_report_cubit.dart';
import 'controllers/cubits/teacher_cubit/add_section_cubit.dart';
import 'controllers/cubits/teacher_cubit/create_subjects_cubit.dart';
import 'controllers/cubits/teacher_cubit/get_class_student_cubit.dart';
import 'controllers/cubits/teacher_cubit/get_querters_cubit.dart';
import 'controllers/cubits/teacher_cubit/get_section_cubit.dart';
import 'controllers/cubits/common_cubit/get_parents_teachers_cubit.dart';
import 'controllers/cubits/common_cubit/get_user_data_cubit.dart';
import 'controllers/cubits/teacher_cubit/get_sessions_cubit.dart';
import 'controllers/cubits/teacher_cubit/get_subjects_cubit.dart';
import 'controllers/cubits/teacher_cubit/get_teacher_subject_cubit.dart';
import 'controllers/cubits/teacher_cubit/show_class_attendance_cubit.dart';
import 'controllers/cubits/teacher_cubit/show_teacher_class_cubit.dart';
import 'package:timezone/standalone.dart' as tz;

import 'controllers/cubits/teacher_cubit/teacher_create_class_cubit.dart';
import 'controllers/firebase_repos/firebase_notification.dart';

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
  await Firebase.initializeApp();
  await LoginApiShadePreference.getInit();
  // await tz.initializeTimeZone();
  FirebaseNotificationsService().initNotification();

  HttpOverrides.global = MyHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  String? userExist =
      LoginApiShadePreference.preferences?.getString('api_token') ?? "";

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
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              ),
              home: userExist!.isEmpty ? LogInScreen() : BottomBarPages(),
            ),
          );
        });
  }
}
