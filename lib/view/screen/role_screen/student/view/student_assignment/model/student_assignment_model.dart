class StudentAssignmentResponse {
  bool? success;
  String? message;
  StudentAssignmentData? data;

  StudentAssignmentResponse({
    this.success,
    this.message,
    this.data,
  });

  StudentAssignmentResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? StudentAssignmentData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class StudentAssignmentData {
  StudentAssignmentMeta? meta;
  StudentAssignmentSummary? summary;
  List<StudentAssignmentStudent>? data;

  StudentAssignmentData({
    this.meta,
    this.summary,
    this.data,
  });

  StudentAssignmentData.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null
        ? StudentAssignmentMeta.fromJson(json['meta'])
        : null;

    summary = json['summary'] != null
        ? StudentAssignmentSummary.fromJson(json['summary'])
        : null;

    if (json['data'] != null) {
      data = <StudentAssignmentStudent>[];
      json['data'].forEach((v) {
        data!.add(StudentAssignmentStudent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'meta': meta?.toJson(),
      'summary': summary?.toJson(),
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class StudentAssignmentMeta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  StudentAssignmentMeta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  StudentAssignmentMeta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'total': total,
      'totalPage': totalPage,
    };
  }
}

class StudentAssignmentSummary {
  int? total;
  int? completed;
  int? pending;
  int? due;

  StudentAssignmentSummary({
    this.total,
    this.completed,
    this.pending,
    this.due,
  });

  StudentAssignmentSummary.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    completed = json['completed'];
    pending = json['pending'];
    due = json['due'];
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'completed': completed,
      'pending': pending,
      'due': due,
    };
  }
}

class StudentAssignmentStudent {
  String? id;
  String? name;
  List<StudentAssignmentClassDistribution>? classDistributions;

  StudentAssignmentStudent({
    this.id,
    this.name,
    this.classDistributions,
  });

  StudentAssignmentStudent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

    if (json['classDistributions'] != null) {
      classDistributions = <StudentAssignmentClassDistribution>[];
      json['classDistributions'].forEach((v) {
        classDistributions!.add(StudentAssignmentClassDistribution.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'classDistributions': classDistributions?.map((e) => e.toJson()).toList(),
    };
  }
}

class StudentAssignmentClassDistribution {
  String? id;
  String? classLevel;
  String? assignableSubject;
  StudentAssignmentTeacher? teacher;
  List<StudentClassAssignment>? classAssignments;

  StudentAssignmentClassDistribution({
    this.id,
    this.classLevel,
    this.assignableSubject,
    this.teacher,
    this.classAssignments,
  });

  StudentAssignmentClassDistribution.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classLevel = json['classLevel'];
    assignableSubject = json['assignableSubject'];

    teacher = json['teacher'] != null
        ? StudentAssignmentTeacher.fromJson(json['teacher'])
        : null;

    if (json['classAssignments'] != null) {
      classAssignments = <StudentClassAssignment>[];
      json['classAssignments'].forEach((v) {
        classAssignments!.add(StudentClassAssignment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'classLevel': classLevel,
      'assignableSubject': assignableSubject,
      'teacher': teacher?.toJson(),
      'classAssignments': classAssignments?.map((e) => e.toJson()).toList(),
    };
  }
}

class StudentAssignmentTeacher {
  String? teacherName;
  String? teacherId;
  String? email;
  String? phoneNumber;

  StudentAssignmentTeacher({
    this.teacherName,
    this.teacherId,
    this.email,
    this.phoneNumber,
  });

  StudentAssignmentTeacher.fromJson(Map<String, dynamic> json) {
    teacherName = json['teacherName'];
    teacherId = json['teacherId'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    return {
      'teacherName': teacherName,
      'teacherId': teacherId,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}

class StudentClassAssignment {
  String? id;
  String? assignmentTitle;
  String? assignmentType;
  DateTime? assignmentDueDate;
  String? description;
  List<String>? attachmentFiles;
  bool? assessmentAvailable;
  DateTime? createdAt;
  String? status;

  StudentClassAssignment({
    this.id,
    this.assignmentTitle,
    this.assignmentType,
    this.assignmentDueDate,
    this.description,
    this.attachmentFiles,
    this.assessmentAvailable,
    this.createdAt,
    this.status,
  });

  StudentClassAssignment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assignmentTitle = json['assignmentTitle'];
    assignmentType = json['assignmentType'];

    assignmentDueDate = json['assignmentDueDate'] != null
        ? DateTime.tryParse(json['assignmentDueDate'])
        : null;

    description = json['description'];

    attachmentFiles = json['attachmentFiles'] != null
        ? List<String>.from(json['attachmentFiles'])
        : [];

    assessmentAvailable = json['assessmentAvailable'];

    createdAt =
        json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null;

    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'assignmentTitle': assignmentTitle,
      'assignmentType': assignmentType,
      'assignmentDueDate': assignmentDueDate?.toIso8601String(),
      'description': description,
      'attachmentFiles': attachmentFiles,
      'assessmentAvailable': assessmentAvailable,
      'createdAt': createdAt?.toIso8601String(),
      'status': status,
    };
  }
}
