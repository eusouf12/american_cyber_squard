import 'dart:convert';
import 'package:america_ayber_squad/service/api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../core/app_routes/app_routes.dart';
import '../../../helper/shared_prefe/shared_prefe.dart';
import '../../../service/api_url.dart';
import '../../../utils/ToastMsg/toast_message.dart' show showCustomSnackBar;
import '../../../utils/app_const/app_const.dart';

class LoginController extends GetxController {
  // ======== Login Controller =================
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool loginLoading = false.obs;
  RxString selectedRole = ''.obs;
  void setRole(String role) {
    selectedRole.value = role;
  }

   Future<void> loginUser() async {
    loginLoading.value = true;
    Map<String, String> body = {
      'email': emailController.text.trim(),
      'password': passwordController.text,
      'role': selectedRole.value,
    };

    try {
      var response = await ApiClient.postData(ApiUrl.signIn, jsonEncode(body));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse =response.body is String ? jsonDecode(response.body) : response.body;
        showCustomSnackBar(
          jsonResponse['message'] ?? "Login successful",
          isError: false,
        );

        // Access Token
        var dataMap = jsonResponse['data'] as Map<String, dynamic>;
        String accessToken = dataMap['accessToken'].toString();
        debugPrint("Bearer Token: $accessToken");
        await SharePrefsHelper.setString(AppConstants.bearerToken, accessToken);

        // Decode token
        Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
        String userId = decodedToken['id'].toString();
        String userRole = decodedToken['role'].toString();

        await SharePrefsHelper.setString(AppConstants.userId, userId);
        String id = await SharePrefsHelper.getString(AppConstants.userId);
        debugPrint(
          "Debug Id===========================================================$id ==$userRole",
        );
        await SharePrefsHelper.setString(AppConstants.role, userRole);
        debugPrint("Navigating with Role: $userRole ");
        String roleLower = userRole.toLowerCase();
         debugPrint("roleLower with Role: $roleLower ");
        if (roleLower == "teacher") {
          Get.offAllNamed(AppRoutes.teachersHomeScreen);
        } 
        else if (roleLower == "student") {
          Get.offAllNamed(AppRoutes.studentHomeScreen);
        } 
        else if (roleLower == "parent") {
          Get.offAllNamed(AppRoutes.parentsHomeScreen);
        }
        else {
          Get.offAllNamed(AppRoutes.schoolNurseHomeScreen);
        }
      } else {
        // Parse server error message (e.g. 404 "User not found")
        try {
          Map<String, dynamic> errorResponse =
              response.body is String ? jsonDecode(response.body) : response.body;
          final String message =
              errorResponse['message']?.toString() ?? 'Login failed. Please try again.';
          showCustomSnackBar(message, isError: true);
        } catch (_) {
          showCustomSnackBar('Login failed. Please try again.', isError: true);
        }
      }
        
     }catch(e){
      debugPrint("Login error: $e");
      showCustomSnackBar("Something went wrong", isError: true);
     }finally{
      loginLoading.value = false;
    }
  }


  //  ======== passwordChange Controller =================
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  RxBool changePasswordLoading = false.obs;



 
 // ── Change / Update Password ──────────────────────────────────────────
  Future<void> changePassword() async {

    if (oldPasswordController.text.trim().isEmpty || newPasswordController.text.trim().isEmpty || confirmPasswordController.text.trim().isEmpty) {
      showCustomSnackBar("All fields are required.", isError: true);
      return;
    }
    if (newPasswordController.text.trim() != confirmPasswordController.text.trim()) {
      showCustomSnackBar(
        "New password and confirm password do not match.",
        isError: true,
      );
      return;
    }

    changePasswordLoading.value = true;

    final Map<String, dynamic> body = {
      "oldpassword": oldPasswordController.text.trim(),
      "newpassword": newPasswordController.text.trim(),
    };

    try {
      var response = await ApiClient.patchData( ApiUrl.newPassword,jsonEncode(body));

      Map<String, dynamic> jsonResponse =
          response.body is String  ? jsonDecode(response.body) : response.body as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Password updated successfully!", isError: false, );
        oldPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        Navigator.pop(Get.context!);
      } else {
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Password update failed.",isError: true,);
      }
    } catch (e) {
      debugPrint("ChangePassword Error: $e");
      showCustomSnackBar("An error occurred. Please try again.", isError: true);
    } finally {
      changePasswordLoading.value = false;
    }
  }

   @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

}