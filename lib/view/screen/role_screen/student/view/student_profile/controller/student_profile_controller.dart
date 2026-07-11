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

  Future<void> getStudentSchedule() async {
    isScheduleLoading.value = true;
    rxScheduleStatus.value = Status.loading;

    try {
      final response = await ApiClient.getData(ApiUrl.getStudentSchedule(page: 1));

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
}
