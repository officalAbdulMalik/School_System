import 'dart:convert';

class UserData {
  int? status;
  String? message;
  User? user;

  UserData({
    this.status,
    this.message,
    this.user,
  });

  factory UserData.fromRawJson(String str) =>
      UserData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        status: json["status"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user?.toJson(),
      };
}

class User {
  int? id;
  String? title;
  String? firstName;
  String? lastName;
  String? gender;
  String? email;
  String? fcmId;
  dynamic emailVerifiedAt;
  String? type;
  dynamic mobile;
  String? image;
  dynamic dob;
  dynamic currentAddress;
  dynamic permanentAddress;
  int? status;
  dynamic pincode;
  String? language;
  int? resetRequest;
  String? hearAboutUs;
  dynamic parent;
  Teacher? teacher;

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
    this.parent,
    this.teacher,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
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
        dob: json["dob"],
        currentAddress: json["current_address"],
        permanentAddress: json["permanent_address"],
        status: json["status"],
        pincode: json["pincode"],
        language: json["language"],
        resetRequest: json["reset_request"],
        hearAboutUs: json["hear_about_us"],
        parent: json["parent"],
        teacher:
            json["teacher"] == null ? null : Teacher.fromJson(json["teacher"]),
      );

  Map<String, dynamic> toJson() => {
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
        "dob": dob,
        "current_address": currentAddress,
        "permanent_address": permanentAddress,
        "status": status,
        "pincode": pincode,
        "language": language,
        "reset_request": resetRequest,
        "hear_about_us": hearAboutUs,
        "parent": parent,
        "teacher": teacher?.toJson(),
      };
}

class Teacher {
  int? id;
  int? userId;
  String? qualification;

  Teacher({
    this.id,
    this.userId,
    this.qualification,
  });

  factory Teacher.fromRawJson(String str) => Teacher.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        id: json["id"],
        userId: json["user_id"],
        qualification: json["qualification"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "qualification": qualification,
      };
}
