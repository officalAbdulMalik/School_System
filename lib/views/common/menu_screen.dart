import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/views/bottom_bar_parent/profile_screens/preferences_screen.dart';
import 'package:school_system/views/bottom_bar_parent/profile_screens/subscription_screen.dart';
import 'package:school_system/views/common/terms_condation.dart';
import 'package:school_system/views/utils/shade_prefrence.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controllers/cubits/common_cubit/get_user_data_cubit.dart';
import '../bottom_bar_parent/profile_screens/edit_profile_screen.dart';
import '../bottom_bar_parent/profile_screens/show_teacher.dart';
import '../bottom_bar_techer/prifile_screen/show_class.dart';
import '../utils/colors.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    context.read<GetUserDataCubit>().getParentsTeachers('');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: BlocBuilder<GetUserDataCubit, GetUserDataState>(
        builder: (context, state) {
          if (state is GetUserDataLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen(
                                    data: state.model.user,
                                  )));
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(20)),
                        gradient: LinearGradient(
                            colors: [
                              Color(0xFFC7CEF1),
                              Color(0xFF8C9BE3),
                            ],
                            end: FractionalOffset(0.0, 0.0),
                            begin: FractionalOffset(1.0, 0.0),
                            stops: [0.1, 1.0],
                            tileMode: TileMode.decal),
                      ),
                      child: ListTile(
                        leading: Container(
                            height: 60,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: const Color(0xffdbeffe),
                                borderRadius: BorderRadius.circular(50)),
                            child: state.model.user!.image!.isEmpty
                                ? Image.asset("images/users.png")
                                : Image.network(state.model.user!.image!)),
                        title: Text(
                          "${state.model.user!.firstName} ${state.model.user!.lastName}",
                          style: GoogleFonts.acme(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          "Edit my Profile",
                          style: GoogleFonts.acme(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        trailing: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.sync)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LoginApiShadePreference.preferences!.get('role') ==
                                'parents'
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SchoolTeacher(
                                                schoolId: state.model.user!.id
                                                    .toString(),
                                              )));
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFC7CEF1),
                                          Color(0xFF8C9BE3),
                                        ],
                                        end: FractionalOffset(0.0, 0.0),
                                        begin: FractionalOffset(1.0, 0.0),
                                        stops: [0.1, 1.0],
                                        tileMode: TileMode.decal),
                                  ),
                                  child: ListTile(
                                    leading: Container(
                                        height: 40,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: const Color(0xffdbeffe),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Image.asset("images/users.png")),
                                    title: Text(
                                      "My Children",
                                      style: GoogleFonts.acme(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                            Icons.keyboard_arrow_right)),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TeacherClass()));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFC7CEF1),
                                    Color(0xFF8C9BE3),
                                  ],
                                  end: FractionalOffset(0.0, 0.0),
                                  begin: FractionalOffset(1.0, 0.0),
                                  stops: [0.1, 1.0],
                                  tileMode: TileMode.decal),
                            ),
                            child: ListTile(
                              leading: Container(
                                  height: 40,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffdbeffe),
                                      borderRadius: BorderRadius.circular(50)),
                                  child:
                                      Image.asset("images/subscription.png")),
                              title: Text(
                                "My Classes",
                                style: GoogleFonts.acme(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.keyboard_arrow_right)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SubscriptionScreen()));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFC7CEF1),
                                    Color(0xFF8C9BE3),
                                  ],
                                  end: FractionalOffset(0.0, 0.0),
                                  begin: FractionalOffset(1.0, 0.0),
                                  stops: [0.1, 1.0],
                                  tileMode: TileMode.decal),
                            ),
                            child: ListTile(
                              leading: Container(
                                  height: 40,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffdbeffe),
                                      borderRadius: BorderRadius.circular(50)),
                                  child:
                                      Image.asset("images/subscription.png")),
                              title: Text(
                                "My Subscription",
                                style: GoogleFonts.acme(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.keyboard_arrow_right)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PreferencesScreen()));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFC7CEF1),
                                    Color(0xFF8C9BE3),
                                  ],
                                  end: FractionalOffset(0.0, 0.0),
                                  begin: FractionalOffset(1.0, 0.0),
                                  stops: [0.1, 1.0],
                                  tileMode: TileMode.decal),
                            ),
                            child: ListTile(
                              leading: Container(
                                  height: 40,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffdbeffe),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Image.asset("images/preferences.png")),
                              title: Text(
                                "Preferences",
                                style: GoogleFonts.acme(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.keyboard_arrow_right)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFC7CEF1),
                                  Color(0xFF8C9BE3),
                                ],
                                end: FractionalOffset(0.0, 0.0),
                                begin: FractionalOffset(1.0, 0.0),
                                stops: [0.1, 1.0],
                                tileMode: TileMode.decal),
                          ),
                          child: ListTile(
                            leading: Container(
                                height: 40,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: const Color(0xffdbeffe),
                                    borderRadius: BorderRadius.circular(50)),
                                child: Image.asset("images/security.png")),
                            title: Text(
                              "Security",
                              style: GoogleFonts.acme(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            trailing: IconButton(
                                onPressed: () async {
                                  if (!await launchUrl(
                                    Uri.parse(
                                        'http://parentteachermobile.com/PrivacyPolicy'),
                                    mode: LaunchMode.externalApplication,
                                  )) {
                                    throw Exception(
                                        'Could not launch http://parentteachermobile.com/PrivacyPolicy');
                                  }
                                },
                                icon: const Icon(Icons.keyboard_arrow_right)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            height: 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: kButtonColor),
                            child: Image.asset("images/education.png")),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            leading: Container(
                                height: 40,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: const Color(0xffdbeffe),
                                    borderRadius: BorderRadius.circular(50)),
                                child: Image.asset("images/star.png")),
                            title: Text(
                              "Rate us on App Store",
                              style: GoogleFonts.acme(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.keyboard_arrow_right)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            leading: Container(
                                height: 40,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: const Color(0xffdbeffe),
                                    borderRadius: BorderRadius.circular(50)),
                                child: Image.asset("images/help.png")),
                            title: Text(
                              "Help and assistance",
                              style: GoogleFonts.acme(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.keyboard_arrow_right)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            leading: Container(
                                height: 40,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: const Color(0xffdbeffe),
                                    borderRadius: BorderRadius.circular(50)),
                                child: Image.asset("images/about.png")),
                            title: Text(
                              "About",
                              style: GoogleFonts.acme(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.keyboard_arrow_right)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog1(context, 'Are Your Sure to Sign Out');
                          },
                          child: Container(
                            height: 50,
                            width: 340,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF2A3B5D),
                                    Color(0xFF3D529B),
                                  ],
                                  end: FractionalOffset(0.0, 0.0),
                                  begin: FractionalOffset(1.0, 0.0),
                                  stops: [0.1, 1.0],
                                  tileMode: TileMode.decal),
                            ),
                            child: Center(
                                child: Text(
                              'Sign Out',
                              style: GoogleFonts.acme(
                                  color: Colors.white, fontSize: 20),
                            )),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog1(
                                context, 'Are You Sure to Delete Account');
                          },
                          child: Container(
                            height: 50,
                            width: 340,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF2A3B5D),
                                    Color(0xFF3D529B),
                                  ],
                                  end: FractionalOffset(0.0, 0.0),
                                  begin: FractionalOffset(1.0, 0.0),
                                  stops: [0.1, 1.0],
                                  tileMode: TileMode.decal),
                            ),
                            child: Center(
                                child: Text(
                              'Delete my account',
                              style: GoogleFonts.acme(
                                  color: Colors.white, fontSize: 20),
                            )),
                          ),
                        ),
                        const SizedBox(
                          height: 90,
                        ),
                      ],
                    ),
                  ),
                ],
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
    );
  }

  showDialog1(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Container(
            height: 150.h,
            width: 50.w,
            decoration: BoxDecoration(
              color: kButtonColor,
              borderRadius: BorderRadius.circular(20.sp),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  text,
                  style: GoogleFonts.acme(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.sp, right: 10.sp),
                  child: Row(
                    children: [
                      Container(
                        height: 30.h,
                        width: 75.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.sp)),
                        child: Center(
                          child: Text(
                            'Yas',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 80.w,
                      ),
                      Container(
                        height: 30.h,
                        width: 75.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.sp)),
                        child: Center(
                          child: Text(
                            'No',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
