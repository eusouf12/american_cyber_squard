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
        // Profile data pre-load
        getMyProfile();
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

      final Map<String, dynamic> jsonResponse = response.body is String
          ? jsonDecode(response.body)
          : Map<String, dynamic>.from(response.body);

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

      final Map<String, dynamic> jsonResponse = response.body is String
          ? jsonDecode(response.body)
          : Map<String, dynamic>.from(response.body);

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

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    editNameController.dispose();
    editAddressController.dispose();
    editPhoneController.dispose();
    editEmailController.dispose();
    super.onClose();
  }
}