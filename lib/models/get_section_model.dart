// To parse this JSON data, do
//
//     final sections = sectionsFromJson(jsonString);

import 'dart:convert';

Sections sectionsFromJson(String str) => Sections.fromJson(json.decode(str));

String sectionsToJson(Sections data) => json.encode(data.toJson());

class Sections {
  final int? id;
  final String? name;
  final int? schoolId;

  Sections({
    this.id,
    this.name,
    this.schoolId,
  });

  factory Sections.fromJson(Map<String, dynamic> json) => Sections(
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
