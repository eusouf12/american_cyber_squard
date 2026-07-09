class ExamStudentGradeResponse {
  bool? success;
  String? message;
  ExamStudentGradeData? data;

  ExamStudentGradeResponse({
    this.success,
    this.message,
    this.data,
  });

  factory ExamStudentGradeResponse.fromJson(Map<String, dynamic> json) {
    return ExamStudentGradeResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? ExamStudentGradeData.fromJson(json['data'])
          : null,
    );
  }
}

class ExamStudentGradeData {
  ExamStudentGradeMeta? meta;
  List<ExamStudentGrade>? grades;

  ExamStudentGradeData({
    this.meta,
    this.grades,
  });

  factory ExamStudentGradeData.fromJson(Map<String, dynamic> json) {
    return ExamStudentGradeData(
      meta: json['meta'] != null
          ? ExamStudentGradeMeta.fromJson(json['meta'])
          : null,
      grades: (json['data'] as List<dynamic>? ?? [])
          .map((e) => ExamStudentGrade.fromJson(e))
          .toList(),
    );
  }
}

class ExamStudentGradeMeta {
  int? total;
  int? page;
  int? limit;
  int? totalPages;

  ExamStudentGradeMeta({
    this.total,
    this.page,
    this.limit,
    this.totalPages,
  });

  factory ExamStudentGradeMeta.fromJson(Map<String, dynamic> json) {
    return ExamStudentGradeMeta(
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
    );
  }
}

class ExamStudentGrade {
  String? id;
  String? studentId;
  int? totalMarks;
  int? marks;
  String? instructions;
  String? createdAt;
  ExamStudentGradeAnnouncement? examAnnouncement;
  ExamStudentInfo? student;

  ExamStudentGrade({
    this.id,
    this.studentId,
    this.totalMarks,
    this.marks,
    this.instructions,
    this.createdAt,
    this.examAnnouncement,
    this.student,
  });

  factory ExamStudentGrade.fromJson(Map<String, dynamic> json) {
    return ExamStudentGrade(
      id: json['id'],
      studentId: json['studentId'],
      totalMarks: json['totalMarks'],
      marks: json['marks'],
      instructions: json['instructions'],
      createdAt: json['createdAt'],
      examAnnouncement: json['examAnnouncement'] != null
          ? ExamStudentGradeAnnouncement.fromJson(
              json['examAnnouncement'],
            )
          : null,
      student: json['students'] != null
          ? ExamStudentInfo.fromJson(json['students'])
          : null,
    );
  }
}

class ExamStudentGradeAnnouncement {
  String? examDate;
  String? examName;
  ExamStudentGradeClassDistribution? classDistribution;

  ExamStudentGradeAnnouncement({
    this.examDate,
    this.examName,
    this.classDistribution,
  });

  factory ExamStudentGradeAnnouncement.fromJson(
    Map<String, dynamic> json,
  ) {
    return ExamStudentGradeAnnouncement(
      examDate: json['examDate'],
      examName: json['examName'],
      classDistribution: json['classDistribution'] != null
          ? ExamStudentGradeClassDistribution.fromJson(
              json['classDistribution'],
            )
          : null,
    );
  }
}

class ExamStudentGradeClassDistribution {
  String? classLevel;
  String? assignableSubject;

  ExamStudentGradeClassDistribution({
    this.classLevel,
    this.assignableSubject,
  });

  factory ExamStudentGradeClassDistribution.fromJson(
    Map<String, dynamic> json,
  ) {
    return ExamStudentGradeClassDistribution(
      classLevel: json['classLevel'],
      assignableSubject: json['assignableSubject'],
    );
  }
}

class ExamStudentInfo {
  String? name;
  String? email;
  String? photo;
  String? studentId;

  ExamStudentInfo({
    this.name,
    this.email,
    this.photo,
    this.studentId,
  });

  factory ExamStudentInfo.fromJson(Map<String, dynamic> json) {
    return ExamStudentInfo(
      name: json['name'],
      email: json['email'],
      photo: json['photo'],
      studentId: json['studentId'],
    );
  }
}
