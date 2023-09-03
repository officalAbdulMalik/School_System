import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/controllers/cubits/common_cubit/get_all_meetings_cubit.dart';
import 'package:school_system/controllers/cubits/common_cubit/get_all_school_cubit.dart';
import 'package:school_system/controllers/cubits/common_cubit/get_parents_teachers_cubit.dart';
import 'package:school_system/controllers/cubits/common_cubit/history_mettings_cubit.dart';
import 'package:school_system/controllers/cubits/common_cubit/sign_up_cubit.dart';

import 'cubits/common_cubit/get_user_data_cubit.dart';
import 'cubits/parent_cubit/get_school_teacher_cubit.dart';
import 'cubits/parent_cubit/teacher_classes_cubit.dart';
import 'cubits/teacher_cubit/get_class_student_cubit.dart';
import 'cubits/teacher_cubit/get_section_cubit.dart';
import 'cubits/teacher_cubit/get_teacher_subject_cubit.dart';
import 'cubits/teacher_cubit/show_teacher_class_cubit.dart';

List<BlocProvider> appProviders = [
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
];
