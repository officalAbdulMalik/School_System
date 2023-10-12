// To parse this JSON data, do
//
//     final getSessiosn = getSessiosnFromMap(jsonString);

import 'dart:convert';

GetSessiosn getSessiosnFromMap(String str) =>
    GetSessiosn.fromMap(json.decode(str));

String getSessiosnToMap(GetSessiosn data) => json.encode(data.toMap());

class GetSessiosn {
  int? id;
  String? name;
  int? getSessiosnDefault;
  DateTime? startDate;
  DateTime? endDate;
  int? includeFeeInstallments;
  DateTime? feeDueDate;
  int? feeDueCharges;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  GetSessiosn({
    this.id,
    this.name,
    this.getSessiosnDefault,
    this.startDate,
    this.endDate,
    this.includeFeeInstallments,
    this.feeDueDate,
    this.feeDueCharges,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory GetSessiosn.fromMap(Map<String, dynamic> json) => GetSessiosn(
        id: json["id"],
        name: json["name"],
        getSessiosnDefault: json["default"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        includeFeeInstallments: json["include_fee_installments"],
        feeDueDate: json["fee_due_date"] == null
            ? null
            : DateTime.parse(json["fee_due_date"]),
        feeDueCharges: json["fee_due_charges"],
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
        "default": getSessiosnDefault,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "include_fee_installments": includeFeeInstallments,
        "fee_due_date":
            "${feeDueDate!.year.toString().padLeft(4, '0')}-${feeDueDate!.month.toString().padLeft(2, '0')}-${feeDueDate!.day.toString().padLeft(2, '0')}",
        "fee_due_charges": feeDueCharges,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
