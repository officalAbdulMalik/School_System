import 'dart:convert';

class Participation {
  final int? id;
  final String? title;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? email;
  final String? fcmId;
  final dynamic emailVerifiedAt;
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

  Participation({
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

  factory Participation.fromRawJson(String str) => Participation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Participation.fromJson(Map<String, dynamic> json) => Participation(
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
    "country_id": countryId,
  };
}
