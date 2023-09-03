import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/controllers/cubits/common_cubit/get_all_meetings_cubit.dart';
import 'package:school_system/views/utils/colors.dart';

import '../../controllers/apis_repo/accept_reject_metting.dart';
import '../utils/custom_widget/custom_widgets.dart';

class MettingsScreen extends StatefulWidget {
  MettingsScreen({Key? key}) : super(key: key);

  @override
  State<MettingsScreen> createState() => _MettingsScreenState();
}

class _MettingsScreenState extends State<MettingsScreen> {
  @override
  void initState() {
    context.read<GetAllMeetingsCubit>().getAllMettings();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Search Meetings',
                    style: GoogleFonts.acme(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 55,
                  width: 340,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    onChanged: (value) {
                      context.read<GetAllMeetingsCubit>().search(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.black, fontSize: 12),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                    ),

                    cursorColor: kPrimaryColor,
                    // decoration: textFieldIconDecoration(
                    //     Icons.alternate_email, 'service@gmail.com', null),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                BlocBuilder<GetAllMeetingsCubit, GetAllMeetingsState>(
                  builder: (context, state) {
                    if (state is GetAllMeetingsLoaded) {
                      return SizedBox(
                        height: 500,
                        width: 600,
                        child: state.mettings.data!.isNotEmpty
                            ? ListView.separated(
                                itemCount: state.mettings.data!.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Container(
                                      height: 120,
                                      width: 400,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ListTile(
                                        title: Text(
                                            state.mettings.data![index].title!),
                                        subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(state.mettings.data![index]
                                                  .description!),
                                              SizedBox(height: 4.0),
                                              Text(
                                                'Time: ${state.mettings.data![index].meetingTime!}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'Date: ${state.mettings.data![index].meetingDate}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ]),
                                        trailing: SizedBox(
                                          height: 70.h,
                                          width: 120.w,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 40.h,
                                                  width: 40.w,
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () async {
                                                        AcceptRejectMetting
                                                                .acceptReject(
                                                                    state
                                                                        .mettings
                                                                        .data![
                                                                            index]
                                                                        .id
                                                                        .toString(),
                                                                    'accepted',
                                                                    context)
                                                            .then((value) {
                                                          context
                                                              .read<
                                                                  GetAllMeetingsCubit>()
                                                              .getAllMettings();
                                                        });
                                                      },
                                                      child: Center(
                                                        child: Text(
                                                          'Accept',
                                                          style:
                                                              GoogleFonts.acme(
                                                            color: Colors.white,
                                                            fontSize: 12.sp,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 40.h,
                                                  width: 40.w,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () async {
                                                        AcceptRejectMetting
                                                                .acceptReject(
                                                                    state
                                                                        .mettings
                                                                        .data![
                                                                            index]
                                                                        .id
                                                                        .toString(),
                                                                    'rejected',
                                                                    context)
                                                            .then((value) {
                                                          context
                                                              .read<
                                                                  GetAllMeetingsCubit>()
                                                              .getAllMettings();
                                                        });
                                                      },
                                                      child: Center(
                                                        child: Text(
                                                          'Decline',
                                                          style:
                                                              GoogleFonts.acme(
                                                            color: Colors.white,
                                                            fontSize: 12.sp,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 10,
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                  'No Meetings Here',
                                  style: GoogleFonts.acme(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                      );
                    } else {
                      return CustomWidgets.loadingIndicator();
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }

  Future<String> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        confirmText: 'Save',
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      return '${picked.month}/${picked.day}/${picked.year}';
    } else {
      return '';
    }
  }
}
