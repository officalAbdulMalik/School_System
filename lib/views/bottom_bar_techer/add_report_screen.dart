import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/views/utils/colors.dart';

class ClassListScreen extends StatelessWidget {
  final List classes = [
    "Class A",
    "Class B",
    'Class C',
    // Add more classes here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: ListView.builder(
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final classInfo = classes[index];
          return ListTile(
            title: Text(
              classInfo,
              style: GoogleFonts.acme(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentListScreen(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Student {
  final String name;
  final String rollNumber;
  final int age;
  final String avatar; // Provide the path to student avatars

  Student(
      {required this.name,
      required this.rollNumber,
      required this.age,
      required this.avatar});
}

class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  final List<Student> students = [
    Student(
        name: 'John Doe',
        rollNumber: '123',
        age: 18,
        avatar: 'images/chat.png'),
    Student(
        name: 'Jane Smith',
        rollNumber: '222',
        age: 13,
        avatar: 'images/chat.png'),
    Student(
        name: 'John Doe',
        rollNumber: '13223',
        age: 12,
        avatar: 'images/chat.png'),
    Student(
        name: 'Jane Smith',
        rollNumber: '24',
        age: 14,
        avatar: 'images/chat.png'),
    Student(
        name: 'John Doe',
        rollNumber: '1232',
        age: 12,
        avatar: 'images/chat.png'),
    Student(
        name: 'Jane Smith',
        rollNumber: '1224',
        age: 12,
        avatar: 'images/chat.png'),
    // Add more students here
  ];

  List<Student> selectedStudents = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: kButtonColor,
        title: Text(
          'Student List',
          style: GoogleFonts.acme(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          final isSelected = selectedStudents.contains(student);
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(student.avatar),
            ),
            title: Text(
              student.name,
              style: GoogleFonts.acme(
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              'Roll Number: ${student.rollNumber}',
              style: GoogleFonts.acme(
                color: Colors.white,
              ),
            ),
            trailing: Checkbox(
              value: isSelected,
              onChanged: (bool? value) {
                _toggleStudentSelection(student);
              },
            ),
            onTap: () {
              _toggleStudentSelection(student);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => StudentDetailsScreen(student: student),
              //   ),
              // );
            },
          );
        },
      ),
      floatingActionButton: selectedStudents.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return GradeEntryScreen(
                      selectedStudents: selectedStudents,
                    );
                  },
                ));
              },
              child: Icon(Icons.check),
            )
          : SizedBox(),
    );
  }

  void _toggleStudentSelection(Student student) {
    setState(() {
      if (selectedStudents.contains(student)) {
        selectedStudents.remove(student);
      } else {
        selectedStudents.add(student);
      }
    });
  }
}

class GradeEntryScreen extends StatefulWidget {
  final List<Student> selectedStudents;

  GradeEntryScreen({required this.selectedStudents});

  @override
  _GradeEntryScreenState createState() => _GradeEntryScreenState();
}

class _GradeEntryScreenState extends State<GradeEntryScreen> {
  Map<Student, Map<String, int>> grades = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: kButtonColor,
        title: Text(
          'Enter Grades',
          style: GoogleFonts.acme(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(left: 10.sp, right: 20.sp),
        separatorBuilder: (context, index) {
          return Divider(
            color: kButtonColor,
            thickness: 2,
          );
        },
        itemCount: widget.selectedStudents.length,
        itemBuilder: (context, index) {
          final student = widget.selectedStudents[index];
          return ListTile(
            title: Text(
              "${index + 1}: ${student.name}",
              style: GoogleFonts.acme(
                fontSize: 18.sp,
                color: kButtonColor,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text('Grades:',
                    style: GoogleFonts.acme(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                Container(
                    height: 60,
                    width: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    child: GradeInputRow(student: student)),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(
          //   builder: (context) {
          //     return ReportDisplayScreen(
          //       grades: grades,
          //     );
          //   },
          // ));
        },
        child: Icon(Icons.save),
      ),
    );
  }
}

///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

class GradeInputRow extends StatefulWidget {
  final Student student;

  GradeInputRow({required this.student});

  @override
  _GradeInputRowState createState() => _GradeInputRowState();
}

class _GradeInputRowState extends State<GradeInputRow> {
  Map<String, TextEditingController> gradeControllers = {};

  @override
  void initState() {
    super.initState();
    for (String subject in subjects) {
      gradeControllers[subject] = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (String subject in subjects)
          Expanded(
            child: Container(
              width: 80,
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: TextField(
                controller: gradeControllers[subject],
                decoration: InputDecoration(
                  labelText: subject,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    for (var controller in gradeControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}

class SubjectMarksInputRow extends StatefulWidget {
  final Student student;

  SubjectMarksInputRow({required this.student});

  @override
  _SubjectMarksInputRowState createState() => _SubjectMarksInputRowState();
}

class _SubjectMarksInputRowState extends State<SubjectMarksInputRow> {
  Map<String, TextEditingController> marksControllers = {};

  @override
  void initState() {
    super.initState();
    for (String subject in subjects) {
      marksControllers[subject] = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (String subject in subjects)
          Container(
            width: 60,
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: TextField(
              controller: marksControllers[subject],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: subject,
                  hintStyle: GoogleFonts.acme(
                    color: Colors.white,
                  )),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    for (var controller in marksControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}

List<String> subjects = ['Math', 'Science', 'English', 'History', 'Biology'];
