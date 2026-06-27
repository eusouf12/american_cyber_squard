class TeacherClassDistributionResponse {
  final bool? success;
  final String? message;
  final List<TeacherClassDistribution>? data;

  TeacherClassDistributionResponse({
    this.success,
    this.message,
    this.data,
  });

  factory TeacherClassDistributionResponse.fromJson(
      Map<String, dynamic> json) {
    return TeacherClassDistributionResponse(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List?)
          ?.map((e) => TeacherClassDistribution.fromJson(e))
          .toList(),
    );
  }
}

class TeacherClassDistribution {
  final String? id;
  final String? classLevel;
  final String? subscriptionId;
  final String? assignableSubject;

  TeacherClassDistribution({
    this.id,
    this.classLevel,
    this.subscriptionId,
    this.assignableSubject,
  });

  factory TeacherClassDistribution.fromJson(
      Map<String, dynamic> json) {
    return TeacherClassDistribution(
      id: json['id'],
      classLevel: json['classLevel'],
      subscriptionId: json['subscriptionId'],
      assignableSubject: json['assignableSubject'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "classLevel": classLevel,
      "subscriptionId": subscriptionId,
      "assignableSubject": assignableSubject,
    };
  }
}