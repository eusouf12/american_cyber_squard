import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:america_ayber_squad/service/api_client.dart';
import 'package:america_ayber_squad/service/api_url.dart';
import 'package:america_ayber_squad/utils/ToastMsg/toast_message.dart';
import 'package:america_ayber_squad/utils/app_const/app_const.dart';
import 'package:america_ayber_squad/view/screen/Login_role/login_controller.dart';
import '../view/student_assignment/model/student_assignment_model.dart';

class StudentHomeController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    getStudentAssignments();
  }

  RxList<StudentAssignmentClassDistribution> assignmentsList = <StudentAssignmentClassDistribution>[].obs;
  RxBool isAssignmentLoading = false.obs;
  Rx<Status> rxAssignmentStatus = Status.loading.obs;

  RxInt totalCount = 0.obs;
  RxInt completedCount = 0.obs;
  RxInt pendingCount = 0.obs;
  RxInt dueCount = 0.obs;

  Future<void> getStudentAssignments() async {
    isAssignmentLoading.value = true;
    rxAssignmentStatus.value = Status.loading;

    try {
      final loginController = Get.find<LoginController>();
      final profile = loginController.myProfileData.value;
      
      // If profile is null, try to load it first
      if (profile == null) {
        await loginController.getMyProfile();
      }

      final String classLevel = (loginController.myProfileData.value?.assignClass != null && 
              loginController.myProfileData.value!.assignClass.isNotEmpty)
          ? loginController.myProfileData.value!.assignClass.first
          : "";

      final response = await ApiClient.getData(
        ApiUrl.getStudentAssignment(page: 1, classLevel: classLevel, subject: "English"),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String 
            ? jsonDecode(response.body) 
            : Map<String, dynamic>.from(response.body);
            
        debugPrint("STUDENT ASSIGNMENTS RESPONSE: ${jsonEncode(jsonResponse)}");
        final StudentAssignmentResponse model = StudentAssignmentResponse.fromJson(jsonResponse);
        
        if (model.data != null) {
          // Bind summary
          if (model.data!.summary != null) {
            totalCount.value = model.data!.summary!.total ?? 0;
            completedCount.value = model.data!.summary!.completed ?? 0;
            pendingCount.value = model.data!.summary!.pending ?? 0;
            dueCount.value = model.data!.summary!.due ?? 0;
          }

          // Gather all class assignments
          final List<StudentAssignmentClassDistribution> temp = [];
          if (model.data!.data != null) {
            for (var student in model.data!.data!) {
              if (student.classDistributions != null) {
                temp.addAll(student.classDistributions!);
              }
            }
          }
          assignmentsList.value = temp;
        }

        rxAssignmentStatus.value = Status.completed;
      } else {
        rxAssignmentStatus.value = Status.error;
        final Map<String, dynamic> errorResponse = response.body is String 
            ? jsonDecode(response.body) 
            : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to load assignments',
          isError: true,
        );
      }
    } catch (e) {
      rxAssignmentStatus.value = Status.error;
      debugPrint('getStudentAssignments Error: $e');
      showCustomSnackBar('Error: ${e.toString()}', isError: true);
    } finally {
      isAssignmentLoading.value = false;
    }
  }

  // Helper to get assignments due today (using local time comparison)
  int get dueTodayCount {
    final now = DateTime.now();
    final localToday = DateTime(now.year, now.month, now.day);
    
    int count = 0;
    for (var dist in assignmentsList) {
      if (dist.classAssignments != null) {
        for (var ass in dist.classAssignments!) {
          if (ass.assignmentDueDate != null && ass.status?.toLowerCase() != "completed") {
            final dueLocal = ass.assignmentDueDate!.toLocal();
            final dueDay = DateTime(dueLocal.year, dueLocal.month, dueLocal.day);
            if (dueDay.isAtSameMomentAs(localToday)) {
              count++;
            }
          }
        }
      }
    }
    return count;
  }
}