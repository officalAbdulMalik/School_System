import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/controllers/cubits/common_cubit/get_parents_teachers_cubit.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../utils/custom_widget/custom_widgets.dart';
import 'metting_request_screen.dart';

class ClassScreen extends StatefulWidget {
  ClassScreen({Key? key}) : super(key: key);

  @override
  State<ClassScreen> createState() => _ClassScreenState();

  List teachers = [
    'john',
    'preva',
    'marcio',
    'zashni',
    'tebro',
  ];

  List teacherProfsion = [
    'Hod',
    'Constructor',
    'Math teacher',
    'English Teacher',
    'IT Teacher',
  ];
}

class _ClassScreenState extends State<ClassScreen> {
  @override
  void initState() {
    // TODO: implement initState  context
    context
        .read<GetParentsTeachersCubit>()
        .getParentsTeachers('/api/get/teachers');
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
                  'Search Teachers',
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
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 12),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (val) {
                    context
                        .read<GetParentsTeachersCubit>()
                        .searchParentsTeachers('teacher', val);
                  },
                  cursorColor: kPrimaryColor,
                  // decoration: textFieldIconDecoration(
                  //     Icons.alternate_email, 'service@gmail.com', null),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              BlocBuilder<GetParentsTeachersCubit, GetAllParentsState>(
                builder: (context, state) {
                  if (state is GetAllParentsLoaded) {
                    return SizedBox(
                      height: 500,
                      width: 600,
                      child: state.model.data!.isNotEmpty
                          ? ListView.separated(
                              itemCount: state.model.data!.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Container(
                                    height: 80,
                                    width: 400,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 35,
                                        backgroundImage: state.model
                                                .data![index].image!.isEmpty
                                            ? AssetImage('images/prof.png')
                                            : NetworkImage(state
                                                .model
                                                .data![index]
                                                .image!) as ImageProvider,
                                      ),
                                      title: Text(
                                        "${state.model.data![index].firstName!} ${state.model.data![index].lastName!}",
                                        style: GoogleFonts.acme(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      subtitle: Text(
                                        state.model.data![index].email!,
                                        style: GoogleFonts.acme(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      trailing: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: kButtonColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: InkWell(
                                          onTap: () async {
                                            final data =
                                                await _selectDate(context);
                                            if (data.isNotEmpty) {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return MettingRequestScreen(
                                                    dateTime: data,
                                                    data: state.model.data!,
                                                    index: index,
                                                  );
                                                },
                                              ));
                                            }
                                          },
                                          child: Icon(
                                            Icons.video_call,
                                            color: Colors.white,
                                          ),
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
                                'No Data Found',
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
      ),
    );
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
