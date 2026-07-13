import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:america_ayber_squad/service/api_client.dart';
import 'package:america_ayber_squad/service/api_url.dart';
import 'package:america_ayber_squad/utils/ToastMsg/toast_message.dart';
import 'package:america_ayber_squad/utils/app_const/app_const.dart';
import '../model/student_schedule_model.dart';

class StudentProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getStudentSchedule();
    getStudentOverview();
  }

  // Observable for the selected day
  var selectedDay = "Sunday".obs;

  // List of days
  List<String> days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  RxList<ClassDistribution> allScheduleList = <ClassDistribution>[].obs;
  RxBool isScheduleLoading = false.obs;
  Rx<Status> rxScheduleStatus = Status.loading.obs;

  Future<void> getStudentSchedule({String? subject}) async {
    isScheduleLoading.value = true;
    rxScheduleStatus.value = Status.loading;

    try {
      final response = await ApiClient.getData(ApiUrl.getStudentSchedule(page: 1, subject: subject));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String 
            ? jsonDecode(response.body) 
            : Map<String, dynamic>.from(response.body);
            
        debugPrint("RAW STUDENT SCHEDULE RESPONSE: ${jsonEncode(jsonResponse)}");
        final StudentScheduleResponse model = StudentScheduleResponse.fromJson(jsonResponse);
        
        if (model.data != null && model.data!.data != null && model.data!.data!.classDistributions != null) {
          allScheduleList.value = model.data!.data!.classDistributions!;
        }

        rxScheduleStatus.value = Status.completed;
      } else {
        rxScheduleStatus.value = Status.error;
        final Map<String, dynamic> errorResponse = response.body is String 
            ? jsonDecode(response.body) 
            : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to load schedule',
          isError: true,
        );
      }
    } catch (e) {
      rxScheduleStatus.value = Status.error;
      debugPrint('getStudentSchedule Error: $e');
      showCustomSnackBar('Error: ${e.toString()}', isError: true);
    } finally {
      isScheduleLoading.value = false;
    }
  }

  // Overview Variables
  RxBool isOverviewLoading = false.obs;
  RxInt upcomingExamCount = 0.obs;
  RxInt pendingAssignmentCount = 0.obs;
  RxDouble averageAttendance = 0.0.obs;

  Future<void> getStudentOverview() async {
    isOverviewLoading.value = true;
    try {
      final response = await ApiClient.getData(ApiUrl.studentOverview);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String 
            ? jsonDecode(response.body) 
            : Map<String, dynamic>.from(response.body);
        
        final data = jsonResponse['data'];
        if (data != null) {
          upcomingExamCount.value = (data['upcomingExamCount'] ?? 0) as int;
          pendingAssignmentCount.value = (data['pendingAssignmentCount'] ?? 0) as int;
          
          final att = data['averageAttendance'];
          if (att is num) {
            averageAttendance.value = att.toDouble();
          } else {
            averageAttendance.value = 0.0;
          }
        }
      }
    } catch (e) {
      debugPrint("getStudentOverview Error: $e");
    } finally {
      isOverviewLoading.value = false;
    }
  }
}
