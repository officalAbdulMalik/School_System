import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Presentation/common/views/dashboard_screen/meeting_details.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/models/get_all_mettings.dart';
import 'package:school_system/Presentation/common/resources/Extension/extension.dart';

import '../../../../utils/app_images.dart';
import '../../../../utils/custom_widget/my_text.dart';

class EventCard extends StatelessWidget {
  final Color cardColor;

  GetAllMeetings? data;

  EventCard({Key? key, required this.cardColor, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(data);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.sp),
      height: 94.sp,
      decoration: ShapeDecoration(
        color: const Color(0xFFF3F4F6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: ShapeDecoration(
                color: cardColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 20.sp),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: SvgPicture.asset(AppImages.timeIcon))),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: MyText(
                            data?.meetingTime ?? "",
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                            letterSpacing: 0.75,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Flexible(
                          child: MyText(
                            data?.meetingDate?.humanReadableDate ?? "",
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.75,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 16.sp),
              child: Column(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: MyText(
                        data?.title ?? "",
                        color: Color(0xFF6B7280),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.75,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: MyText(
                            data?.description ?? "",
                            fontSize: 16.sp,
                          ))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// details meeting screen card
class MeetingCard extends StatefulWidget {
  MeetingCard({Key? key, this.meetings, this.index}) : super(key: key);

  List<GetAllMeetings>? meetings;
  int? index;

  @override
  State<MeetingCard> createState() => _MeetingCardState();
}

class _MeetingCardState extends State<MeetingCard> {
  @override
  Widget build(BuildContext context) {
    print(widget.meetings!.length);

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return MeetingsDetails(
              meetings: widget.meetings![widget.index!],
            );
          },
        ));
      },
      child: widget.meetings!.isNotEmpty
          ? Container(
              margin: EdgeInsets.symmetric(vertical: 7.sp),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: ShapeDecoration(
                color: widget.meetings?[widget.index!].status == 'accepted'
                    ? kCardBColor
                    : kCardGColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 10,
                        child: Text(
                          'Class A',
                          style: GoogleFonts.poppins(
                            color: Color(0xFF000600),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
                      Flexible(
                          child: SizedBox(
                              height: 13.h,
                              width: 13.w,
                              child: Image.asset(
                                'images/std.png',
                              ))),
                      SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '15',
                          style: GoogleFonts.poppins(
                            color: kDescriptionColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.meetings?[widget.index!].title ?? "",
                    style: GoogleFonts.poppins(
                      color: kDescriptionColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.75,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.deepPurple,
                        size: 13.sp,
                      ),
                      Expanded(
                        child: Text(
                          ' ${widget.meetings?[widget.index!].meetingTime ?? ""} - 11:00',
                          style: GoogleFonts.poppins(
                            color: kDescriptionColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.all(5.sp),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF3D51A),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.meetings?[widget.index!].status ??
                                    "Pending",
                                style: GoogleFonts.poppins(
                                  color: kDescriptionColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 1.sh / 3.5,
                ),
                Align(
                  alignment: Alignment.center,
                  child: MyText(
                    'No have meetings',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
    );
  }
}
