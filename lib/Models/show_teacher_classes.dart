import 'dart:convert';

// class TeacherClasses {
//   bool? error;
//   String? message;
//   List<Classes>? data;
//   int? code;
//
//   TeacherClasses({
//     this.error,
//     this.message,
//     this.data,
//     this.code,
//   });
//
//   factory TeacherClasses.fromRawJson(String str) =>
//       TeacherClasses.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory TeacherClasses.fromJson(Map<String, dynamic> json) => TeacherClasses(
//         error: json["error"],
//         message: json["message"],
//         data: json["data"] == null
//             ? []
//             : List<Classes>.from(json["data"]!.map((x) => Classes.fromJson(x))),
//         code: json["code"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "error": error,
//         "message": message,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//         "code": code,
//       };
// }

class Classes {
  int? id;
  String? name;
  dynamic mediumId;
  int? schoolId;
  dynamic grade;

  Classes({
    this.id,
    this.name,
    this.mediumId,
    this.schoolId,
    this.grade,
  });

  factory Classes.fromRawJson(String str) => Classes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Classes.fromJson(Map<String, dynamic> json) => Classes(
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
