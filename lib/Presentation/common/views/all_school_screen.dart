import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/get_all_school_cubit.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/common/views/shool_addInInfo.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text_field.dart';
import 'package:school_system/models/get_all_school_model.dart';

import '../../utils/custom_widget/custom_row_widget.dart';
import '../../utils/custom_widget/navigator_pop.dart';
import 'add_school_screen.dart';

class SchoolListScreen extends StatefulWidget {
  SchoolListScreen({Key? key}) : super(key: key);

  @override
  State<SchoolListScreen> createState() => _SchoolListScreenState();
}

class _SchoolListScreenState extends State<SchoolListScreen> {
  final ValueNotifier<bool> showPassword = ValueNotifier(false);

  TextEditingController searchController = TextEditingController();

  List<Schools>? searchList = [];
  List<Schools>? dataList = [];

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
        bottomNavigationBar: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const AddSchoolScreen();
              },
            ));
          },
          child: Container(
            margin: EdgeInsets.only(
                left: 10.sp, right: 10.sp, top: 10.sp, bottom: 10.sp),
            height: 50.sp,
            width: 140.sp,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(15.sp),
            ),
            child: Center(
                child: Text(
              'if want to add another School ! Click here',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 15.h,
                fontWeight: FontWeight.w400,
              ),
            )),
          ),
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const NavigatorPop(),
                SizedBox(height: 5.h),
                CustomRowWidget(
                  text1: 'Find Your School',
                  text2: 'Select Your school from here...',
                  image: 'add_s_star.png',
                ),
                MyTextField(
                  controller: searchController,
                  filledColor: kContainerColor,
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  onCanaged: (val) {
                    if (val.isNotEmpty) {
                      searchList = searchList!
                          .where((player) => player.schoolName!
                              .toLowerCase()
                              .contains(val.toLowerCase()))
                          .toList();
                    } else {
                      searchList = dataList;
                    }
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                BlocConsumer<GetAllSchoolCubit, GetAllSchoolState>(
                  listener: (context, state) {
                    if (state is GetAllSchoolLoading) {
                      LoadingDialog.showLoadingDialog(context);
                    }
                    if (state is GetAllSchoolLoaded) {
                      searchList = state.model;
                      dataList = state.model;
                      Navigator.pop(context);
                    }
                    if (state is GetAllSchoolError) {
                      Fluttertoast.showToast(msg: state.error!);
                    }
                  },
                  builder: (context, state) {
                    if (state is GetAllSchoolLoaded) {
                      return SizedBox(
                        height: 500.h,
                        width: 500.w,
                        child: searchList!.isNotEmpty
                            ? ListView.separated(
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 10.h,
                                  );
                                },
                                itemCount: searchList!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius:
                                          BorderRadius.circular(15.sp),
                                    ),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            searchList![index].image ?? ''),
                                      ),
                                      title: Text(
                                        searchList![index].schoolName!,
                                        style: CustomWidgets.textStyle(
                                            color: Colors.black,
                                            size: 16,
                                            weight: FontWeight.w600),
                                      ),
                                      subtitle: Text(
                                        searchList![index].address!,
                                        style: CustomWidgets.textStyle(
                                            color: kDescriptionColor,
                                            size: 15,
                                            weight: FontWeight.w500),
                                      ),
                                      trailing: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return SchoolAddInInfo(
                                                  data: searchList!,
                                                  index: index,
                                                );
                                              },
                                            ));
                                          },
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              size: 25.sp,
                                              color: kDescriptionColor,
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
                                      color: kPrimaryColor, fontSize: 20.sp),
                                ),
                              ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
