import 'dart:convert';

class ShowClassReports {
  final String? id;
  final String? sessionYear;
  final String? quarterId;
  final int? studentId;
  final int? classId;
  final int? subjectId;
  final String? points;
  final String? review;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? grade;
  final User? user;
  final Subject? subject;
  final Quarter? quarter;

  ShowClassReports({
    this.id,
    this.sessionYear,
    this.quarterId,
    this.studentId,
    this.classId,
    this.subjectId,
    this.points,
    this.review,
    this.createdAt,
    this.updatedAt,
    this.grade,
    this.user,
    this.subject,
    this.quarter,
  });

  factory ShowClassReports.fromJson(String str) =>
      ShowClassReports.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShowClassReports.fromMap(Map<String, dynamic> json) =>
      ShowClassReports(
        id: json["id"],
        sessionYear: json["session_year"],
        quarterId: json["quarter_id"],
        studentId: json["student_id"],
        classId: json["class_id"],
        subjectId: json["subject_id"],
        points: json["points"],
        review: json["review"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        grade: json["grade"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        subject:
            json["subject"] == null ? null : Subject.fromMap(json["subject"]),
        quarter:
            json["quarter"] == null ? null : Quarter.fromMap(json["quarter"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "session_year": sessionYear,
        "quarter_id": quarterId,
        "student_id": studentId,
        "class_id": classId,
        "subject_id": subjectId,
        "points": points,
        "review": review,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "grade": grade,
        "user": user?.toMap(),
        "subject": subject?.toMap(),
        "quarter": quarter?.toMap(),
      };
}

class Quarter {
  final String? id;
  final String? name;
  final dynamic createdAt;
  final dynamic updatedAt;

  Quarter({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Quarter.fromJson(String str) => Quarter.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Quarter.fromMap(Map<String, dynamic> json) => Quarter(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Subject {
  final int? id;
  final String? name;
  final String? code;
  final String? bgColor;
  final dynamic image;
  final int? mediumId;
  final String? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  Subject({
    this.id,
    this.name,
    this.code,
    this.bgColor,
    this.image,
    this.mediumId,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Subject.fromJson(String str) => Subject.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Subject.fromMap(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        bgColor: json["bg_color"],
        image: json["image"],
        mediumId: json["medium_id"],
        type: json["type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "code": code,
        "bg_color": bgColor,
        "image": image,
        "medium_id": mediumId,
        "type": type,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class User {
  final int? id;
  final dynamic title;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final dynamic email;
  final dynamic fcmId;
  final dynamic emailVerifiedAt;
  final String? type;
  final dynamic mobile;
  final dynamic image;
  final DateTime? dob;
  final dynamic currentAddress;
  final dynamic permanentAddress;
  final int? status;
  final dynamic pincode;
  final dynamic language;
  final int? resetRequest;
  final dynamic hearAboutUs;
  final dynamic countryId;

  User({
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

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        title: json["title"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        email: json["email"],
        fcmId: json["fcm_id"],
        emailVerifiedAt: json["email_verified_at"],
        type: json["type"],
        mobile: json["mobile"],
        image: json["image"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        currentAddress: json["current_address"],
        permanentAddress: json["permanent_address"],
        status: json["status"],
        pincode: json["pincode"],
        language: json["language"],
        resetRequest: json["reset_request"],
        hearAboutUs: json["hear_about_us"],
        countryId: json["country_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "email": email,
        "fcm_id": fcmId,
        "email_verified_at": emailVerifiedAt,
        "type": type,
        "mobile": mobile,
        "image": image,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
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
