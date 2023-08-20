// To parse this JSON data, do
//
//     final histrory = histroryFromJson(jsonString);

import 'dart:convert';

class ParentsTeacherModel {
  int? status;
  String? message;
  List<ParentsTeacherData>? data;

  ParentsTeacherModel({
    this.status,
    this.message,
    this.data,
  });

  factory ParentsTeacherModel.fromRawJson(String str) =>
      ParentsTeacherModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ParentsTeacherModel.fromJson(Map<String, dynamic> json) =>
      ParentsTeacherModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ParentsTeacherData>.from(
                json["data"]!.map((x) => ParentsTeacherData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ParentsTeacherData {
  int? id;
  String? title;
  String? firstName;
  String? lastName;
  String? gender;
  String? email;
  String? fcmId;
  DateTime? emailVerifiedAt;
  String? type;
  String? mobile;
  String? image;
  DateTime? dob;
  String? currentAddress;
  String? permanentAddress;
  int? status;
  String? language;
  int? resetRequest;
  String? hearAboutUs;

  ParentsTeacherData({
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
    this.language,
    this.resetRequest,
    this.hearAboutUs,
  });

  factory ParentsTeacherData.fromRawJson(String str) =>
      ParentsTeacherData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ParentsTeacherData.fromJson(Map<String, dynamic> json) =>
      ParentsTeacherData(
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
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        currentAddress: json["current_address"],
        permanentAddress: json["permanent_address"],
        status: json["status"],
        language: json["language"],
        resetRequest: json["reset_request"],
        hearAboutUs: json["hear_about_us"],
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
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "current_address": currentAddress,
        "permanent_address": permanentAddress,
        "status": status,
        "language": language,
        "reset_request": resetRequest,
        "hear_about_us": hearAboutUs,
      };
}
