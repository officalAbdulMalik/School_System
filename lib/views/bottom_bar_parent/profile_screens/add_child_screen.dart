import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';

class AddChildScreen extends StatefulWidget {
  const AddChildScreen({super.key});

  @override
  State<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  String gender = "Gender*", relation = "You are his / her";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: kButtonColor,
        title: Text(
          'Add a child',
          style: GoogleFonts.acme(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const CircleAvatar(
                radius: 40,
                child: CircleAvatar(
                  backgroundColor: kButtonColor,
                  backgroundImage: AssetImage('images/prof.png'),
                  radius: 39,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                height: 50,
                width: 340,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                      colors: [
                        Color(0xFFC7CEF1),
                        Color(0xFF8C9BE3),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.1, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'First Name',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 12),
                    border: InputBorder.none,
                  ),
                  cursorColor: kPrimaryColor,
                  // decoration: textFieldIconDecoration(
                  //     Icons.alternate_email, 'service@gmail.com', null),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                height: 50,
                width: 340,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                      colors: [
                        Color(0xFFC7CEF1),
                        Color(0xFF8C9BE3),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.1, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Last Name',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 12),
                    border: InputBorder.none,
                  ),
                  cursorColor: kPrimaryColor,
                  // decoration: textFieldIconDecoration(
                  //     Icons.alternate_email, 'service@gmail.com', null),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                height: 50,
                width: 340,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                      colors: [
                        Color(0xFFC7CEF1),
                        Color(0xFF8C9BE3),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.1, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Date of Birth',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 12),
                    border: InputBorder.none,
                  ),
                  cursorColor: kPrimaryColor,
                  // decoration: textFieldIconDecoration(
                  //     Icons.alternate_email, 'service@gmail.com', null),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                height: 50,
                width: 340,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                      colors: [
                        Color(0xFFC7CEF1),
                        Color(0xFF8C9BE3),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.1, 1.0],
                      tileMode: TileMode.decal),
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          gender,
                          style: GoogleFonts.acme(
                              color: Colors.black, fontSize: 11),
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: DropdownButton<String>(
                          underline: const SizedBox(),
                          items: <String>[
                            'Male',
                            'Female',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (value) {
                            gender = value!;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                height: 50,
                width: 340,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                      colors: [
                        Color(0xFFC7CEF1),
                        Color(0xFF8C9BE3),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.1, 1.0],
                      tileMode: TileMode.decal),
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          relation,
                          style: GoogleFonts.acme(
                              color: Colors.black, fontSize: 11),
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: DropdownButton<String>(
                          underline: const SizedBox(),
                          items: <String>[
                            'Mother',
                            'Father',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            relation = value!;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                textAlign: TextAlign.justify,
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                style: GoogleFonts.acme(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
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
                    'Add',
                    style: GoogleFonts.acme(color: Colors.white, fontSize: 20),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
