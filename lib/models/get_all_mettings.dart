// To parse this JSON data, do
//
//     final getAllMettings = getAllMettingsFromJson(jsonString);

import 'dart:convert';

class GetAllMettings {
  int? status;
  String? message;
  List<Datum>? data;

  GetAllMettings({
    this.status,
    this.message,
    this.data,
  });

  factory GetAllMettings.fromRawJson(String str) =>
      GetAllMettings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllMettings.fromJson(Map<String, dynamic> json) => GetAllMettings(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? title;
  int? userId;
  int? teacherId;
  int? parentId;
  DateTime? meetingDate;
  String? meetingTime;
  String? description;
  String? status;
  String? subject;
  dynamic location;
  int? isOnline;
  dynamic notes;
  DateTime? createdAt;
  DateTime? updatedAt;
  Parent? teacher;
  Parent? parent;

  Datum({
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
    this.teacher,
    this.parent,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        teacher:
            json["teacher"] == null ? null : Parent.fromJson(json["teacher"]),
        parent: json["parent"] == null ? null : Parent.fromJson(json["parent"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "user_id": userId,
        "teacher_id": teacherId,
        "parent_id": parentId,
        "meeting_date":
            "${meetingDate!.year}-${meetingDate!.month}-${meetingDate!.day}",
        "meeting_time": meetingTime,
        "description": description,
        "status": status,
        "subject": subject,
        "location": location,
        "is_online": isOnline,
        "notes": notes,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "teacher": teacher?.toJson(),
        "parent": parent?.toJson(),
      };
}

class Parent {
  int? id;
  String? firstName;
  String? lastName;
  dynamic gender;
  String? email;
  String? fcmId;
  dynamic emailVerifiedAt;
  dynamic mobile;
  String? image;
  dynamic dob;
  dynamic currentAddress;
  dynamic permanentAddress;
  int? status;
  int? resetRequest;

  Parent({
    this.id,
    this.firstName,
    this.lastName,
    this.gender,
    this.email,
    this.fcmId,
    this.emailVerifiedAt,
    this.mobile,
    this.image,
    this.dob,
    this.currentAddress,
    this.permanentAddress,
    this.status,
    this.resetRequest,
  });

  factory Parent.fromRawJson(String str) => Parent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        email: json["email"],
        fcmId: json["fcm_id"],
        emailVerifiedAt: json["email_verified_at"],
        mobile: json["mobile"],
        image: json["image"],
        dob: json["dob"],
        currentAddress: json["current_address"],
        permanentAddress: json["permanent_address"],
        status: json["status"],
        resetRequest: json["reset_request"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "email": email,
        "fcm_id": fcmId,
        "email_verified_at": emailVerifiedAt,
        "mobile": mobile,
        "image": image,
        "dob": dob,
        "current_address": currentAddress,
        "permanent_address": permanentAddress,
        "status": status,
        "reset_request": resetRequest,
      };
}
