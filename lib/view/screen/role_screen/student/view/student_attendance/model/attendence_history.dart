class StudentAttendanceHistoryResponse {
  bool? success;
  String? message;
  StudentAttendanceHistoryData? data;

  StudentAttendanceHistoryResponse({
    this.success,
    this.message,
    this.data,
  });

  StudentAttendanceHistoryResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? StudentAttendanceHistoryData.fromJson(json['data'])
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

class StudentAttendanceHistoryData {
  AttendanceMeta? meta;
  AttendanceStatistics? statistics;
  List<AttendanceHistoryList>? data;

  StudentAttendanceHistoryData({
    this.meta,
    this.statistics,
    this.data,
  });

  StudentAttendanceHistoryData.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? AttendanceMeta.fromJson(json['meta']) : null;

    statistics = json['statistics'] != null
        ? AttendanceStatistics.fromJson(json['statistics'])
        : null;

    if (json['data'] != null) {
      data = <AttendanceHistoryList>[];
      json['data'].forEach((v) {
        data!.add(AttendanceHistoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "meta": meta?.toJson(),
      "statistics": statistics?.toJson(),
      "data": data?.map((e) => e.toJson()).toList(),
    };
  }
}

class AttendanceMeta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  AttendanceMeta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  AttendanceMeta.fromJson(Map<String, dynamic> json) {
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

class AttendanceStatistics {
  int? totalAttendance;
  int? present;
  int? absent;
  double? presentPercentage;
  double? absentPercentage;

  AttendanceStatistics({
    this.totalAttendance,
    this.present,
    this.absent,
    this.presentPercentage,
    this.absentPercentage,
  });

  AttendanceStatistics.fromJson(Map<String, dynamic> json) {
    totalAttendance = json['totalAttendance'];
    present = json['present'];
    absent = json['absent'];
    presentPercentage = json['presentPercentage']?.toDouble();
    absentPercentage = json['absentPercentage']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    return {
      "totalAttendance": totalAttendance,
      "present": present,
      "absent": absent,
      "presentPercentage": presentPercentage,
      "absentPercentage": absentPercentage,
    };
  }
}

class AttendanceHistoryList {
  String? id;
  DateTime? attendanceDate;
  String? attendanceStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  AttendanceHistoryList({
    this.id,
    this.attendanceDate,
    this.attendanceStatus,
    this.createdAt,
    this.updatedAt,
  });

  AttendanceHistoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attendanceDate = json['AttendanceDate'] != null
        ? DateTime.tryParse(json['AttendanceDate'])
        : null;
    attendanceStatus = json['attendanceStatus'];
    createdAt =
        json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null;
    updatedAt =
        json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "AttendanceDate": attendanceDate?.toIso8601String(),
      "attendanceStatus": attendanceStatus,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
    };
  }
}
