// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:school_system/Presentation/common/resources/dailog.dart';
// import 'package:school_system/Presentation/utils/colors.dart';
// import 'package:school_system/controllers/cubits/teacher_cubit/get_class_student_cubit.dart';
//
// import '../../../controllers/cubits/teacher_cubit/show_teacher_class_cubit.dart';
// import '../../utils/custom_widget/custom_widgets.dart';
//
// class ShowStudents extends StatefulWidget {
//   ShowStudents({Key? key, required this.classId}) : super(key: key);
//   String classId;
//
//   @override
//   State<ShowStudents> createState() => _ShowStudentsState();
// }
//
// class _ShowStudentsState extends State<ShowStudents> {
//   @override
//   void initState() {
//     context.read<GetClassStudentCubit>().getStudent(widget.classId);
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kPrimaryColor,
//       appBar: AppBar(
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: Text(
//           'Class Students',
//           style: GoogleFonts.acme(
//             color: Colors.white,
//             fontSize: 18.sp,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         backgroundColor: kButtonColor,
//       ),
//       body: ListView(
//         padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
//         children: [
//           SizedBox(
//             height: 20.h,
//           ),
//           BlocConsumer<GetClassStudentCubit, GetClassStudentState>(
//             listener: (context, state) {
//               if (state is GetClassStudentLoading) {
//                 LoadingDialog.showLoadingDialog(context);
//               }
//               if (state is GetClassStudentLoaded) {
//                 Navigator.pop(context);
//               }
//               if (state is GetClassStudentError) {
//                 Fluttertoast.showToast(msg: state.error!);
//               }
//             },
//             builder: (context, state) {
//               if (state is GetClassStudentLoaded) {
//                 return state.model.data!.isNotEmpty
//                     ? SizedBox(
//                         height: MediaQuery.of(context).size.height,
//                         width: 400.w,
//                         child: ListView.separated(
//                           itemCount: state.model.data!.length,
//                           itemBuilder: (context, index) {
//                             return Container(
//                               decoration: BoxDecoration(
//                                 color: kContainerColor,
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Colors.grey.withAlpha(80),
//                                       blurRadius: 2)
//                                 ],
//                               ),
//                               color: Colors.white,
//                               child: ListTile(
//                                 leading: CircleAvatar(
//                                   radius: 40.sp,
//                                   backgroundImage:
//                                       state.model.data![index].image != null
//                                           ? NetworkImage(
//                                               state.model.data![index].image!)
//                                           : AssetImage('images/prof.png')
//                                               as ImageProvider,
//                                 ),
//                                 title:
//                                     Text(state.model.data![index].firstName!),
//                                 subtitle:
//                                     Text(state.model.data![index].lastName!),
//                                 trailing:
//                                     Text(state.model.data![index].language),
//                               ),
//                             );
//                           },
//                           separatorBuilder: (context, index) {
//                             return SizedBox();
//                           },
//                         ),
//                       )
//                     : Center(
//                         child: Text(
//                           'No Student Found Found',
//                           style: GoogleFonts.acme(
//                             color: Colors.white,
//                             fontSize: 20.sp,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       );
//               } else {
//                 return Text('Data Issue');
//               }
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
