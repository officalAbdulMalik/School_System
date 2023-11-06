import 'dart:convert';

class NotificationsModel {
  final String? id;
  final int? userId;
  final int? fromUserId;
  final String? message;
  final int? read;
  final dynamic data;
  final DateTime? createdAt;
  final dynamic updatedAt;
  final dynamic deletedAt;
  final FromUser? fromUser;

  NotificationsModel({
    this.id,
    this.userId,
    this.fromUserId,
    this.message,
    this.read,
    this.data,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.fromUser,
  });

  factory NotificationsModel.fromJson(String str) =>
      NotificationsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificationsModel.fromMap(Map<String, dynamic> json) =>
      NotificationsModel(
        id: json["id"],
        userId: json["user_id"],
        fromUserId: json["from_user_id"],
        message: json["message"],
        read: json["read"],
        data: json["data"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        fromUser: json["from_user"] == null
            ? null
            : FromUser.fromMap(json["from_user"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "from_user_id": fromUserId,
        "message": message,
        "read": read,
        "data": data,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "from_user": fromUser?.toMap(),
      };
}

class FromUser {
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
  final int? countryId;

  FromUser({
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

  factory FromUser.fromJson(String str) => FromUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FromUser.fromMap(Map<String, dynamic> json) => FromUser(
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
      };
}
