class StudentScheduleResponse {
  final bool? success;
  final String? message;
  final StudentScheduleData? data;

  StudentScheduleResponse({
    this.success,
    this.message,
    this.data,
  });

  factory StudentScheduleResponse.fromJson(Map<String, dynamic> json) {
    return StudentScheduleResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? StudentScheduleData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class StudentScheduleData {
  final StudentScheduleMeta? meta;
  final StudentBranchData? data;

  StudentScheduleData({
    this.meta,
    this.data,
  });

  factory StudentScheduleData.fromJson(Map<String, dynamic> json) {
    return StudentScheduleData(
      meta: json['meta'] != null
          ? StudentScheduleMeta.fromJson(json['meta'])
          : null,
      data: json['data'] != null
          ? StudentBranchData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meta': meta?.toJson(),
      'data': data?.toJson(),
    };
  }
}

class StudentScheduleMeta {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  StudentScheduleMeta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  factory StudentScheduleMeta.fromJson(Map<String, dynamic> json) {
    return StudentScheduleMeta(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPage: json['totalPage'],
    );
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

class StudentBranchData {
  final String? id;
  final String? branchName;
  final List<ClassDistribution>? classDistributions;

  StudentBranchData({
    this.id,
    this.branchName,
    this.classDistributions,
  });

  factory StudentBranchData.fromJson(Map<String, dynamic> json) {
    return StudentBranchData(
      id: json['id'],
      branchName: json['branchName'],
      classDistributions: json['classDistributions'] != null
          ? (json['classDistributions'] as List)
              .map((e) => ClassDistribution.fromJson(e))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'branchName': branchName,
      'classDistributions': classDistributions?.map((e) => e.toJson()).toList(),
    };
  }
}

class ClassDistribution {
  final String? id;
  final String? roomNumber;
  final String? classLevel;
  final String? assignableSubject;
  final String? day;
  final String? time;
  final bool? isOnline;
  final ScheduleTeacher? teacher;

  ClassDistribution({
    this.id,
    this.roomNumber,
    this.classLevel,
    this.assignableSubject,
    this.day,
    this.time,
    this.isOnline,
    this.teacher,
  });

  factory ClassDistribution.fromJson(Map<String, dynamic> json) {
    return ClassDistribution(
      id: json['id'],
      roomNumber: json['roomNumber'],
      classLevel: json['classLevel'],
      assignableSubject: json['assignableSubject'],
      day: json['day'],
      time: json['time'],
      isOnline: json['isOnline'],
      teacher: json['teacher'] != null
          ? ScheduleTeacher.fromJson(json['teacher'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomNumber': roomNumber,
      'classLevel': classLevel,
      'assignableSubject': assignableSubject,
      'day': day,
      'time': time,
      'isOnline': isOnline,
      'teacher': teacher?.toJson(),
    };
  }
}

class ScheduleTeacher {
  final String? id;
  final String? teacherName;
  final String? teacherId;
  final String? email;
  final String? photo;

  ScheduleTeacher({
    this.id,
    this.teacherName,
    this.teacherId,
    this.email,
    this.photo,
  });

  factory ScheduleTeacher.fromJson(Map<String, dynamic> json) {
    return ScheduleTeacher(
      id: json['id'],
      teacherName: json['teacherName'],
      teacherId: json['teacherId'],
      email: json['email'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teacherName': teacherName,
      'teacherId': teacherId,
      'email': email,
      'photo': photo,
    };
  }
}
