import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/get_all_school_cubit.dart';
import 'package:school_system/Data/app_const.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/common/views/Components/school_tiles.dart';
import 'package:school_system/Presentation/common/views/shool_addInInfo.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text_field.dart';
import 'package:school_system/models/get_all_school_model.dart';

import '../../utils/custom_widget/custom_row_widget.dart';
import '../../utils/custom_widget/navigator_pop.dart';
import 'add_school_screen.dart';

class SchoolListScreen extends StatefulWidget {
 const SchoolListScreen({Key? key}) : super(key: key);

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
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
          child: SizedBox(
            height: 1.sh,
            width: 1.sw,
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
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
                        image: 'images/star_s.webp',
                        height: 80.h,
                        width: 80.w,
                      ),
                      SizedBox(height: 15.h,),
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
                        height: 5.h,
                      ),
                      BlocConsumer<GetAllSchoolCubit, GetAllSchoolState>(
                        listener: (context, state) {
                          if (state is GetAllSchoolLoading) {
                            Dialogs.loadingDialog(context);
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
                            return searchList!.isNotEmpty
                                ? Column(
                                  children: [
                                    SizedBox(
                                      height: 0.63.sh,
                                      width: 1.sw,
                                      child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                                          separatorBuilder: (context, index) {
                                            return SizedBox(
                                              height: 10.h,
                                            );
                                          },
                                          itemCount: searchList!.length,
                                          itemBuilder: (context, index) {
                                            return SchoolTiles(
                                              searchList: searchList,
                                              index: index,
                                            );
                                          },
                                        ),
                                    ),
                                    SizedBox(height: 20.h,),
                                  ],
                                )
                                : CustomWidgets.errorText(noDataString);
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10.sp,
                  child: CustomWidgets.customButton('Add New School', onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const AddSchoolScreen();
                    },));
                  }),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
