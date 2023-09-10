import 'dart:convert';

class TeacherShowClass {
  bool? error;
  String? message;
  List<TeacherClasses>? data;
  int? code;

  TeacherShowClass({
    this.error,
    this.message,
    this.data,
    this.code,
  });

  factory TeacherShowClass.fromRawJson(String str) =>
      TeacherShowClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TeacherShowClass.fromJson(Map<String, dynamic> json) =>
      TeacherShowClass(
        error: json["error"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<TeacherClasses>.from(
                json["data"]!.map((x) => TeacherClasses.fromJson(x))),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "code": code,
      };
}

class TeacherClasses {
  int? id;
  String? name;
  dynamic mediumId;
  int? schoolId;
  dynamic grade;

  TeacherClasses({
    this.id,
    this.name,
    this.mediumId,
    this.schoolId,
    this.grade,
  });

  factory TeacherClasses.fromRawJson(String str) =>
      TeacherClasses.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TeacherClasses.fromJson(Map<String, dynamic> json) => TeacherClasses(
        id: json["id"],
        name: json["name"],
        mediumId: json["medium_id"],
        schoolId: json["school_id"],
        grade: json["grade"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "medium_id": mediumId,
        "school_id": schoolId,
        "grade": grade,
      };
}
