class RoutineResponse {
  final bool? success;
  final String? message;
  final RoutineData? data;

  RoutineResponse({
    this.success,
    this.message,
    this.data,
  });

  factory RoutineResponse.fromJson(Map<String, dynamic> json) {
    return RoutineResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? RoutineData.fromJson(json['data'])
          : null,
    );
  }
}

class RoutineData {
  final RoutineMeta? meta;
  final List<RoutineModel>? data;

  RoutineData({
    this.meta,
    this.data,
  });

  factory RoutineData.fromJson(Map<String, dynamic> json) {
    return RoutineData(
      meta: json['meta'] != null
          ? RoutineMeta.fromJson(json['meta'])
          : null,
      data: (json['data'] as List?)
          ?.map((e) => RoutineModel.fromJson(e))
          .toList(),
    );
  }
}

class RoutineMeta {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  RoutineMeta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  factory RoutineMeta.fromJson(Map<String, dynamic> json) {
    return RoutineMeta(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPage: json['totalPage'],
    );
  }
}

class RoutineModel {
  final String? id;
  final String? classLevel;
  final int? capacity;
  final String? roomNumber;
  final String? assignableSubject;
  final String? day;
  final String? time;
  final bool? isOnline;
  final String? createdAt;
  final String? updatedAt;

  RoutineModel({
    this.id,
    this.classLevel,
    this.capacity,
    this.roomNumber,
    this.assignableSubject,
    this.day,
    this.time,
    this.isOnline,
    this.createdAt,
    this.updatedAt,
  });

  factory RoutineModel.fromJson(Map<String, dynamic> json) {
    return RoutineModel(
      id: json['id'],
      classLevel: json['classLevel'],
      capacity: json['capacity'],
      roomNumber: json['roomNumber'],
      assignableSubject: json['assignableSubject'],
      day: json['day'],
      time: json['time'],
      isOnline: json['isOnline'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}