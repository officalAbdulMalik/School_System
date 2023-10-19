import 'dart:convert';

class NewsEvents {
  final int? id;
  final String? title;
  final String? description;
  final String? tableType;
  final dynamic tableId;
  final int? sessionYearId;
  final DateTime? createdAt;
  final dynamic schoolId;
  final dynamic toUser;

  NewsEvents({
    this.id,
    this.title,
    this.description,
    this.tableType,
    this.tableId,
    this.sessionYearId,
    this.createdAt,
    this.schoolId,
    this.toUser,
  });

  factory NewsEvents.fromJson(String str) =>
      NewsEvents.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NewsEvents.fromMap(Map<String, dynamic> json) => NewsEvents(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        tableType: json["table_type"],
        tableId: json["table_id"],
        sessionYearId: json["session_year_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        schoolId: json["school_id"],
        toUser: json["to_user"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "table_type": tableType,
        "table_id": tableId,
        "session_year_id": sessionYearId,
        "created_at": createdAt?.toIso8601String(),
        "school_id": schoolId,
        "to_user": toUser,
      };
}
