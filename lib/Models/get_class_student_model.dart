import 'dart:convert';

class ClassStudents {
  final int? id;
  final dynamic title;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final dynamic email;
  final dynamic fcmId;
  final dynamic emailVerifiedAt;
  final String? type;
  final dynamic mobile;
  final String? image;
  final DateTime? dob;
  final dynamic currentAddress;
  final dynamic permanentAddress;
  final int? status;
  final dynamic pincode;
  final dynamic language;
  final int? resetRequest;
  final dynamic hearAboutUs;
  final dynamic countryId;
  final Students? student;

  ClassStudents({
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
    this.student,
  });

  factory ClassStudents.fromJson(String str) =>
      ClassStudents.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClassStudents.fromMap(Map<String, dynamic> json) => ClassStudents(
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
        countryId: json["country_id"],
        student:
            json["student"] == null ? null : Students.fromMap(json["student"]),
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
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "current_address": currentAddress,
        "permanent_address": permanentAddress,
        "status": status,
        "pincode": pincode,
        "language": language,
        "reset_request": resetRequest,
        "hear_about_us": hearAboutUs,
        "country_id": countryId,
        "student": student?.toMap(),
      };
}

class Students {
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
  final ClassSection? classSection;

  Students({
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
    this.classSection,
  });

  factory Students.fromJson(String str) => Students.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Students.fromMap(Map<String, dynamic> json) => Students(
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
        classSection: json["class_section"] == null
            ? null
            : ClassSection.fromMap(json["class_section"]),
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
        "class_section": classSection?.toMap(),
      };
}

class ClassSection {
  final int? id;
  final int? classId;
  final int? sectionId;
  final dynamic classTeacherId;
  final Class? classSectionClass;

  ClassSection({
    this.id,
    this.classId,
    this.sectionId,
    this.classTeacherId,
    this.classSectionClass,
  });

  factory ClassSection.fromJson(String str) =>
      ClassSection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClassSection.fromMap(Map<String, dynamic> json) => ClassSection(
        id: json["id"],
        classId: json["class_id"],
        sectionId: json["section_id"],
        classTeacherId: json["class_teacher_id"],
        classSectionClass:
            json["class"] == null ? null : Class.fromMap(json["class"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "class_id": classId,
        "section_id": sectionId,
        "class_teacher_id": classTeacherId,
        "class": classSectionClass?.toMap(),
      };
}

class Class {
  final int? id;
  final String? name;
  final int? mediumId;
  final dynamic schoolId;
  final dynamic grade;
  final dynamic school;

  Class({
    this.id,
    this.name,
    this.mediumId,
    this.schoolId,
    this.grade,
    this.school,
  });

  factory Class.fromJson(String str) => Class.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Class.fromMap(Map<String, dynamic> json) => Class(
        id: json["id"],
        name: json["name"],
        mediumId: json["medium_id"],
        schoolId: json["school_id"],
        grade: json["grade"],
        school: json["school"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "medium_id": mediumId,
        "school_id": schoolId,
        "grade": grade,
        "school": school,
      };
}
