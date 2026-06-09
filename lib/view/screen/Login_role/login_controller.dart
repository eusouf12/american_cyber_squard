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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool loginLoading = false.obs;
  RxString selectedRole = ''.obs;

  void setRole(String role) {
    selectedRole.value = role;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
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
      }
        
     }catch(e){
      debugPrint("Login error: $e");
      showCustomSnackBar("Something went wrong", isError: true);
     }finally{
      loginLoading.value = false;
    }
  }
}