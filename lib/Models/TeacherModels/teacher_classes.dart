class Classes {
  final int? id;
  final String? name;
  final int? mediumId;
  final dynamic schoolId;
  final dynamic grade;
  final List<AllSubject>? allSubjects;
  final ClassSection? classSection;

  Classes({
    this.id,
    this.name,
    this.mediumId,
    this.schoolId,
    this.grade,
    this.allSubjects,
    this.classSection,
  });

  factory Classes.fromJson(Map<String, dynamic> json) => Classes(
    id: json["id"],
    name: json["name"],
    mediumId: json["medium_id"],
    schoolId: json["school_id"],
    grade: json["grade"],
    allSubjects: json["all_subjects"] == null
        ? []
        : List<AllSubject>.from(
        json["all_subjects"]!.map((x) => AllSubject.fromJson(x))),
    classSection: json["class_section"] == null
        ? null
        : ClassSection.fromJson(json["class_section"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "medium_id": mediumId,
    "school_id": schoolId,
    "grade": grade,
    "all_subjects": allSubjects == null
        ? []
        : List<dynamic>.from(allSubjects!.map((x) => x.toJson())),
    "class_section": classSection?.toJson(),
  };
}

class AllSubject {
  final int? id;
  final int? classId;
  final String? type;
  final int? subjectId;
  final dynamic electiveSubjectGroupId;
  final Subject? subject;

  AllSubject({
    this.id,
    this.classId,
    this.type,
    this.subjectId,
    this.electiveSubjectGroupId,
    this.subject,
  });

  factory AllSubject.fromJson(Map<String, dynamic> json) => AllSubject(
    id: json["id"],
    classId: json["class_id"],
    type: json["type"],
    subjectId: json["subject_id"],
    electiveSubjectGroupId: json["elective_subject_group_id"],
    subject:
    json["subject"] == null ? null : Subject.fromJson(json["subject"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "class_id": classId,
    "type": type,
    "subject_id": subjectId,
    "elective_subject_group_id": electiveSubjectGroupId,
    "subject": subject?.toJson(),
  };
}

class Subject {
  final int? id;
  final String? name;
  final String? code;
  final String? bgColor;
  final String? image;
  final int? mediumId;
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

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
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

  Map<String, dynamic> toJson() => {
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

class ClassSection {
  final int? id;
  final int? classId;
  final int? sectionId;
  final int? classTeacherId;
  final int? studentsCount;

  ClassSection({
    this.id,
    this.classId,
    this.sectionId,
    this.classTeacherId,
    this.studentsCount,
  });

  factory ClassSection.fromJson(Map<String, dynamic> json) => ClassSection(
    id: json["id"],
    classId: json["class_id"],
    sectionId: json["section_id"],
    classTeacherId: json["class_teacher_id"],
    studentsCount: json["students_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "class_id": classId,
    "section_id": sectionId,
    "class_teacher_id": classTeacherId,
    "students_count": studentsCount,
  };
}