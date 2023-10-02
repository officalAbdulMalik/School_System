import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/models/get_all_mettings.dart';

import '../../Data/Repository/add_mettings_api.dart';
import '../../models/teacher_parents_data_model.dart';

class MettingRequestScreen extends StatefulWidget {
  MettingRequestScreen(
      {Key? key,
      required this.dateTime,
      required this.data,
      required this.index})
      : super(key: key);

  String dateTime;
  List<ParentsTeacherData> data;
  int index;

  @override
  State<MettingRequestScreen> createState() => _MettingRequestScreenState();
}

class _MettingRequestScreenState extends State<MettingRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: kButtonColor,
        title: Text(
          'Send Video Request',
          style: GoogleFonts.acme(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Send a request to video chat',
                style: GoogleFonts.acme(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Send a video chat request to chat\nwith your teacher',
                textAlign: TextAlign.center,
                style: GoogleFonts.acme(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 300,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 65,
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: widget
                                    .data[widget.index].image!.isEmpty
                                ? AssetImage('images/prof.png')
                                : NetworkImage(widget.data[widget.index].image!)
                                    as ImageProvider,
                          ),
                          title: Text(
                            widget.data[widget.index].firstName!,
                            style: GoogleFonts.acme(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          subtitle: Text(
                            widget.data[widget.index].email!,
                            style: GoogleFonts.acme(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          trailing: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  'Date Time',
                                  style: GoogleFonts.acme(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  widget.dateTime,
                                  style: GoogleFonts.acme(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Include Message (optional)',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.acme(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 100,
                        width: 400,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 10,
                          ),
                          child: TextFormField(
                            maxLength: 1000,
                            maxLines: 5,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 10, bottom: 10),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Spacer(),
                          Expanded(
                            child: Container(
                              height: 40,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  'Close',
                                  style: GoogleFonts.acme(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                // AddMeetings.sendMeetingRequest("", widget.data[widget.index].id, widget.data[widget.index].id, widget.dateTime, widget., desc)
                              },
                              child: Container(
                                height: 40,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    'Send Request',
                                    style: GoogleFonts.acme(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
