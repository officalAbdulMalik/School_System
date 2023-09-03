import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_system/controllers/cubits/common_cubit/get_all_meetings_cubit.dart';
import 'package:school_system/controllers/cubits/common_cubit/get_all_school_cubit.dart';
import 'package:school_system/controllers/cubits/common_cubit/sign_up_cubit.dart';
import 'package:school_system/views/bottom_bar_parent/profile_screens/add_child_screen.dart';
import 'package:school_system/views/common/loginScreen.dart';
import 'package:school_system/views/common/onboarding_screen.dart';
import 'package:school_system/views/bottom_bar_techer/prifile_screen/teacher_add_clases.dart';
import 'package:school_system/views/bottom_bar_techer/prifile_screen/slect_section.dart';
import 'package:school_system/views/utils/shade_prefrence.dart';
import 'controllers/cubits/parent_cubit/get_school_teacher_cubit.dart';
import 'controllers/cubits/parent_cubit/teacher_classes_cubit.dart';
import 'controllers/cubits/teacher_cubit/get_class_student_cubit.dart';
import 'controllers/cubits/teacher_cubit/get_section_cubit.dart';
import 'controllers/cubits/common_cubit/get_parents_teachers_cubit.dart';
import 'controllers/cubits/common_cubit/get_user_data_cubit.dart';
import 'controllers/cubits/common_cubit/history_mettings_cubit.dart';
import 'controllers/cubits/teacher_cubit/get_teacher_subject_cubit.dart';
import 'controllers/cubits/teacher_cubit/show_teacher_class_cubit.dart';
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
  await Firebase.initializeApp();
  await LoginApiShadePreference.getInit();
  FirebaseNotificationsService().firebaseInit();

  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              BlocProvider(create: (context) => HistoryMeetingsCubit()),
              BlocProvider(create: (context) => GetAllSchoolCubit()),
              BlocProvider(create: (context) => GetAllMeetingsCubit()),
              BlocProvider(create: (context) => SignUpCubit()),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: LogInScreen(),
            ),
          );
        });
  }
}
