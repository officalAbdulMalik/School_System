import 'dart:convert';

class AllMeetings {
  final int? id;
  final String? title;
  final String? status;
  final int? userId;
  final String? meetingCreatedUserType;
  final int? teacherId;
  final int? parentId;
  final DateTime? meetingDate;
  final String? meetingTime;
  final String? meetingEndTime;
  final String? description;
  final dynamic studentId;
  final String? meetingHash;
  final List<dynamic>? parents;
  final Teacher? teacher;
  final dynamic principal;

  AllMeetings({
    this.id,
    this.title,
    this.status,
    this.userId,
    this.meetingCreatedUserType,
    this.teacherId,
    this.parentId,
    this.meetingDate,
    this.meetingTime,
    this.meetingEndTime,
    this.description,
    this.studentId,
    this.meetingHash,
    this.parents,
    this.teacher,
    this.principal,
  });

  factory AllMeetings.fromJson(String str) =>
      AllMeetings.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllMeetings.fromMap(Map<String, dynamic> json) => AllMeetings(
        id: json["id"],
        title: json["title"],
        status: json["status"],
        userId: json["user_id"],
        meetingCreatedUserType: json["meeting_created_user_type"],
        teacherId: json["teacher_id"],
        parentId: json["parent_id"],
        meetingDate: json["meeting_date"] == null
            ? null
            : DateTime.parse(json["meeting_date"]),
        meetingTime: json["meeting_time"],
        meetingEndTime: json["meeting_end_time"],
        description: json["description"],
        studentId: json["student_id"],
        meetingHash: json["meeting_hash"],
        parents: json["_parents"] == null
            ? []
            : List<dynamic>.from(json["_parents"]!.map((x) => x)),
        teacher:
            json["teacher"] == null ? null : Teacher.fromMap(json["teacher"]),
        principal: json["principal"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "status": status,
        "user_id": userId,
        "meeting_created_user_type": meetingCreatedUserType,
        "teacher_id": teacherId,
        "parent_id": parentId,
        "meeting_date":
            "${meetingDate!.year.toString().padLeft(4, '0')}-${meetingDate!.month.toString().padLeft(2, '0')}-${meetingDate!.day.toString().padLeft(2, '0')}",
        "meeting_time": meetingTime,
        "meeting_end_time": meetingEndTime,
        "description": description,
        "student_id": studentId,
        "meeting_hash": meetingHash,
        "_parents":
            parents == null ? [] : List<dynamic>.from(parents!.map((x) => x)),
        "teacher": teacher?.toMap(),
        "principal": principal,
      };
}

class Teacher {
  final int? id;
  final String? title;
  final String? firstName;
  final String? lastName;
  final dynamic gender;
  final dynamic image;
  final dynamic mobile;

  Teacher({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.gender,
    this.image,
    this.mobile,
  });

  factory Teacher.fromJson(String str) => Teacher.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Teacher.fromMap(Map<String, dynamic> json) => Teacher(
        id: json["id"],
        title: json["title"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        image: json["image"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "image": image,
        "mobile": mobile,
      };
}
