class ApiUrl {
  static const String baseUrl =
      "https://operations-constitute-largest-ann.trycloudflare.com";
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
      "/api/v1/exam_announcement/find_my_announcement_exam_list?page=$page&limit=10&classLevel=${className ?? ''}&assignableSubject=${subject ?? ''}";
  static const String createExam =
      "/api/v1/exam_announcement/create_exam_announcement";
  static String updateExam({required String examId}) =>
      "/api/v1/exam_announcement/update_announcement_exam/$examId";
  static String deleteExam({required String examId}) =>
      "/api/v1/exam_announcement/delete_announcement_exam/$examId";
  static String getExamParticipant({required String examId}) =>
      "/api/v1/exam_announcement/find_by_participant_student_list/$examId";
  static const String submitExamGrade =
      "/api/v1/exam_announcement/recorded_exam_grades";
  static const String showExamGrade =
      "/api/v1/exam_announcement/find_by_exam_grades_specific_teacher";
  static String updateExamGrade({required String studentId}) =>
      "/api/v1/exam_announcement/update_exam_grades_specific_teacher/$studentId";
  static const String onlineClass =
      "/api/v1/teacher/online_class_recorded_of_teacher";
  static const String teacherSupportMessage =
      "/api/v1/support/send_support_message";
//====assignment===
  static const String createAssignment =
      "/api/v1/assignments/create_assignment";
  static String getTeacherAssignment(
          {required String status, String? classLevel}) =>
      "/api/v1/assignments/find_by_specific_teacher_assignment?status=$status${classLevel != null ? '&classLevel=$classLevel' : ''}";
  static String deleteAssignment({required String assignmentId}) =>
      "/api/v1/assignments/delete_class_assignment/$assignmentId";
  static String updateAssignment({required String assignmentId}) =>
      "/api/v1/assignments/update_teacher_assignment/$assignmentId";
  static String specificAssignment({required String assignmentId}) =>
      "/api/v1/assignments/find_by_specific_assignment/$assignmentId";
  //====materials===
  static const String createMaterials =
      "/api/v1/assignments/create_class_materials";
  static String getTeacherMaterials({required String id}) =>
      "/api/v1/assignments/find_by_specific_teacher_class_material/$id";
  static String deleteMaterials({required String materialId}) =>
      "/api/v1/assignments/delete_class_materials/$materialId";
  static String updateMaterials({required String materialId}) =>
      "/api/v1/assignments/update_specific_class_material/$materialId";
  static String specificMaterials({required String materialId}) =>
      "/api/v1/assignments/find_by_specific_class_material/$materialId";

//=========================== Student =================================================

  static String getStudentSchedule({required int page}) =>
      "/api/v1/students/find_my_all_class_list?page=$page&limit=10";
  static String getStudentAssignment(
      {required int page, String? classLevel, String? subject}) {
    String url =
        "/api/v1/students/find_my_class_assignment?page=$page&limit=10";
    if (classLevel != null && classLevel.isNotEmpty) {
      url += "&classLevel=${Uri.encodeComponent(classLevel)}";
    }
    if (subject != null && subject.isNotEmpty) {
      url += "&assignableSubject=${Uri.encodeComponent(subject)}";
    }
    return url;
  }

//================================== ===============================================
  static const String googleAuth = "/api/v1/user/google_auth";
  static String deleteAccount({required String userId}) =>
      "/api/v1/auth/delete_account/$userId";
}
