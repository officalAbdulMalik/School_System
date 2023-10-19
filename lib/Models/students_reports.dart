import 'dart:convert';

class StudentsReports {
  final bool? error;
  final String? message;
  final Data? data;
  final int? code;

  StudentsReports({
    this.error,
    this.message,
    this.data,
    this.code,
  });

  factory StudentsReports.fromJson(String str) =>
      StudentsReports.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StudentsReports.fromMap(Map<String, dynamic> json) => StudentsReports(
        error: json["error"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "data": data?.toMap(),
        "code": code,
      };
}

class Data {
  final List<AllReports>? reports;
  final List<dynamic>? published;

  Data({
    this.reports,
    this.published,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        reports: json["reports"] == null
            ? []
            : List<AllReports>.from(
                json["reports"]!.map((x) => AllReports.fromMap(x))),
        published: json["published"] == null
            ? []
            : List<dynamic>.from(json["published"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "reports": reports == null
            ? []
            : List<dynamic>.from(reports!.map((x) => x.toMap())),
        "published": published == null
            ? []
            : List<dynamic>.from(published!.map((x) => x)),
      };
}

class AllReports {
  final String? id;
  final String? sessionYear;
  final String? quarterId;
  final int? studentId;
  final int? classId;
  final int? subjectId;
  final String? points;
  final dynamic review;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? grade;
  final Quarter? quarter;
  final Subject? subject;

  AllReports({
    this.id,
    this.sessionYear,
    this.quarterId,
    this.studentId,
    this.classId,
    this.subjectId,
    this.points,
    this.review,
    this.createdAt,
    this.updatedAt,
    this.grade,
    this.quarter,
    this.subject,
  });

  factory AllReports.fromJson(String str) =>
      AllReports.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllReports.fromMap(Map<String, dynamic> json) => AllReports(
        id: json["id"],
        sessionYear: json["session_year"],
        quarterId: json["quarter_id"],
        studentId: json["student_id"],
        classId: json["class_id"],
        subjectId: json["subject_id"],
        points: json["points"],
        review: json["review"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        grade: json["grade"],
        quarter:
            json["quarter"] == null ? null : Quarter.fromMap(json["quarter"]),
        subject:
            json["subject"] == null ? null : Subject.fromMap(json["subject"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "session_year": sessionYear,
        "quarter_id": quarterId,
        "student_id": studentId,
        "class_id": classId,
        "subject_id": subjectId,
        "points": points,
        "review": review,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "grade": grade,
        "quarter": quarter?.toMap(),
        "subject": subject?.toMap(),
      };
}

class Quarter {
  final String? id;
  final String? name;
  final dynamic createdAt;
  final dynamic updatedAt;

  Quarter({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Quarter.fromJson(String str) => Quarter.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Quarter.fromMap(Map<String, dynamic> json) => Quarter(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Subject {
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

  Subject({
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

  factory Subject.fromJson(String str) => Subject.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Subject.fromMap(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        bgColor: json["bg_color"],
        image: json["image"],
        mediumId: json["medium_id"],
        type: json["type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
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
