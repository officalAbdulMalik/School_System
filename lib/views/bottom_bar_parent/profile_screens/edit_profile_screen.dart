import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/user_data_model.dart';
import '../../utils/colors.dart';
import '../../utils/custom_widget/custom_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key, required this.data});

  User? data;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String language = 'Preferred Language';
  bool check = false;

  TextEditingController firsName = TextEditingController();
  TextEditingController secondName = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void initState() {
    firsName.text = widget.data!.firstName! ?? "";
    secondName.text = widget.data!.lastName! ?? "";
    email.text = widget.data!.email! ?? "";
    language = widget.data!.language ?? " ";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kButtonColor,
        title: Text(
          'Your Profile ',
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
              CircleAvatar(
                radius: 60,
                child: CircleAvatar(
                  foregroundImage: widget.data!.image!.isEmpty
                      ? AssetImage("images/users.png")
                      : NetworkImage(widget.data!.image!) as ImageProvider,
                  radius: 50,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                textAlign: TextAlign.center,
                "Please enter your fullname, email and \n optional profile picture",
                style: GoogleFonts.acme(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
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
                  controller: firsName,
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
                  controller: secondName,
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
                padding: EdgeInsets.only(left: 20),
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
                  controller: email,
                  decoration: const InputDecoration(
                    hintText: 'Email',
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
                          language,
                          style: GoogleFonts.acme(
                              color: Colors.black, fontSize: 11),
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          items: <String>[
                            'English',
                            'Scots',
                            'Welsh',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (value) {
                            language = value!;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Transform.scale(
                      alignment: Alignment.bottomCenter,
                      scale: 1.6,
                      child: Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        checkColor: Colors.white,
                        activeColor: Colors.blue,
                        tristate: false,
                        value: check,
                        onChanged: (value) {
                          check = value!;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 6,
                    child: RichText(
                      text: TextSpan(
                        text: 'I agree to receive emails, about ...',
                        style: GoogleFonts.acme(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CustomWidgets.customButton('Update Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
