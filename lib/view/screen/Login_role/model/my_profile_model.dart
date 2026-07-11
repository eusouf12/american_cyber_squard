class TeacherProfileResponse {
  final bool success;
  final String message;
  final TeacherProfileData data;

  TeacherProfileResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory TeacherProfileResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return TeacherProfileResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: TeacherProfileData.fromJson(
        json['data'] ?? {},
      ),
    );
  }
}

class TeacherProfileData {
  final String teacherName;
  final String email;
  final String phoneNumber;
  final String branchName;
  final List<String> subject;
  final List<String> assignClass;
  final String teacherId;
  final String address;
  final bool isVerified;
  final String? photo;
  final String status;
  final DateTime createdAt;
  final String guardianName;

  TeacherProfileData({
    required this.teacherName,
    required this.email,
    required this.phoneNumber,
    required this.branchName,
    required this.subject,
    required this.assignClass,
    required this.teacherId,
    required this.address,
    required this.isVerified,
    required this.photo,
    required this.status,
    required this.createdAt,
    required this.guardianName,
  });

  factory TeacherProfileData.fromJson(
    Map<String, dynamic> json,
  ) {
    return TeacherProfileData(
      teacherName: json['teacherName'] ?? json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? json['guardianPhone'] ?? '',
      branchName: json['branchName'] ?? '',
      subject: List<String>.from(
        json['subject'] ?? [],
      ),
      assignClass: List<String>.from(
        json['assignClass'] ?? (json['className'] != null ? [json['className']] : []),
      ),
      teacherId: json['teacherId'] ?? json['id'] ?? '',
      address: json['address'] ?? '',
      isVerified: json['isVerified'] ?? false,
      photo: json['photo'],
      status: json['status'] ?? '',
      createdAt: DateTime.tryParse(
            json['createdAt'] ?? '',
          ) ??
          DateTime.now(),
      guardianName: json['guardianName'] ?? '',
    );
  }
}