// To parse this JSON data, do
//
//     final getAllSchools = getAllSchoolsFromJson(jsonString);

import 'dart:convert';

// class GetAllSchools {
//   int? status;
//   String? message;
//   List<Schools>? data;
//
//   GetAllSchools({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   factory GetAllSchools.fromRawJson(String str) =>
//       GetAllSchools.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory GetAllSchools.fromJson(Map<String, dynamic> json) => GetAllSchools(
//         status: json["status"],
//         message: json["message"],
//         data: json["data"] == null
//             ? []
//             : List<Schools>.from(json["data"]!.map((x) => Schools.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }

class Schools {
  int? id;
  int? userId;
  int? countryId;
  String? schoolName;
  String? address;
  String? locality;
  String? postTown;
  String? postCode;
  String? image;
  String? email;
  String? phone;
  String? website;
  DateTime? createdAt;
  DateTime? updatedAt;
  Country? country;

  Schools({
    this.id,
    this.userId,
    this.countryId,
    this.schoolName,
    this.address,
    this.locality,
    this.postTown,
    this.postCode,
    this.image,
    this.email,
    this.phone,
    this.website,
    this.createdAt,
    this.updatedAt,
    this.country,
  });

  factory Schools.fromRawJson(String str) => Schools.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Schools.fromJson(Map<String, dynamic> json) => Schools(
        id: json["id"],
        userId: json["user_id"],
        countryId: json["country_id"],
        schoolName: json["school_name"],
        address: json["address"],
        locality: json["locality"],
        postTown: json["post_town"],
        postCode: json["post_code"],
        image: json["image"],
        email: json["email"],
        phone: json["phone"],
        website: json["website"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "country_id": countryId,
        "school_name": schoolName,
        "address": address,
        "locality": locality,
        "post_town": postTown,
        "post_code": postCode,
        "image": image,
        "email": email,
        "phone": phone,
        "website": website,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "country": country?.toJson(),
      };
}

class Country {
  int? id;
  String? code;
  String? name;
  int? phonecode;

  Country({
    this.id,
    this.code,
    this.name,
    this.phonecode,
  });

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        phonecode: json["phonecode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "phonecode": phonecode,
      };
}
