class ApiUrl {
  static const String baseUrl = "https://watching-claimed-visible-third.trycloudflare.com";
  static const String imageUrl = baseUrl;
  static String socketUrl = baseUrl;

  ///========================= Authentication =========================
  static const String signIn = "/api/v1/auth/login";
  static const String newPassword = "/api/v1/users/change_password";
  static const String myProfile = "/api/v1/auth/my-profile";
  static const String updateProfile = "/api/v1/auth/update_my_profile";
 static const String forgotPassword = "/api/v1/users/forgot_password";
  static const String verificationOtpForgetPass = "/api/v1/users/verification_forgot_user";
  static const String resetPassword = "/api/v1/users/reset_password";


 ///========================= Teacher =========================
  static String getAllTeacherSchedule({required int page}) =>  "/api/v1/teacher/find_by_specific_class_listOf_teacher?page=$page&limit=10";
  static String getAssignmentHomework({required int page}) =>  "/api/v1/assignments/find_by_specific_teacher_assignment?page=$page&limit=10";
  static String getAnnouncement({required int page}) =>  "/api/v1/announcement/find_by_announcement?page=$page&limit=10";
  static String getClassRecording({required int page}) =>  "/api/v1/teacher/find_by_specific_student_class_recording_of_teacher?page=$page&limit=10";
 
  


  static const String termsCondition = "/api/v1/setting/find_by_terms_conditions";
  static const String privacyPolicy = "/api/v1/setting/find_by_privacy_policys";
  static const String googleAuth = "/api/v1/user/google_auth";
  static  String  deleteAccount({required String userId})=> "/api/v1/auth/delete_account/$userId";



 
 
  static String getAllPosts({required int page}) =>  "/api/v1/followup/find_by_my_event_social_feed?page=$page&limit=10";
  

}