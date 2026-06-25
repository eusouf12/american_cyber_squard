class AssignmentResponse {
  final bool? success;
  final String? message;
  final AssignmentData? data;

  AssignmentResponse({
    this.success,
    this.message,
    this.data,
  });

  factory AssignmentResponse.fromJson(Map<String, dynamic> json) {
    return AssignmentResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? AssignmentData.fromJson(json['data'])
          : null,
    );
  }
}

class AssignmentData {
  final AssignmentMeta? meta;
  final List<AssignmentModel>? data;

  AssignmentData({
    this.meta,
    this.data,
  });

  factory AssignmentData.fromJson(Map<String, dynamic> json) {
    return AssignmentData(
      meta: json['meta'] != null
          ? AssignmentMeta.fromJson(json['meta'])
          : null,
      data: (json['data'] as List?)
          ?.map((e) => AssignmentModel.fromJson(e))
          .toList(),
    );
  }
}

class AssignmentMeta {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  AssignmentMeta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  factory AssignmentMeta.fromJson(Map<String, dynamic> json) {
    return AssignmentMeta(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPage: json['totalPage'],
    );
  }
}

class AssignmentModel {
  final String? id;
  final String? assignmentTitle;
  final String? assignmentType;
  final String? assignmentDueDate;
  final String? description;
  final List<String>? attachmentFiles;
  final bool? assessmentAvailable;
  final String? createdAt;
  final String? updatedAt;
  final AssignmentClassDistribution? classDistributions;

  AssignmentModel({
    this.id,
    this.assignmentTitle,
    this.assignmentType,
    this.assignmentDueDate,
    this.description,
    this.attachmentFiles,
    this.assessmentAvailable,
    this.createdAt,
    this.updatedAt,
    this.classDistributions,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      id: json['id'],
      assignmentTitle: json['assignmentTitle'],
      assignmentType: json['assignmentType'],
      assignmentDueDate: json['assignmentDueDate'],
      description: json['description'],
      attachmentFiles:
          (json['attachmentFiles'] as List?)?.map((e) => e.toString()).toList(),
      assessmentAvailable: json['assessmentAvailable'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      classDistributions: json['classDistributions'] != null
          ? AssignmentClassDistribution.fromJson(
              json['classDistributions'],
            )
          : null,
    );
  }
}

class AssignmentClassDistribution {
  final String? id;
  final String? classLevel;

  AssignmentClassDistribution({
    this.id,
    this.classLevel,
  });

  factory AssignmentClassDistribution.fromJson(
      Map<String, dynamic> json) {
    return AssignmentClassDistribution(
      id: json['id'],
      classLevel: json['classLevel'],
    );
  }
}