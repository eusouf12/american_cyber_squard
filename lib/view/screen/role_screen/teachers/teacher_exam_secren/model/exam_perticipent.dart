class ExamParticipantResponse {
  bool? success;
  String? message;
  ExamParticipantData? data;

  ExamParticipantResponse({
    this.success,
    this.message,
    this.data,
  });

  factory ExamParticipantResponse.fromJson(Map<String, dynamic> json) {
    return ExamParticipantResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? ExamParticipantData.fromJson(json['data'])
          : null,
    );
  }
}

class ExamParticipantData {
  bool? success;
  ExamParticipantMeta? meta;
  List<ExamParticipant>? participants;

  ExamParticipantData({
    this.success,
    this.meta,
    this.participants,
  });

  factory ExamParticipantData.fromJson(Map<String, dynamic> json) {
    return ExamParticipantData(
      success: json['success'],
      meta: json['meta'] != null
          ? ExamParticipantMeta.fromJson(json['meta'])
          : null,
      participants: (json['data'] as List<dynamic>? ?? [])
          .map((e) => ExamParticipant.fromJson(e))
          .toList(),
    );
  }
}

class ExamParticipantMeta {
  int? total;
  int? page;
  int? limit;
  int? totalPages;

  ExamParticipantMeta({
    this.total,
    this.page,
    this.limit,
    this.totalPages,
  });

  factory ExamParticipantMeta.fromJson(Map<String, dynamic> json) {
    return ExamParticipantMeta(
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
    );
  }
}

class ExamParticipant {
  String? id;
  String? name;
  String? studentId;
  String? createdAt;

  ExamParticipant({
    this.id,
    this.name,
    this.studentId,
    this.createdAt,
  });

  factory ExamParticipant.fromJson(Map<String, dynamic> json) {
    return ExamParticipant(
      id: json['id'],
      name: json['name'],
      studentId: json['studentId'],
      createdAt: json['createdAt'],
    );
  }
}
