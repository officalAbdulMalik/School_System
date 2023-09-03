import 'dart:convert';

class TeacherSubjects {
  bool? error;
  String? message;
  List<Datum>? data;
  int? code;

  TeacherSubjects({
    this.error,
    this.message,
    this.data,
    this.code,
  });

  factory TeacherSubjects.fromRawJson(String str) =>
      TeacherSubjects.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TeacherSubjects.fromJson(Map<String, dynamic> json) =>
      TeacherSubjects(
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
  String? code;
  String? bgColor;
  String? image;
  int? mediumId;
  String? type;

  Datum({
    this.id,
    this.name,
    this.code,
    this.bgColor,
    this.image,
    this.mediumId,
    this.type,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        bgColor: json["bg_color"],
        image: json["image"],
        mediumId: json["medium_id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "bg_color": bgColor,
        "image": image,
        "medium_id": mediumId,
        "type": type,
      };
}
