import 'dart:convert';

class ParentsTeachers {
  final int? id;
  final String? title;
  final String? firstName;
  final String? lastName;
  final dynamic gender;
  final String? email;
  final String? fcmId;
  final dynamic emailVerifiedAt;
  final String? type;
  final dynamic mobile;
  final dynamic image;
  final dynamic dob;
  final dynamic currentAddress;
  final dynamic permanentAddress;
  final int? status;
  final String? pincode;
  final String? language;
  final int? resetRequest;
  final String? hearAboutUs;
  final int? countryId;
  final List<ParentStudent>? parentStudents;

  ParentsTeachers({
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
    this.countryId,
    this.parentStudents,
  });

  factory ParentsTeachers.fromJson(String str) =>
      ParentsTeachers.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ParentsTeachers.fromMap(Map<String, dynamic> json) => ParentsTeachers(
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
        dob: json["dob"],
        currentAddress: json["current_address"],
        permanentAddress: json["permanent_address"],
        status: json["status"],
        pincode: json["pincode"],
        language: json["language"],
        resetRequest: json["reset_request"],
        hearAboutUs: json["hear_about_us"],
        countryId: json["country_id"],
        parentStudents: json["parent_students"] == null
            ? []
            : List<ParentStudent>.from(
                json["parent_students"]!.map((x) => ParentStudent.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
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
        "dob": dob,
        "current_address": currentAddress,
        "permanent_address": permanentAddress,
        "status": status,
        "pincode": pincode,
        "language": language,
        "reset_request": resetRequest,
        "hear_about_us": hearAboutUs,
        "country_id": countryId,
        "parent_students": parentStudents == null
            ? []
            : List<dynamic>.from(parentStudents!.map((x) => x.toMap())),
      };
}

class ParentStudent {
  final int? id;
  final int? userId;
  final int? classSectionId;
  final dynamic categoryId;
  final dynamic admissionNo;
  final dynamic rollNumber;
  final dynamic caste;
  final dynamic religion;
  final dynamic admissionDate;
  final dynamic bloodGroup;
  final dynamic height;
  final dynamic weight;
  final int? isNewAdmission;
  final dynamic fatherId;
  final int? motherId;
  final dynamic guardianId;
  final String? relationship;

  ParentStudent({
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

  factory ParentStudent.fromJson(String str) =>
      ParentStudent.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ParentStudent.fromMap(Map<String, dynamic> json) => ParentStudent(
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

  Map<String, dynamic> toMap() => {
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
