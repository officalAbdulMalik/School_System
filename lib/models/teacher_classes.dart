import 'dart:convert';

class TeacherClasses {
  bool? error;
  String? message;
  List<Datum>? data;
  int? code;

  TeacherClasses({
    this.error,
    this.message,
    this.data,
    this.code,
  });

  factory TeacherClasses.fromRawJson(String str) =>
      TeacherClasses.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TeacherClasses.fromJson(Map<String, dynamic> json) => TeacherClasses(
        error: json["error"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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

class Datum {
  int? id;
  String? name;
  dynamic mediumId;
  int? schoolId;
  dynamic grade;

  Datum({
    this.id,
    this.name,
    this.mediumId,
    this.schoolId,
    this.grade,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
