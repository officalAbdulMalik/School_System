import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/connect_school_with_us_cubit.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Data/Repository/forget_password_api.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'package:school_system/models/get_all_school_model.dart';

import '../../../Data/Repository/school_in_info.dart';
import '../../utils/custom_widget/custom_row_widget.dart';
import '../../utils/custom_widget/navigator_pop.dart';
import 'otp_screen.dart';

class SchoolAddInInfo extends StatefulWidget {
  SchoolAddInInfo({Key? key, required this.data, required this.index})
      : super(key: key);

  List<Schools> data = [];
  int index;

  @override
  State<SchoolAddInInfo> createState() => _SchoolAddInInfoState();
}

class _SchoolAddInInfoState extends State<SchoolAddInInfo> {
  final ValueNotifier<bool> loading = ValueNotifier(false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
            children: [
              SizedBox(
                height: 20.h,
              ),
              const NavigatorPop(),
              CustomRowWidget(
                text1: 'Confirm to add school ',
                text2: 'Please confirm your school to add...',
              ),
              SizedBox(
                height: 10.h,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 15.sp,
                  ),
                  SizedBox(
                    height: 60.h,
                    width: 55.w,
                    child: CircleAvatar(
                      radius: 60.sp,
                      backgroundImage:
                          NetworkImage(widget.data[widget.index].image!),
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  customShowWidget(
                      widget.data[widget.index].schoolName!, 'School Name'),
                  customShowWidget(
                      widget.data[widget.index].address!, 'Address'),
                  customShowWidget(
                      widget.data[widget.index].country!.name!, 'Country'),
                  customShowWidget(
                      widget.data[widget.index].countryId.toString()!,
                      'Country id'),
                ],
              ),
              SizedBox(
                height: 90.h,
              ),
              BlocConsumer<ConnectSchoolWithUsCubit, ConnectSchoolWithUsState>(
                  listener: (context, state) {
                if (state is ConnectSchoolLoading) {
                  Dialogs.showLoadingDialog(context);
                }
                if (state is ConnectSchoolWithUsError) {
                  Fluttertoast.showToast(msg: state.error!);
                }
                if (state is ConnectSchoolWithUsLoaded) {
                  String? email =
                      LoginApiShadePreference.preferences!.getString('email');

                  ForgetPasswordApi.sendEmail(email!);

                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return OtpScreen(
                        firstTime: false,
                        email: email,
                      );
                    },
                  ));
                }
              }, builder: (context, state) {
                return InkWell(
                  onTap: () {
                    context
                        .read<ConnectSchoolWithUsCubit>()
                        .assignSchool(widget.data[widget.index].id!);
                  },
                  child: Container(
                    height: 50.h,
                    width: 30.w,
                    margin: EdgeInsets.only(left: 20.sp, right: 20.sp),
                    child: CustomWidgets.customButton('Continue'),
                  ),
                );
              })
            ],
          )),
    );
  }

  customShowWidget(String text1, String text2) {
    return ListTile(
      leading: Text(
        text2,
        style: CustomWidgets.style(),
      ),
      trailing: Text(
        text1,
        style: CustomWidgets.style(),
      ),
    );
  }
}
