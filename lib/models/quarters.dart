// To parse this JSON data, do
//
//     final quarters = quartersFromMap(jsonString);

import 'dart:convert';

Quarters quartersFromMap(String str) => Quarters.fromMap(json.decode(str));

String quartersToMap(Quarters data) => json.encode(data.toMap());

class Quarters {
  String? id;
  String? name;
  dynamic createdAt;
  dynamic updatedAt;

  Quarters({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Quarters.fromMap(Map<String, dynamic> json) => Quarters(
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
