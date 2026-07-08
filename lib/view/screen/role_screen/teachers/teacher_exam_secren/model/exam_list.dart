class ExamListResponse {
  bool? success;
  String? message;
  ExamListData? data;

  ExamListResponse({
    this.success,
    this.message,
    this.data,
  });

  factory ExamListResponse.fromJson(Map<String, dynamic> json) {
    return ExamListResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? ExamListData.fromJson(json['data']) : null,
    );
  }
}

class ExamListData {
  bool? success;
  ExamListMeta? meta;
  ExamStatusCount? statusCount;
  List<ExamList>? examList;

  ExamListData({
    this.success,
    this.meta,
    this.statusCount,
    this.examList,
  });

  factory ExamListData.fromJson(Map<String, dynamic> json) {
    return ExamListData(
      success: json['success'],
      meta: json['meta'] != null ? ExamListMeta.fromJson(json['meta']) : null,
      statusCount: json['statusCount'] != null
          ? ExamStatusCount.fromJson(json['statusCount'])
          : null,
      examList: (json['data'] as List<dynamic>? ?? [])
          .map((e) => ExamList.fromJson(e))
          .toList(),
    );
  }
}

class ExamListMeta {
  int? total;
  int? page;
  int? limit;
  int? totalPages;

  ExamListMeta({
    this.total,
    this.page,
    this.limit,
    this.totalPages,
  });

  factory ExamListMeta.fromJson(Map<String, dynamic> json) {
    return ExamListMeta(
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
    );
  }
}

class ExamStatusCount {
  int? completed;
  int? upcoming;
  int? pending;

  ExamStatusCount({
    this.completed,
    this.upcoming,
    this.pending,
  });

  factory ExamStatusCount.fromJson(Map<String, dynamic> json) {
    return ExamStatusCount(
      completed: json['completed'],
      upcoming: json['upcoming'],
      pending: json['pending'],
    );
  }
}

class ExamList {
  String? id;
  String? examName;
  String? topic;
  String? totalMarks;
  String? duration;
  String? instruction;
  String? examDate;
  String? createdAt;
  bool? isCompleted;
  ExamListClassDistribution? classDistribution;

  ExamList({
    this.id,
    this.examName,
    this.topic,
    this.totalMarks,
    this.duration,
    this.instruction,
    this.examDate,
    this.createdAt,
    this.isCompleted,
    this.classDistribution,
  });

  factory ExamList.fromJson(Map<String, dynamic> json) {
    return ExamList(
      id: json['id'],
      examName: json['examName'],
      topic: json['topic'],
      totalMarks: json['totalMarks'],
      duration: json['duration'],
      instruction: json['instruction'],
      examDate: json['examDate'],
      createdAt: json['createdAt'],
      isCompleted: json['isCompleted'],
      classDistribution: json['classDistribution'] != null
          ? ExamListClassDistribution.fromJson(
              json['classDistribution'],
            )
          : null,
    );
  }
}

class ExamListClassDistribution {
  String? id;
  String? classLevel;
  String? assignableSubject;
  String? teacherId;

  ExamListClassDistribution({
    this.id,
    this.classLevel,
    this.assignableSubject,
    this.teacherId,
  });

  factory ExamListClassDistribution.fromJson(Map<String, dynamic> json) {
    return ExamListClassDistribution(
      id: json['id'],
      classLevel: json['classLevel'],
      assignableSubject: json['assignableSubject'],
      teacherId: json['teacherId'],
    );
  }
}
