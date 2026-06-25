class ClassRecordingResponse {
  final bool? success;
  final String? message;
  final ClassRecordingData? data;

  ClassRecordingResponse({
    this.success,
    this.message,
    this.data,
  });

  factory ClassRecordingResponse.fromJson(Map<String, dynamic> json) {
    return ClassRecordingResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? ClassRecordingData.fromJson(json['data'])
          : null,
    );
  }
}

class ClassRecordingData {
  final bool? success;
  final String? message;
  final ClassRecordingMeta? meta;
  final List<ClassRecordingModel>? data;

  ClassRecordingData({
    this.success,
    this.message,
    this.meta,
    this.data,
  });

  factory ClassRecordingData.fromJson(Map<String, dynamic> json) {
    return ClassRecordingData(
      success: json['success'],
      message: json['message'],
      meta: json['meta'] != null
          ? ClassRecordingMeta.fromJson(json['meta'])
          : null,
      data: (json['data'] as List?)
          ?.map((e) => ClassRecordingModel.fromJson(e))
          .toList(),
    );
  }
}

class ClassRecordingMeta {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  ClassRecordingMeta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  factory ClassRecordingMeta.fromJson(Map<String, dynamic> json) {
    return ClassRecordingMeta(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPage: json['totalPage'],
    );
  }
}

class ClassRecordingModel {
  final String? id;
  final String? recordingUrl;
  final String? createdAt;
  final String? updatedAt;
  final RecordingClassDistribution? classDistribution;

  ClassRecordingModel({
    this.id,
    this.recordingUrl,
    this.createdAt,
    this.updatedAt,
    this.classDistribution,
  });

  factory ClassRecordingModel.fromJson(Map<String, dynamic> json) {
    return ClassRecordingModel(
      id: json['id'],
      recordingUrl: json['recordingUrl'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      classDistribution: json['classDistribution'] != null
          ? RecordingClassDistribution.fromJson(json['classDistribution'])
          : null,
    );
  }
}

class RecordingClassDistribution {
  final String? id;
  final String? classLevel;
  final String? assignableSubject;
  final String? day;
  final String? time;

  RecordingClassDistribution({
    this.id,
    this.classLevel,
    this.assignableSubject,
    this.day,
    this.time,
  });

  factory RecordingClassDistribution.fromJson(Map<String, dynamic> json) {
    return RecordingClassDistribution(
      id: json['id'],
      classLevel: json['classLevel'],
      assignableSubject: json['assignableSubject'],
      day: json['day'],
      time: json['time'],
    );
  }
}