import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Presentation/common/views/bottom_bar.dart';
import 'package:school_system/Presentation/common/views/dashboard_screen/dashboard_screen.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_row_widget.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/custom_widget/custome_botton_details_screen.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';
import 'package:school_system/Presentation/utils/custom_widget/navigator_pop.dart';
import 'package:school_system/Data/Repository/accept_reject_metting.dart';
import 'package:school_system/controllers/cubits/common_cubit/accept_reject_mettings_cubit.dart';
import 'package:school_system/controllers/cubits/common_cubit/get_all_meetings_cubit.dart';
import 'package:school_system/models/get_all_mettings.dart';

class MeetingsDetails extends StatefulWidget {
  MeetingsDetails({Key? key, this.meetings}) : super(key: key);

  GetAllMeetings? meetings;

  @override
  State<MeetingsDetails> createState() => _MeetingsDetailsState();
}

class _MeetingsDetailsState extends State<MeetingsDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AcceptRejectMeetingsCubit, AcceptRejectMeetingsState>(
        listener: (context, state) {
          if (state is AcceptRejectMeetingsLoading) {
            const Center(
                child: CircularProgressIndicator(
              color: Colors.blue,
            ));
            print('accepted');
          } else if (state is AcceptRejectMeetingsLoaded) {
            context.read<GetAllMeetingsCubit>().getAllMettings();
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const BottomBarPages();
              },
            ));
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: Padding(
              padding: EdgeInsets.all(10.0.sp),
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () async {
                      await context
                          .read<AcceptRejectMeetingsCubit>()
                          .acceptRejectMeetings(
                              widget.meetings!.id.toString(), 'rejected');
                    },
                    child: CustomWidgets.customButton('Reject',
                        buttonColor: kDescriptionColor),
                  )),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      context
                          .read<AcceptRejectMeetingsCubit>()
                          .acceptRejectMeetings(
                              widget.meetings!.id.toString(), 'accepted');
                    },
                    child: CustomWidgets.customButton(
                      'Accept',
                    ),
                  )),
                ],
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  NavigatorPop(),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomRowWidget(
                    text1: 'Meeting Requests',
                    text2: 'You can respond your all meeting requests here.',
                    image: 'calender.gif',
                    flex: 3,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  MyText(
                    widget.meetings?.title ?? "",
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  MyText(
                    "${widget.meetings?.meetingTime}  ${widget.meetings?.meetingDate.toString()}",
                    fontWeight: FontWeight.w400,
                    fontSize: 17.sp,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.deepPurple,
                        size: 15.sp,
                      ),
                      Expanded(
                        child: Text(
                          ' ${widget.meetings?.meetingTime ?? ""}',
                          style: GoogleFonts.poppins(
                            color: kDescriptionColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.deepPurple,
                        size: 16.sp,
                      ),
                      Expanded(
                        child: Text(
                          ' ${widget.meetings?.meetingTime ?? ""}',
                          style: GoogleFonts.poppins(
                            color: kDescriptionColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  MyText(
                    "${widget.meetings?.description}",
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                    color: kDescriptionColor,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  MyText(
                    "Meeting Organizer",
                    fontWeight: FontWeight.w400,
                    fontSize: 17.sp,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 15.sp,
                        backgroundImage:
                            NetworkImage(widget.meetings?.teacher?.image ?? ""),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      MyText(
                        "${widget.meetings?.teacher?.firstName ?? ''}  ${widget.meetings?.teacher?.lastName}",
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,
                      ),
                      Spacer(),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
