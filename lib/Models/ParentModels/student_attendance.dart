import 'dart:convert';

class ParentStudentAttendance {
  final int? id;
  final int? classSectionId;
  final int? studentId;
  final int? sessionYearId;
  final int? type;
  final DateTime? date;

  ParentStudentAttendance({
    this.id,
    this.classSectionId,
    this.studentId,
    this.sessionYearId,
    this.type,
    this.date,
  });

  factory ParentStudentAttendance.fromJson(String str) =>
      ParentStudentAttendance.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ParentStudentAttendance.fromMap(Map<String, dynamic> json) =>
      ParentStudentAttendance(
        id: json["id"],
        classSectionId: json["class_section_id"],
        studentId: json["student_id"],
        sessionYearId: json["session_year_id"],
        type: json["type"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "class_section_id": classSectionId,
        "student_id": studentId,
        "session_year_id": sessionYearId,
        "type": type,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
      };
}
