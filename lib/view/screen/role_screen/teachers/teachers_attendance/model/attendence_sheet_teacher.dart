class TeacherStudentsAttendenceSheet {
  final bool? success;
  final String? message;
  final TeacherStudentsAttendenceData? data;

  TeacherStudentsAttendenceSheet({
    this.success,
    this.message,
    this.data,
  });

  factory TeacherStudentsAttendenceSheet.fromJson(Map<String, dynamic> json) {
    return TeacherStudentsAttendenceSheet(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? TeacherStudentsAttendenceData.fromJson(json['data'])
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

class TeacherStudentsAttendenceData {
  final TeacherStudentsAttendanceMeta? meta;
  final List<TeacherStudentAttendance>? data;

  TeacherStudentsAttendenceData({
    this.meta,
    this.data,
  });

  factory TeacherStudentsAttendenceData.fromJson(Map<String, dynamic> json) {
    return TeacherStudentsAttendenceData(
      meta: json['meta'] != null
          ? TeacherStudentsAttendanceMeta.fromJson(json['meta'])
          : null,
      data: json['data'] != null
          ? List<TeacherStudentAttendance>.from(
              json['data'].map((x) => TeacherStudentAttendance.fromJson(x)),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meta': meta?.toJson(),
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class TeacherStudentsAttendanceMeta {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  TeacherStudentsAttendanceMeta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  factory TeacherStudentsAttendanceMeta.fromJson(Map<String, dynamic> json) {
    return TeacherStudentsAttendanceMeta(
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

class TeacherStudentAttendance {
  final String? id;
  final String? name;
  final String? studentId;
  final String? className;
  final String? photo;
  final TeacherStaff? staffs;
  final String? attendanceStatus;
  final String? attendanceDate;

  TeacherStudentAttendance({
    this.id,
    this.name,
    this.studentId,
    this.className,
    this.photo,
    this.staffs,
    this.attendanceStatus,
    this.attendanceDate,
  });

  factory TeacherStudentAttendance.fromJson(Map<String, dynamic> json) {
    return TeacherStudentAttendance(
      id: json['id'],
      name: json['name'],
      studentId: json['studentId'],
      className: json['className'],
      photo: json['photo'],
      staffs:
          json['staffs'] != null ? TeacherStaff.fromJson(json['staffs']) : null,
      attendanceStatus: json['attendanceStatus'],
      attendanceDate: json['attendanceDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'studentId': studentId,
      'className': className,
      'photo': photo,
      'staffs': staffs?.toJson(),
      'attendanceStatus': attendanceStatus,
      'attendanceDate': attendanceDate,
    };
  }
}

class TeacherStaff {
  final String? id;
  final String? name;
  final String? email;
  final String? phoneNumber;

  TeacherStaff({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
  });

  factory TeacherStaff.fromJson(Map<String, dynamic> json) {
    return TeacherStaff(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}
