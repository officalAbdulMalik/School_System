import 'dart:convert';

class ClassStudents {
  bool? error;
  String? message;
  Data? data;
  int? code;

  ClassStudents({
    this.error,
    this.message,
    this.data,
    this.code,
  });

  factory ClassStudents.fromRawJson(String str) =>
      ClassStudents.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClassStudents.fromJson(Map<String, dynamic> json) => ClassStudents(
        error: json["error"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data?.toJson(),
        "code": code,
      };
}

class Data {
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  int? id;
  dynamic title;
  String? firstName;
  String? lastName;
  String? gender;
  dynamic email;
  dynamic fcmId;
  dynamic emailVerifiedAt;
  String? type;
  dynamic mobile;
  String? image;
  DateTime? dob;
  dynamic currentAddress;
  dynamic permanentAddress;
  int? status;
  dynamic pincode;
  dynamic language;
  int? resetRequest;
  dynamic hearAboutUs;
  Student? student;

  Datum({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.gender,
    this.email,
    this.fcmId,
    this.emailVerifiedAt,
    this.type,
    this.mobile,
    this.image,
    this.dob,
    this.currentAddress,
    this.permanentAddress,
    this.status,
    this.pincode,
    this.language,
    this.resetRequest,
    this.hearAboutUs,
    this.student,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        email: json["email"],
        fcmId: json["fcm_id"],
        emailVerifiedAt: json["email_verified_at"],
        type: json["type"],
        mobile: json["mobile"],
        image: json["image"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        currentAddress: json["current_address"],
        permanentAddress: json["permanent_address"],
        status: json["status"],
        pincode: json["pincode"],
        language: json["language"],
        resetRequest: json["reset_request"],
        hearAboutUs: json["hear_about_us"],
        student:
            json["student"] == null ? null : Student.fromJson(json["student"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "email": email,
        "fcm_id": fcmId,
        "email_verified_at": emailVerifiedAt,
        "type": type,
        "mobile": mobile,
        "image": image,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "current_address": currentAddress,
        "permanent_address": permanentAddress,
        "status": status,
        "pincode": pincode,
        "language": language,
        "reset_request": resetRequest,
        "hear_about_us": hearAboutUs,
        "student": student?.toJson(),
      };
}

class Student {
  int? id;
  int? userId;
  int? classSectionId;
  dynamic categoryId;
  dynamic admissionNo;
  dynamic rollNumber;
  dynamic caste;
  dynamic religion;
  dynamic admissionDate;
  dynamic bloodGroup;
  dynamic height;
  dynamic weight;
  int? isNewAdmission;
  dynamic fatherId;
  int? motherId;
  dynamic guardianId;
  String? relationship;

  Student({
    this.id,
    this.userId,
    this.classSectionId,
    this.categoryId,
    this.admissionNo,
    this.rollNumber,
    this.caste,
    this.religion,
    this.admissionDate,
    this.bloodGroup,
    this.height,
    this.weight,
    this.isNewAdmission,
    this.fatherId,
    this.motherId,
    this.guardianId,
    this.relationship,
  });

  factory Student.fromRawJson(String str) => Student.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        userId: json["user_id"],
        classSectionId: json["class_section_id"],
        categoryId: json["category_id"],
        admissionNo: json["admission_no"],
        rollNumber: json["roll_number"],
        caste: json["caste"],
        religion: json["religion"],
        admissionDate: json["admission_date"],
        bloodGroup: json["blood_group"],
        height: json["height"],
        weight: json["weight"],
        isNewAdmission: json["is_new_admission"],
        fatherId: json["father_id"],
        motherId: json["mother_id"],
        guardianId: json["guardian_id"],
        relationship: json["relationship"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "class_section_id": classSectionId,
        "category_id": categoryId,
        "admission_no": admissionNo,
        "roll_number": rollNumber,
        "caste": caste,
        "religion": religion,
        "admission_date": admissionDate,
        "blood_group": bloodGroup,
        "height": height,
        "weight": weight,
        "is_new_admission": isNewAdmission,
        "father_id": fatherId,
        "mother_id": motherId,
        "guardian_id": guardianId,
        "relationship": relationship,
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
