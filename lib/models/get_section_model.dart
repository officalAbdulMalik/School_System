import 'dart:convert';

class Sections {
  bool? error;
  String? message;
  List<Section>? sections;
  int? code;

  Sections({
    this.error,
    this.message,
    this.sections,
    this.code,
  });

  factory Sections.fromRawJson(String str) =>
      Sections.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Sections.fromJson(Map<String, dynamic> json) => Sections(
        error: json["error"],
        message: json["message"],
        sections: json["sections"] == null
            ? []
            : List<Section>.from(
                json["sections"]!.map((x) => Section.fromJson(x))),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "sections": sections == null
            ? []
            : List<dynamic>.from(sections!.map((x) => x.toJson())),
        "code": code,
      };
}

class Section {
  int? id;
  String? name;
  int? schoolId;

  Section({
    this.id,
    this.name,
    this.schoolId,
  });

  factory Section.fromRawJson(String str) => Section.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        name: json["name"],
        schoolId: json["school_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "school_id": schoolId,
      };
}
