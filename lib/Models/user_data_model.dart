import 'dart:convert';

class UserData {
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
  final dynamic pincode;
  final String? language;
  final int? resetRequest;
  final String? hearAboutUs;
  final dynamic countryId;
  final dynamic parent;
  final Teacher? teacher;

  UserData({
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
    this.parent,
    this.teacher,
  });

  factory UserData.fromJson(String str) => UserData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
    id: json["id"],
    title: json["title"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    gender: json["gender"],
    email: json["email"],
    fcmId: json["fcm_id"],
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
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
    parent: json["parent"],
    teacher: json["teacher"] == null ? null : Teacher.fromMap(json["teacher"]),
  );

  Map<String, dynamic> toMap() => {
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
    "parent": parent,
    "teacher": teacher?.toMap(),
  };
}

class Teacher {
  final int? id;
  final int? userId;
  final String? qualification;

  Teacher({
    this.id,
    this.userId,
    this.qualification,
  });

  factory Teacher.fromJson(String str) => Teacher.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Teacher.fromMap(Map<String, dynamic> json) => Teacher(
    id: json["id"],
    userId: json["user_id"],
    qualification: json["qualification"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "qualification": qualification,
  };
}
