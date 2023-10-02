// To parse this JSON data, do
//
//     final teacherSubject = teacherSubjectFromJson(jsonString);

import 'dart:convert';

TeacherSubject teacherSubjectFromJson(String str) => TeacherSubject.fromJson(json.decode(str));

String teacherSubjectToJson(TeacherSubject data) => json.encode(data.toJson());

class TeacherSubject {
  final int? id;
  final String? name;
  final String? code;
  final String? bgColor;
  final String? image;
  final dynamic mediumId;
  final String? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  TeacherSubject({
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

  factory TeacherSubject.fromJson(Map<String, dynamic> json) => TeacherSubject(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    bgColor: json["bg_color"],
    image: json["image"],
    mediumId: json["medium_id"],
    type: json["type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
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
