import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:america_ayber_squad/helper/shared_prefe/shared_prefe.dart';
import 'package:america_ayber_squad/service/api_client.dart';
import 'package:america_ayber_squad/service/api_url.dart';
import 'package:america_ayber_squad/utils/ToastMsg/toast_message.dart';
import 'package:america_ayber_squad/utils/app_const/app_const.dart';
import '../model/teacher_schedule.dart';
import '../model/teacher_assignment.dart';

class TeachersController extends GetxController {
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _checkTokenAndLoadData();
  }

 
  RxList<RoutineModel> allScheduleList = <RoutineModel>[].obs;
  RxList<RoutineModel> filteredScheduleList = <RoutineModel>[].obs;
  RxBool isScheduleLoading = false.obs;
  Rx<Status> rxScheduleStatus = Status.loading.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  RxList<AssignmentModel> assignmentList = <AssignmentModel>[].obs;
  RxBool isAssignmentLoading = false.obs;
  Rx<Status> rxAssignmentStatus = Status.loading.obs;

  Future<void> _checkTokenAndLoadData() async {
    String token = await SharePrefsHelper.getString(AppConstants.bearerToken);
    if (token.isNotEmpty) {
      getTeacherSchedule();
      getAssignmentHomework();
    }
  }
//========================= Get Teacher Schedule =========================
  Future<void> getTeacherSchedule() async {
    isScheduleLoading.value = true;
    rxScheduleStatus.value = Status.loading;

    try {
      final response = await ApiClient.getData(ApiUrl.getAllTeacherSchedule(page: 1));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse =response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);
        final RoutineResponse model = RoutineResponse.fromJson(jsonResponse);
        
        if (model.data != null && model.data!.data != null) {
          allScheduleList.value = model.data!.data!;
          filterScheduleBySelectedDate();
        }

        rxScheduleStatus.value = Status.completed;
      } else {
        rxScheduleStatus.value = Status.error;
        final Map<String, dynamic> errorResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to load schedule',
          isError: true,
        );
      }
    } catch (e) {
      rxScheduleStatus.value = Status.error;
      debugPrint('getTeacherSchedule Error: $e');
      showCustomSnackBar('Error: ${e.toString()}', isError: true);
    } finally {
      isScheduleLoading.value = false;
    }
  }

  void filterScheduleBySelectedDate() {
    String dayName = DateFormat('EEEE').format(selectedDate.value); // e.g. "Monday"
    
    filteredScheduleList.value = allScheduleList.where((element) {
      return element.day?.toLowerCase() == dayName.toLowerCase();
    }).toList();
  }

  // Method to select date from calendar
  void changeSelectedDate(DateTime date) {
    selectedDate.value = date;
    filterScheduleBySelectedDate();
  }
}