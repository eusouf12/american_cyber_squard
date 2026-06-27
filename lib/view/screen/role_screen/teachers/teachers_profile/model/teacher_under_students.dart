class TeacherUnderStudentResponse {
  final bool? success;
  final String? message;
  final TeacherUnderStudentData? data;

  TeacherUnderStudentResponse({
    this.success,
    this.message,
    this.data,
  });

  factory TeacherUnderStudentResponse.fromJson(Map<String, dynamic> json) {
    return TeacherUnderStudentResponse(
      success: json["success"],
      message: json["message"],
      data: json["data"] != null
          ? TeacherUnderStudentData.fromJson(json["data"])
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

class TeacherUnderStudentData {
  final bool? success;
  final String? message;
  final TeacherUnderStudentMeta? meta;
  final List<TeacherUnderStudentItem>? data;

  TeacherUnderStudentData({
    this.success,
    this.message,
    this.meta,
    this.data,
  });

  factory TeacherUnderStudentData.fromJson(Map<String, dynamic> json) {
    return TeacherUnderStudentData(
      success: json["success"],
      message: json["message"],
      meta: json["meta"] != null
          ? TeacherUnderStudentMeta.fromJson(json["meta"])
          : null,
      data: (json["data"] as List?)
          ?.map((e) => TeacherUnderStudentItem.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "meta": meta?.toJson(),
      "data": data?.map((e) => e.toJson()).toList(),
    };
  }
}

class TeacherUnderStudentMeta {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  TeacherUnderStudentMeta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  factory TeacherUnderStudentMeta.fromJson(Map<String, dynamic> json) {
    return TeacherUnderStudentMeta(
      page: json["page"],
      limit: json["limit"],
      total: json["total"],
      totalPage: json["totalPage"],
    );
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

class TeacherUnderStudentItem {
  final String? id;
  final String? name;
  final String? email;
  final String? studentId;
  final String? className;
  final String? photo;
  final String? guardianPhone;
  final List<TeacherUnderStudentClassDistribution>? classDistributions;

  TeacherUnderStudentItem({
    this.id,
    this.name,
    this.email,
    this.studentId,
    this.className,
    this.photo,
    this.guardianPhone,
    this.classDistributions,
  });

  factory TeacherUnderStudentItem.fromJson(Map<String, dynamic> json) {
    return TeacherUnderStudentItem(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      studentId: json["studentId"],
      className: json["className"],
      photo: json["photo"],
      guardianPhone: json["guardianPhone"],
      classDistributions: (json["classDistributions"] as List?)
          ?.map((e) => TeacherUnderStudentClassDistribution.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "studentId": studentId,
      "className": className,
      "photo": photo,
      "guardianPhone": guardianPhone,
      "classDistributions":
          classDistributions?.map((e) => e.toJson()).toList(),
    };
  }
}

class TeacherUnderStudentClassDistribution {
  final String? id;
  final String? classLevel;
  final String? assignableSubject;
  final String? day;
  final String? time;

  TeacherUnderStudentClassDistribution({
    this.id,
    this.classLevel,
    this.assignableSubject,
    this.day,
    this.time,
  });

  factory TeacherUnderStudentClassDistribution.fromJson(
      Map<String, dynamic> json) {
    return TeacherUnderStudentClassDistribution(
      id: json["id"],
      classLevel: json["classLevel"],
      assignableSubject: json["assignableSubject"],
      day: json["day"],
      time: json["time"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "classLevel": classLevel,
      "assignableSubject": assignableSubject,
      "day": day,
      "time": time,
    };
  }
}