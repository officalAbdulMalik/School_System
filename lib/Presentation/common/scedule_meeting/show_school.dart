// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:school_system/Controllers/Cubits/CommonCubit/get_all_school_cubit.dart';
// import 'package:school_system/Presentation/common/resources/dailog.dart';
// import 'package:school_system/Presentation/common/views/shool_addInInfo.dart';
// import 'package:school_system/Presentation/utils/colors.dart';
// import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
//
// import '../../utils/custom_widget/custom_row_widget.dart';
// import '../../utils/custom_widget/navigator_pop.dart';
// import 'add_participant_screen.dart';
//
// class ShowSchool extends StatefulWidget {
//   ShowSchool({Key? key}) : super(key: key);
//
//   @override
//   State<ShowSchool> createState() => _ShowSchoolState();
// }
//
// class _ShowSchoolState extends State<ShowSchool> {
//   final ValueNotifier<bool> showPassword = ValueNotifier(false);
//
//   String type = '';
//
//   @override
//   void initState() {
//     context
//         .read<GetAllSchoolCubit>()
//         .getAllSchool('/api/get/teacher/schools?name=');
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           physics: NeverScrollableScrollPhysics(),
//           child: Padding(
//             padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const NavigatorPop(),
//                 SizedBox(height: 5.h),
//                 CustomRowWidget(
//                   text1: 'Find Your School',
//                   text2: 'Select Your school from here...',
//                   image: 'add_s_star.png',
//                 ),
//                 SizedBox(
//                   height: 15.h,
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
