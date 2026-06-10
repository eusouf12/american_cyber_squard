class ApiUrl {
  static const String baseUrl = "https://trained-contributed-developments-tourist.trycloudflare.com";
  static const String imageUrl = baseUrl;
  static String socketUrl = baseUrl;
  static String mapKey = "AIzaSyBuSZJklSc1j0D4kqhkJcmyArcZbWujbXQ";

  ///========================= Authentication =========================
  static const String signIn = "/api/v1/auth/login";
  static const String newPassword = "/api/v1/users/change_password";
  static const String myProfile = "/api/v1/auth/my-profile";
  static const String updateProfile = "/api/v1/auth/update_my_profile";


  static const String signUp = "/api/v1/user/create_user";
  static const String refreshToken = "/api/v1/auth/refresh-token";
  static const String verificationOtp = "/api/v1/user/user_verification";
  static const String verificationOtpForgetPass = "/api/v1/user/verification_forgot_user";
  
  static const String forgotPassword = "/api/v1/user/forgot_password";
  
  
  
  static const String termsCondition = "/api/v1/setting/find_by_terms_conditions";
  static const String privacyPolicy = "/api/v1/setting/find_by_privacy_policys";
  static const String changePassword = "/api/v1/user/change_password";
  static const String googleAuth = "/api/v1/user/google_auth";
  static  String  deleteAccount({required String userId})=> "/api/v1/auth/delete_account/$userId";



 
 
  static String getAllPosts({required int page}) =>  "/api/v1/followup/find_by_my_event_social_feed?page=$page&limit=10";
  

}