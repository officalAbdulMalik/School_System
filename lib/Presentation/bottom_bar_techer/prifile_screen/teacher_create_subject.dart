import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Presentation/utils/colors.dart';

import '../../../controllers/image_picking.dart';
import '../../utils/custom_widget/container_decoration.dart';

class CreateSubjects extends StatefulWidget {
  CreateSubjects({Key? key, required this.classId}) : super(key: key);

  String classId;

  @override
  State<CreateSubjects> createState() => _CreateSubjectsState();
}

class _CreateSubjectsState extends State<CreateSubjects> {
  var image1;

  String language = '';

  var showimage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: ListView(
        children: [
          SizedBox(
            height: 30.h,
          ),
          InkWell(
            onTap: () async {
              final image = await ImagePick.pickImageFromGallery();
              if (image != null) {
                setState(() {
                  image1 = image.path;
                  showimage = image;
                });
              } else {
                Fluttertoast.showToast(msg: 'Image Is Empty');
              }
            },
            child: CircleAvatar(
              radius: 50,
              child: showimage == null
                  ? CircleAvatar(
                      foregroundImage: AssetImage('images/prof.png'),
                      radius: 50,
                    )
                  : CircleAvatar(
                      foregroundImage: FileImage(showimage!),
                      radius: 50,
                    ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 20.sp, right: 20.sp),
            padding: EdgeInsets.only(left: 10.sp),
            height: 50.h,
            width: 340.w,
            decoration: ContinerDecoration.continerDecoration(),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text(
                      language,
                      style: GoogleFonts.acme(
                          color: Colors.black, fontSize: 11.sp),
                    )),
                SizedBox(
                  width: 30.sp,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.0.sp),
                    child: DropdownButton<String>(
                      underline: SizedBox(),
                      items: <String>['English', 'Maths', 'PhySics']
                          .map((String value) {
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
        ],
      ),
    );
  }
}
