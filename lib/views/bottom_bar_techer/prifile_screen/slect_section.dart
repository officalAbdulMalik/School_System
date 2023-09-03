import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/controllers/apis_repo/teacher_apis/teacher_create_class.dart';
import 'package:school_system/views/bottom_bar_techer/prifile_screen/show_class.dart';
import 'package:school_system/views/bottom_bar_techer/prifile_screen/teacher_add_clases.dart';

import '../../../controllers/cubits/teacher_cubit/get_section_cubit.dart';
import '../../utils/colors.dart';
import '../../utils/custom_widget/custom_widgets.dart';
import 'create_new_section.dart';

class SelectSection extends StatefulWidget {
  const SelectSection({Key? key}) : super(key: key);

  @override
  State<SelectSection> createState() => _SelectSectionState();
}

class _SelectSectionState extends State<SelectSection> {
  @override
  void initState() {
    context.read<GetSectionCubit>().getSections();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        backgroundColor: kButtonColor,
        centerTitle: true,
        title: Text(
          'Select Section',
          style: GoogleFonts.acme(
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: kPrimaryColor,
      body: ListView(
        padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
        children: [
          SizedBox(
            height: 50.h,
          ),
          BlocBuilder<GetSectionCubit, GetSectionState>(
            builder: (context, state) {
              if (state is GetSectionLoading) {
                return CustomWidgets.loadingIndicator();
              } else if (state is GetSectionLoaded) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height.h,
                  width: 400.w,
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10.h,
                      );
                    },
                    itemCount: state.model.sections!.length,
                    itemBuilder: (context, index) {
                      return state.model.sections!.isNotEmpty
                          ? InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return TeacherAddClass(
                                      sectionId: state
                                          .model.sections![index].id!
                                          .toString(),
                                      schoolId: state
                                          .model.sections![index].schoolId!
                                          .toString(),
                                    );
                                  },
                                ));
                              },
                              child: Container(
                                height: 50.h,
                                width: 400.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                child: Center(
                                  child: Text(
                                    state.model.sections![index].name!,
                                    style: GoogleFonts.acme(
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: Text(
                                'No have any section',
                                style: GoogleFonts.acme(
                                  fontSize: 20.sp,
                                  color: Colors.white,
                                ),
                              ),
                            );
                    },
                  ),
                );
              } else if (state is GetSectionError) {
                return Text('Some Errors');
              } else {
                return Text('');
              }
            },
          ),
        ],
      ),
    );
  }
}
