import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:america_ayber_squad/service/api_client.dart';
import 'package:america_ayber_squad/service/api_url.dart';
import 'package:america_ayber_squad/utils/ToastMsg/toast_message.dart';

class ContactUsController extends GetxController {
  final nameController = TextEditingController();
  final subjectController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  final RxBool isLoading = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    subjectController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }

  Future<void> sendSupportMessage() async {
    isLoading.value = true;
    try {
      final Map<String, dynamic> body = {
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "subject": subjectController.text.trim(),
        "message": messageController.text.trim(),
      };

      final response = await ApiClient.postData(
        ApiUrl.teacherSupportMessage,
        body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar("Message sent successfully", isError: false);
        Get.back();
        // Clear inputs on success
        nameController.clear();
        emailController.clear();
        subjectController.clear();
        messageController.clear();
      } else {
        final Map<String, dynamic> errorResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to send message',
          isError: true,
        );
      }
    } catch (e) {
      debugPrint("sendSupportMessage Error: $e");
      showCustomSnackBar("Error: ${e.toString()}", isError: true);
    } finally {
      isLoading.value = false;
    }
  }
}
