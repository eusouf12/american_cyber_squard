class ApiUrl {
  static const String baseUrl =
      "https://travesti-helena-clothing-rip.trycloudflare.com";
  static const String imageUrl = baseUrl;
  static String socketUrl = baseUrl;

  ///========================= Authentication =========================
  static const String signIn = "/api/v1/auth/login";
  static const String newPassword = "/api/v1/users/change_password";
  static const String myProfile = "/api/v1/auth/my-profile";
  static const String updateProfile = "/api/v1/auth/update_my_profile";
  static const String forgotPassword = "/api/v1/users/forgot_password";
  static const String verificationOtpForgetPass =
      "/api/v1/users/verification_forgot_user";
  static const String resetPassword = "/api/v1/users/reset_password";

  ///========================= Teacher =========================
  static String getAllTeacherSchedule({required int page}) =>
      "/api/v1/teacher/find_by_specific_class_listOf_teacher?page=$page&limit=10";
  static String getAssignmentHomework({required int page}) =>
      "/api/v1/assignments/find_by_specific_teacher_assignment?page=$page&limit=10";
  static String getAnnouncement({required int page}) =>
      "/api/v1/announcement/find_by_announcement?page=$page&limit=10";
  static String getClassRecording({required int page, String? searchTerm}) =>
      "/api/v1/teacher/find_by_specific_student_class_recording_of_teacher?page=$page&limit=10${searchTerm != null && searchTerm.isNotEmpty ? '&searchTerm=$searchTerm' : ''}";
  static String getteacherClassDistribute() =>
      "/api/v1/class_distribution/find_my_all_distributed_class";
  static String postClassRecording() =>
      "/api/v1/teacher/store_class_recording_link_of_teacher";
  static String getTeacherUnderStudents(
      {required int page, String? className, String? name}) {
    String url =
        "/api/v1/teacher/find_by_specific_student_listOf_teacher?page=$page&limit=10";
    if (className != null && className.isNotEmpty && className != "All") {
      url += "&className=$className";
    }
    if (name != null && name.isNotEmpty) {
      url += "&name=$name";
    }
    return url;
  }

  static String getAllStudentsDetailsUnderTeacher(
          {required String studentId}) =>
      "/api/v1/class_distribution/find_by_student_details/$studentId";
  static String getTeacherStudentsAttenddenceSheet(
      {required int page, required String classId, String? date}) {
    String url =
        "/api/v1/teacher/find_by_specific_student_attendance_of_teacher/$classId?page=$page&limit=10";
    if (date != null && date.isNotEmpty) {
      url += "&attendanceDate=$date";
    }
    return url;
  }

  static const String updateTeacherStudentAttendanc =
      "/api/v1/teacher/update_student_attendance_of_teacher";
  static String getExamlistTeacher(
          {required int page, String? className, String? subject}) =>
      "/api/v1/exam_announcement/find_my_announcement_exam_list?page=$page&limit=10&classLevel=$className&assignableSubject=$subject";
  static const String createExam =
      "/api/v1/exam_announcement/create_exam_announcement";
  static String updateExam({required String examId}) =>
      "/api/v1/exam_announcement/update_announcement_exam/$examId";

//============================================================================
  static const String termsCondition =
      "/api/v1/setting/find_by_terms_conditions";
  static const String privacyPolicy = "/api/v1/setting/find_by_privacy_policys";
  static const String googleAuth = "/api/v1/user/google_auth";
  static String deleteAccount({required String userId}) =>
      "/api/v1/auth/delete_account/$userId";
  static String getAllPosts({required int page}) =>
      "/api/v1/followup/find_by_my_event_social_feed?page=$page&limit=10";
}
