// To parse this JSON data, do
//
//     final attendanceModel = attendanceModelFromMap(jsonString);

import 'dart:convert';

AttendanceModel attendanceModelFromMap(String str) =>
    AttendanceModel.fromMap(json.decode(str));

String attendanceModelToMap(AttendanceModel data) => json.encode(data.toMap());

class AttendanceModel {
  final int? absentCount;
  final int? presentCount;
  final List<Attendance>? attendance;

  AttendanceModel({
    this.absentCount,
    this.presentCount,
    this.attendance,
  });

  factory AttendanceModel.fromMap(Map<String, dynamic> json) => AttendanceModel(
        absentCount: json["absent_count"],
        presentCount: json["present_count"],
        attendance: json["attendance"] == null
            ? []
            : List<Attendance>.from(
                json["attendance"]!.map((x) => Attendance.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "absent_count": absentCount,
        "present_count": presentCount,
        "attendance": attendance == null
            ? []
            : List<dynamic>.from(attendance!.map((x) => x.toMap())),
      };
}

class Attendance {
  final int? id;
  final int? classSectionId;
  final int? studentId;
  final int? sessionYearId;
  final int? type;
  final DateTime? date;
  final dynamic student;

  Attendance({
    this.id,
    this.classSectionId,
    this.studentId,
    this.sessionYearId,
    this.type,
    this.date,
    this.student,
  });

  factory Attendance.fromMap(Map<String, dynamic> json) => Attendance(
        id: json["id"],
        classSectionId: json["class_section_id"],
        studentId: json["student_id"],
        sessionYearId: json["session_year_id"],
        type: json["type"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        student: json["student"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "class_section_id": classSectionId,
        "student_id": studentId,
        "session_year_id": sessionYearId,
        "type": type,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "student": student,
      };
}
