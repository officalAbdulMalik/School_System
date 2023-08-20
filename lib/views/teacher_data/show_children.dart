import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/controllers/cubits/teacher_cubit/get_class_student_cubit.dart';
import 'package:school_system/views/utils/colors.dart';

import '../../controllers/cubits/teacher_cubit/show_teacher_class_cubit.dart';

class ShowChildren extends StatefulWidget {
  const ShowChildren({Key? key}) : super(key: key);

  @override
  State<ShowChildren> createState() => _ShowChildrenState();
}

class _ShowChildrenState extends State<ShowChildren> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Class Students',
          style: GoogleFonts.acme(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: kButtonColor,
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
        children: [
          SizedBox(
            height: 20.h,
          ),
          BlocBuilder<GetClassStudentCubit, GetClassStudentState>(
            builder: (context, state) {
              if (state is GetClassStudentLoading) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: LoadingAnimationWidget.fallingDot(
                      color: Colors.white,
                      size: 50.sp,
                    )),
                  ],
                );
              } else if (state is GetClassStudentLoaded) {
                return state.model.data!.isNotEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: 400.w,
                        child: ListView.separated(
                          itemCount: state.model.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.white,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 40.sp,
                                  backgroundImage:
                                      state.model.data![index].image != null
                                          ? NetworkImage(
                                              state.model.data![index].image!)
                                          : AssetImage('images/prof.png')
                                              as ImageProvider,
                                ),
                                title:
                                    Text(state.model.data![index].firstName!),
                                subtitle:
                                    Text(state.model.data![index].lastName!),
                                trailing:
                                    Text(state.model.data![index].language),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox();
                          },
                        ),
                      )
                    : Center(
                        child: Text(
                          'No Student Found Found',
                          style: GoogleFonts.acme(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
              } else {
                return Text('Data Issue');
              }
            },
          )
        ],
      ),
    );
  }
}
