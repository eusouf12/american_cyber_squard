class StudentSubmittedAssignmentResponse {
  bool? success;
  String? message;
  SubmittedAssignmentData? data;

  StudentSubmittedAssignmentResponse({
    this.success,
    this.message,
    this.data,
  });

  StudentSubmittedAssignmentResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? SubmittedAssignmentData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "data": data?.toJson(),
    };
  }
}

class SubmittedAssignmentData {
  SubmittedAssignmentMeta? meta;
  List<SubmittedAssignmentList>? data;

  SubmittedAssignmentData({
    this.meta,
    this.data,
  });

  SubmittedAssignmentData.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null
        ? SubmittedAssignmentMeta.fromJson(json['meta'])
        : null;

    if (json['data'] != null) {
      data = <SubmittedAssignmentList>[];
      json['data'].forEach((v) {
        data!.add(SubmittedAssignmentList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "meta": meta?.toJson(),
      "data": data?.map((e) => e.toJson()).toList(),
    };
  }
}

class SubmittedAssignmentMeta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  SubmittedAssignmentMeta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  SubmittedAssignmentMeta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    return {
      "page": page,
      "limit": limit,
      "total": total,
      "totalPage": totalPage,
    };
  }
}

class SubmittedAssignmentList {
  String? id;
  SubmittedAssignmentInfo? classAssignments;
  SubmittedStudent? student;
  List<SubmittedAssignmentFile>? uploadFiles;

  SubmittedAssignmentList({
    this.id,
    this.classAssignments,
    this.student,
    this.uploadFiles,
  });

  SubmittedAssignmentList.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    classAssignments = json['classAssignments'] != null
        ? SubmittedAssignmentInfo.fromJson(json['classAssignments'])
        : null;

    student = json['student'] != null
        ? SubmittedStudent.fromJson(json['student'])
        : null;

    if (json['uploadFiles'] != null) {
      uploadFiles = <SubmittedAssignmentFile>[];
      json['uploadFiles'].forEach((v) {
        uploadFiles!.add(SubmittedAssignmentFile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "classAssignments": classAssignments?.toJson(),
      "student": student?.toJson(),
      "uploadFiles": uploadFiles?.map((e) => e.toJson()).toList(),
    };
  }
}

class SubmittedAssignmentInfo {
  String? assignmentTitle;

  SubmittedAssignmentInfo({
    this.assignmentTitle,
  });

  SubmittedAssignmentInfo.fromJson(Map<String, dynamic> json) {
    assignmentTitle = json['assignmentTitle'];
  }

  Map<String, dynamic> toJson() {
    return {
      "assignmentTitle": assignmentTitle,
    };
  }
}

class SubmittedStudent {
  String? id;
  String? studentId;
  String? name;
  String? email;
  String? photo;

  SubmittedStudent({
    this.id,
    this.studentId,
    this.name,
    this.email,
    this.photo,
  });

  SubmittedStudent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['studentId'];
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "studentId": studentId,
      "name": name,
      "email": email,
      "photo": photo,
    };
  }
}

class SubmittedAssignmentFile {
  String? id;
  String? fileUrl;
  DateTime? createdAt;

  SubmittedAssignmentFile({
    this.id,
    this.fileUrl,
    this.createdAt,
  });

  SubmittedAssignmentFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileUrl = json['fileUrl'];
    createdAt =
        json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fileUrl": fileUrl,
      "createdAt": createdAt?.toIso8601String(),
    };
  }
}
