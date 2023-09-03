import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/controllers/cubits/common_cubit/get_all_school_cubit.dart';
import 'package:school_system/models/get_all_school_model.dart';
import 'package:school_system/views/common/shool_addInInfo.dart';
import 'package:school_system/views/common/sign_up_screen.dart';
import 'package:school_system/views/utils/colors.dart';
import '../../controllers/apis_repo/school_in_info.dart';
import 'add_school_screen.dart';

class SchoolListScreen extends StatefulWidget {
  SchoolListScreen({Key? key}) : super(key: key);

  @override
  State<SchoolListScreen> createState() => _SchoolListScreenState();
}

class _SchoolListScreenState extends State<SchoolListScreen> {
  final ValueNotifier<bool> showPassword = ValueNotifier(false);

  String type = '';

  @override
  void initState() {
    context.read<GetAllSchoolCubit>().getAllSchool('/api/get/schools');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 30.sp,
          width: 40.sp,
          child: Center(
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return AddSchoolScreen();
                  },
                ));
              },
              child: RichText(
                text: TextSpan(
                    text: 'if want to add another School',
                    style: GoogleFonts.acme(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                    children: [
                      TextSpan(
                          text: ' Click here',
                          style: GoogleFonts.acme(
                            color: Colors.black,
                            fontSize: 14.sp,
                          )),
                    ]),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xFF2A3B5D),
          centerTitle: true,
          title: Text(
            'Find Your School',
            style: GoogleFonts.acme(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: kPrimaryColor,
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<GetAllSchoolCubit, GetAllSchoolState>(
          builder: (context, state) {
            if (state is GetAllSchoolLoaded) {
              print(state.model.data![0].image);
              return SizedBox(
                height: 1000.h,
                width: 500.w,
                child: state.model.data!.isNotEmpty
                    ? ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                        padding: EdgeInsets.only(
                            left: 10.sp, right: 10.sp, top: 30.sp),
                        itemCount: state.model.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    state.model.data![index].image ?? ''),
                              ),
                              title: Text(state.model.data![index].schoolName!),
                              trailing: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return SchoolAddInInfo(
                                        data: state.model.data!,
                                        index: index,
                                      );
                                    },
                                  ));
                                },
                                child: Container(
                                  height: 30.h,
                                  width: 30.w,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      size: 20.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'No School found',
                          style: GoogleFonts.acme(
                              color: Colors.white, fontSize: 20.sp),
                        ),
                      ),
              );
            } else {
              return Center(
                  child: LoadingAnimationWidget.fallingDot(
                color: Colors.white,
                size: 50.sp,
              ));
            }
          },
        ),
      ),
    );
  }
}
