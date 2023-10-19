// To parse this JSON data, do
//
//     final getAllMeetings = getAllMeetingsFromJson(jsonString);

import 'dart:convert';

GetAllMeetings getAllMeetingsFromJson(String str) =>
    GetAllMeetings.fromJson(json.decode(str));

String getAllMeetingsToJson(GetAllMeetings data) => json.encode(data.toJson());

class GetAllMeetings {
  final int? id;
  final String? title;
  final int? userId;
  final int? teacherId;
  final int? parentId;
  final DateTime? meetingDate;
  final String? meetingTime;
  final String? description;
  final String? status;
  final String? subject;
  final dynamic location;
  final int? isOnline;
  final dynamic notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic studentId;
  final Parent? teacher;
  final Parent? parent;
  final dynamic student;

  GetAllMeetings({
    this.id,
    this.title,
    this.userId,
    this.teacherId,
    this.parentId,
    this.meetingDate,
    this.meetingTime,
    this.description,
    this.status,
    this.subject,
    this.location,
    this.isOnline,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.studentId,
    this.teacher,
    this.parent,
    this.student,
  });

  factory GetAllMeetings.fromJson(Map<String, dynamic> json) => GetAllMeetings(
        id: json["id"],
        title: json["title"],
        userId: json["user_id"],
        teacherId: json["teacher_id"],
        parentId: json["parent_id"],
        meetingDate: json["meeting_date"] == null
            ? null
            : DateTime.parse(json["meeting_date"]),
        meetingTime: json["meeting_time"],
        description: json["description"],
        status: json["status"],
        subject: json["subject"],
        location: json["location"],
        isOnline: json["is_online"],
        notes: json["notes"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        studentId: json["student_id"],
        teacher:
            json["teacher"] == null ? null : Parent.fromJson(json["teacher"]),
        parent: json["parent"] == null ? null : Parent.fromJson(json["parent"]),
        student: json["student"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "user_id": userId,
        "teacher_id": teacherId,
        "parent_id": parentId,
        "meeting_date":
            "${meetingDate!.year.toString().padLeft(4, '0')}-${meetingDate!.month.toString().padLeft(2, '0')}-${meetingDate!.day.toString().padLeft(2, '0')}",
        "meeting_time": meetingTime,
        "description": description,
        "status": status,
        "subject": subject,
        "location": location,
        "is_online": isOnline,
        "notes": notes,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
        "student_id": studentId,
        "teacher": teacher?.toJson(),
        "parent": parent?.toJson(),
        "student": student,
      };
}

class Parent {
  final int? id;
  final String? title;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? email;
  final String? fcmId;
  final DateTime? emailVerifiedAt;
  final String? type;
  final dynamic mobile;
  final String? image;
  final dynamic dob;
  final dynamic currentAddress;
  final dynamic permanentAddress;
  final int? status;
  final String? pincode;
  final String? language;
  final int? resetRequest;
  final String? hearAboutUs;
  final dynamic countryId;

  Parent({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.gender,
    this.email,
    this.fcmId,
    this.emailVerifiedAt,
    this.type,
    this.mobile,
    this.image,
    this.dob,
    this.currentAddress,
    this.permanentAddress,
    this.status,
    this.pincode,
    this.language,
    this.resetRequest,
    this.hearAboutUs,
    this.countryId,
  });

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        id: json["id"],
        title: json["title"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        email: json["email"],
        fcmId: json["fcm_id"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        type: json["type"],
        mobile: json["mobile"],
        image: json["image"],
        dob: json["dob"],
        currentAddress: json["current_address"],
        permanentAddress: json["permanent_address"],
        status: json["status"],
        pincode: json["pincode"],
        language: json["language"],
        resetRequest: json["reset_request"],
        hearAboutUs: json["hear_about_us"],
        countryId: json["country_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "email": email,
        "fcm_id": fcmId,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "type": type,
        "mobile": mobile,
        "image": image,
        "dob": dob,
        "current_address": currentAddress,
        "permanent_address": permanentAddress,
        "status": status,
        "pincode": pincode,
        "language": language,
        "reset_request": resetRequest,
        "hear_about_us": hearAboutUs,
        "country_id": countryId,
      };
}
