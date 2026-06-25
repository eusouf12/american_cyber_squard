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
import '../model/announcement_model.dart';

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

  Future<void> _checkTokenAndLoadData() async {
    String token = await SharePrefsHelper.getString(AppConstants.bearerToken);
    if (token.isNotEmpty) {
      getTeacherSchedule();
      getAssignmentHomework();
      getAnnouncement();
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



//========================= Get Teacher AssignmentHomework =========================
  RxList<AssignmentModel> assignmentList = <AssignmentModel>[].obs;
  RxBool isAssignmentLoading = false.obs;
  RxBool isMoreAssignmentLoading = false.obs;
  Rx<Status> rxAssignmentStatus = Status.loading.obs;
  var assignmentPage = 1.obs;
  var hasMoreAssignments = true.obs;

  Future<void> getAssignmentHomework({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (isMoreAssignmentLoading.value || !hasMoreAssignments.value) return;
      isMoreAssignmentLoading.value = true;
      assignmentPage.value++;
    } else {
      isAssignmentLoading.value = true;
      rxAssignmentStatus.value = Status.loading;
      assignmentPage.value = 1;
      hasMoreAssignments.value = true;
    }

    try {
      final response = await ApiClient.getData(ApiUrl.getAssignmentHomework(page: assignmentPage.value));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);
        final AssignmentResponse model = AssignmentResponse.fromJson(jsonResponse);
        
        if (model.data != null && model.data!.data != null) {
          if (isLoadMore) {
            assignmentList.addAll(model.data!.data!);
          } else {
            assignmentList.value = model.data!.data!;
          }

          if (model.data!.data!.isEmpty || 
              (model.data!.meta != null && model.data!.meta!.totalPage != null && assignmentPage.value >= model.data!.meta!.totalPage!)) {
            hasMoreAssignments.value = false;
          }
        } else {
          hasMoreAssignments.value = false;
        }

        rxAssignmentStatus.value = Status.completed;
      } else {
        rxAssignmentStatus.value = Status.error;
        final Map<String, dynamic> errorResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to load assignments',
          isError: true,
        );
      }
    } catch (e) {
      rxAssignmentStatus.value = Status.error;
      debugPrint('getAssignmentHomework Error: $e');
      showCustomSnackBar('Error: ${e.toString()}', isError: true);
    } finally {
      if (isLoadMore) {
        isMoreAssignmentLoading.value = false;
      } else {
        isAssignmentLoading.value = false;
      }
    }
  }

  //========================= Get Teacher Announcement =========================
  RxList<AnnouncementModel> announcementList = <AnnouncementModel>[].obs;
  RxBool isAnnouncementLoading = false.obs;
  RxBool isMoreAnnouncementLoading = false.obs;
  Rx<Status> rxAnnouncementStatus = Status.loading.obs;
  var announcementPage = 1.obs;
  var hasMoreAnnouncements = true.obs;

  Future<void> getAnnouncement({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (isMoreAnnouncementLoading.value || !hasMoreAnnouncements.value) return;
      isMoreAnnouncementLoading.value = true;
      announcementPage.value++;
    } else {
      isAnnouncementLoading.value = true;
      rxAnnouncementStatus.value = Status.loading;
      announcementPage.value = 1;
      hasMoreAnnouncements.value = true;
    }

    try {
      final response = await ApiClient.getData(ApiUrl.getAnnouncement(page: announcementPage.value));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);
        final AnnouncementResponse model = AnnouncementResponse.fromJson(jsonResponse);
        
        if (model.data != null && model.data!.data != null) {
          if (isLoadMore) {
            announcementList.addAll(model.data!.data!);
          } else {
            announcementList.value = model.data!.data!;
          }

          if (model.data!.data!.isEmpty || 
              (model.data!.meta != null && model.data!.meta!.totalPage != null && announcementPage.value >= model.data!.meta!.totalPage!)) {
            hasMoreAnnouncements.value = false;
          }
        } else {
          hasMoreAnnouncements.value = false;
        }

        rxAnnouncementStatus.value = Status.completed;
      } else {
        rxAnnouncementStatus.value = Status.error;
        final Map<String, dynamic> errorResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to load announcements',
          isError: true,
        );
      }
    } catch (e) {
      rxAnnouncementStatus.value = Status.error;
      debugPrint('getAnnouncement Error: $e');
      showCustomSnackBar('Error: ${e.toString()}', isError: true);
    } finally {
      if (isLoadMore) {
        isMoreAnnouncementLoading.value = false;
      } else {
        isAnnouncementLoading.value = false;
      }
    }
  }
}