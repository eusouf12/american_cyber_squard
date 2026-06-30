class TeacherStudentDetailsResponse {
  final bool? success;
  final String? message;
  final TeacherStudentDetailsData? data;

  TeacherStudentDetailsResponse({
    this.success,
    this.message,
    this.data,
  });

  factory TeacherStudentDetailsResponse.fromJson(
      Map<String, dynamic> json) {
    return TeacherStudentDetailsResponse(
      success: json["success"],
      message: json["message"],
      data: json["data"] != null
          ? TeacherStudentDetailsData.fromJson(json["data"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "data": data?.toJson(),
    };
  }
}

class TeacherStudentDetailsData {
  final String? id;
  final String? email;
  final String? photo;
  final String? studentId;
  final String? guardianName;
  final String? guardianPhone;
  final List<TeacherStudentDetailsClassDistribution>? classDistributions;
  final List<TeacherStudentDetailsExamGrade>? examGrades;
  final List<TeacherStudentDetailsHealthRecord>? healthRecords;

  TeacherStudentDetailsData({
    this.id,
    this.email,
    this.photo,
    this.studentId,
    this.guardianName,
    this.guardianPhone,
    this.classDistributions,
    this.examGrades,
    this.healthRecords,
  });

  factory TeacherStudentDetailsData.fromJson(
      Map<String, dynamic> json) {
    return TeacherStudentDetailsData(
      id: json["id"],
      email: json["email"],
      photo: json["photo"],
      studentId: json["studentId"],
      guardianName: json["guardianName"],
      guardianPhone: json["guardianPhone"],
      classDistributions: (json["classDistributions"] as List?)
          ?.map((e) => TeacherStudentDetailsClassDistribution.fromJson(e))
          .toList(),
      examGrades: (json["examGrades"] as List?)
          ?.map((e) => TeacherStudentDetailsExamGrade.fromJson(e))
          .toList(),
      healthRecords: (json["healthRecords"] as List?)
          ?.map((e) => TeacherStudentDetailsHealthRecord.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "photo": photo,
      "studentId": studentId,
      "guardianName": guardianName,
      "guardianPhone": guardianPhone,
      "classDistributions":classDistributions?.map((e) => e.toJson()).toList(),
      "examGrades": examGrades?.map((e) => e.toJson()).toList(),
      "healthRecords": healthRecords?.map((e) => e.toJson()).toList(),
    };
  }
}

class TeacherStudentDetailsClassDistribution {
  final String? classLevel;

  TeacherStudentDetailsClassDistribution({
    this.classLevel,
  });

  factory TeacherStudentDetailsClassDistribution.fromJson(
      Map<String, dynamic> json) {
    return TeacherStudentDetailsClassDistribution(
      classLevel: json["classLevel"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "classLevel": classLevel,
    };
  }
}

class TeacherStudentDetailsExamGrade {
  final int? totalMarks;
  final int? marks;
  final String? instructions;
  final String? createdAt;

  TeacherStudentDetailsExamGrade({
    this.totalMarks,
    this.marks,
    this.instructions,
    this.createdAt,
  });

  factory TeacherStudentDetailsExamGrade.fromJson(
      Map<String, dynamic> json) {
    return TeacherStudentDetailsExamGrade(
      totalMarks: json["totalMarks"],
      marks: json["marks"],
      instructions: json["instructions"],
      createdAt: json["createdAt"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "totalMarks": totalMarks,
      "marks": marks,
      "instructions": instructions,
      "createdAt": createdAt,
    };
  }
}

class TeacherStudentDetailsHealthRecord {
  final String? bloodType;
  final String? tipTapEditor;
  final String? emergencyContact;
  final String? createdAt;

  TeacherStudentDetailsHealthRecord({
    this.bloodType,
    this.tipTapEditor,
    this.emergencyContact,
    this.createdAt,
  });

  factory TeacherStudentDetailsHealthRecord.fromJson(
      Map<String, dynamic> json) {
    return TeacherStudentDetailsHealthRecord(
      bloodType: json["bloodType"],
      tipTapEditor: json["tipTapEditor"],
      emergencyContact: json["emergencyContact"],
      createdAt: json["createdAt"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "bloodType": bloodType,
      "tipTapEditor": tipTapEditor,
      "emergencyContact": emergencyContact,
      "createdAt": createdAt,
    };
  }
}