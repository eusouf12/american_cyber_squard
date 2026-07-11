import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:america_ayber_squad/service/api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../core/app_routes/app_routes.dart';
import '../../../helper/shared_prefe/shared_prefe.dart';
import '../../../service/api_url.dart';
import '../../../utils/ToastMsg/toast_message.dart' show showCustomSnackBar;
import '../../../utils/app_const/app_const.dart';
import 'model/my_profile_model.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _checkTokenAndGetProfile();
  }

  Future<void> _checkTokenAndGetProfile() async {
    String token = await SharePrefsHelper.getString(AppConstants.bearerToken);
    if (token.isNotEmpty) {
      getMyProfile();
    }
  }
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
        Map<String, dynamic> jsonResponse = _parseResponseBody(response.body);
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
        // Profile data pre-load
        getMyProfile();
      } else {
        // Parse server error message (e.g. 404 "User not found")
        try {
          Map<String, dynamic> errorResponse = _parseResponseBody(response.body);
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

  // ======== Forgot Password =================
  final forgotPasswordEmailController = TextEditingController();
  RxBool forgotPasswordLoading = false.obs;

  Future<void> forgotPassword() async {
    final email = forgotPasswordEmailController.text.trim();
    if (email.isEmpty) {
      showCustomSnackBar("Email is required.", isError: true);
      return;
    }

    forgotPasswordLoading.value = true;
    Map<String, String> body = {
      'email': email,
    };

    try {
      var response = await ApiClient.postData(ApiUrl.forgotPassword, body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> jsonResponse = _parseResponseBody(response.body);
        showCustomSnackBar(
          jsonResponse['message'] ?? "OTP sent to your email",
          isError: false,
        );
        Get.toNamed(AppRoutes.verificationOtpForgetPass); // Navigate to OTP screen
      } else {
        try {
          Map<String, dynamic> errorResponse = _parseResponseBody(response.body);
          final String message = errorResponse['message']?.toString() ?? 'Request failed. Please try again.';
          showCustomSnackBar(message, isError: true);
        } catch (_) {
          showCustomSnackBar('Request failed. Please try again.', isError: true);
        }
      }
    } catch (e) {
      debugPrint("Forgot password error: $e");
      showCustomSnackBar("Something went wrong", isError: true);
    } finally {
      forgotPasswordLoading.value = false;
    }
  }

  // ======== Verify OTP Forgot Password =================
  final otpForgetPassController = TextEditingController();
  RxBool verifyOtpLoading = false.obs;

  Future<void> verifyOtpForgetPass() async {
    final otp = otpForgetPassController.text.trim();
    
    if (otp.isEmpty) {
      showCustomSnackBar("OTP is required.", isError: true);
      return;
    }

    verifyOtpLoading.value = true;
    Map<String, dynamic> body = {
      'verificationCode': int.tryParse(otp) ?? 0,
    };

    try {
      var response = await ApiClient.postData(ApiUrl.verificationOtpForgetPass, jsonEncode(body));

      verifyOtpLoading.value = false;
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> jsonResponse = _parseResponseBody(response.body);

        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Account verified successfully!",
          isError: false,
        );

        otpForgetPassController.clear();

        if (jsonResponse['data'] != null) {
          String accessToken = '';
          if (jsonResponse['data'] is String) {
            accessToken = jsonResponse['data'];
          } else if (jsonResponse['data'] is Map && jsonResponse['data']['accessToken'] != null) {
            accessToken = jsonResponse['data']['accessToken'].toString();
          }

          if (accessToken.isNotEmpty) {
            // Save access token
            await SharePrefsHelper.setString(AppConstants.bearerToken, accessToken);

            // Decode JWT to get id & role
            Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
            String userId = decodedToken['id']?.toString() ?? "";
            String userRole = decodedToken['role']?.toString() ?? "";

            // Save user id & role
            await SharePrefsHelper.setString(AppConstants.userId, userId);
            await SharePrefsHelper.setString(AppConstants.role, userRole);
          }
        }

        Get.toNamed(AppRoutes.resetPasswordScreen);
      } else {
        try {
          Map<String, dynamic> errorResponse = _parseResponseBody(response.body);
          final String message = errorResponse['message']?.toString() ?? 'Verification failed';
          showCustomSnackBar(message, isError: true);
        } catch (_) {
          showCustomSnackBar('Verification failed', isError: true);
        }
      }
    } catch (e) {
      verifyOtpLoading.value = false;
      refresh();
      debugPrint("Verify OTP error: $e");
      showCustomSnackBar("Something went wrong", isError: true);
    }
  }

  // ======== Reset Password =================
  final resetPasswordController = TextEditingController();
  final confirmResetPasswordController = TextEditingController();
  RxBool resetPasswordLoading = false.obs;

  Future<void> resetPassword() async {
    final resetPassword = resetPasswordController.text.trim();
    final confirmPassword = confirmResetPasswordController.text.trim();

    if (resetPassword.isEmpty || confirmPassword.isEmpty) {
      showCustomSnackBar("All fields are required.", isError: true);
      return;
    }
    if (resetPassword != confirmPassword) {
      showCustomSnackBar("Passwords do not match.", isError: true);
      return;
    }

    resetPasswordLoading.value = true;
    refresh();

    String userId = await SharePrefsHelper.getString(AppConstants.userId);
    debugPrint("RESET PASS +++++++++++++========$userId");

    Map<String, dynamic> body = {
      'userId': userId,
      'password': resetPassword,
    };

    try {
      var response = await ApiClient.postData(ApiUrl.resetPassword, jsonEncode(body));

      resetPasswordLoading.value = false;
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> jsonResponse = _parseResponseBody(response.body);
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Password reset successfully. Please login.", isError: false);
        
        Get.offAllNamed(AppRoutes.loginScreen);
      } else {
        try {
          Map<String, dynamic> errorResponse = _parseResponseBody(response.body);
          final String message = errorResponse['message']?.toString() ?? 'Password reset failed';
          showCustomSnackBar(message, isError: true);
        } catch (_) {
          showCustomSnackBar('Password reset failed', isError: true);
        }
      }
    } catch (e) {
      resetPasswordLoading.value = false;
      refresh();
      debugPrint("Reset password error: $e");
      showCustomSnackBar("Something went wrong", isError: true);
    }
  }

  //  ======== passwordChange Controller =================
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  RxBool changePasswordLoading = false.obs;

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

      Map<String, dynamic> jsonResponse = _parseResponseBody(response.body);

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

  // ======== Update Profile Controller =================
  final editNameController  = TextEditingController();
  final editAddressController = TextEditingController();
  final editPhoneController   = TextEditingController();
  final editEmailController   = TextEditingController();
  final RxBool updateProfileLoading = false.obs;

  Rxn<File> profileImage = Rxn<File>();

  Future<void> pickImage() async {
    PermissionStatus status;
    if (Platform.isAndroid) {
      status = await Permission.photos.request();
      if (status.isDenied || status.isPermanentlyDenied) {
        status = await Permission.storage.request();
      }
    } else {
      status = await Permission.photos.request();
    }

    if (status.isDenied || status.isPermanentlyDenied) {
      showCustomSnackBar("Storage/Photos permission is required to select an image.", isError: true);
      await openAppSettings();
      return;
    }

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage.value = File(image.path);
    }
  }

  Future<void> updateProfile() async {
    final name    = editNameController.text.trim();
    final address = editAddressController.text.trim();
    final phone   = editPhoneController.text.trim();

    if (name.isEmpty || address.isEmpty || phone.isEmpty) {
      showCustomSnackBar("All fields are required.", isError: true);
      return;
    }

    updateProfileLoading.value = true;

    final Map<String, String> body = {
      "name": name,
      "address"    : address,
      "phoneNumber": phone,
    };

    try {
      Response response;
      if (profileImage.value != null) {
        response = await ApiClient.patchMultipartData(
          ApiUrl.updateProfile,
          body,
          multipartBody: [MultipartBody('profileImage', profileImage.value!)],
        );
      } else {
        response = await ApiClient.patchData(
          ApiUrl.updateProfile,
          body,
        );
      }

      final Map<String, dynamic> jsonResponse = _parseResponseBody(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? 'Profile updated successfully!',
          isError: false,
        );
        // Refresh profile data so home screen appbar updates
        await getMyProfile();
        Navigator.pop(Get.context!);
      } else {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? 'Profile update failed.',
          isError: true,
        );
      }
    } catch (e) {
      debugPrint('updateProfile Error: $e');
      showCustomSnackBar('An error occurred. Please try again.', isError: true);
    } finally {
      updateProfileLoading.value = false;
    }
  }
// =============== Get My Profile =======================================
  Rxn<TeacherProfileData> myProfileData = Rxn<TeacherProfileData>();
  final isMyProfileLoading = false.obs;
  final rxMyProfileStatus = Status.loading.obs;

  void setMyProfileStatus(Status status) => rxMyProfileStatus.value = status;

  Future<void> getMyProfile() async {
    isMyProfileLoading.value = true;
    setMyProfileStatus(Status.loading);

    try {
      final response = await ApiClient.getData(ApiUrl.myProfile);

      final Map<String, dynamic> jsonResponse = _parseResponseBody(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final TeacherProfileResponse model =
            TeacherProfileResponse.fromJson(jsonResponse);

        myProfileData.value = model.data;
        
        // Populate edit controllers
        if (!isClosed) {
          editNameController.text = model.data.teacherName;
          editAddressController.text = model.data.address;
            editPhoneController.text = model.data.phoneNumber;
          editEmailController.text = model.data.email;
        }

        setMyProfileStatus(Status.completed);
      } else {
        setMyProfileStatus(Status.error);
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? 'Failed to load profile',
          isError: true,
        );
      }
    } catch (e) {
      setMyProfileStatus(Status.error);
      debugPrint('getMyProfile Error: $e');
      showCustomSnackBar('Error: ${e.toString()}', isError: true);
    } finally {
      isMyProfileLoading.value = false;
    }
  }

}

Map<String, dynamic> _parseResponseBody(dynamic body) {
  if (body == null) return {};
  if (body is Map) return Map<String, dynamic>.from(body);
  if (body is String && body.isNotEmpty) {
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }
    } catch (_) {}
  }
  return {};
}