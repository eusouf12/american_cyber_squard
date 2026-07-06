import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:america_ayber_squad/service/api_client.dart';
import 'package:america_ayber_squad/service/api_url.dart';
import 'package:america_ayber_squad/utils/ToastMsg/toast_message.dart';
import 'package:america_ayber_squad/utils/app_const/app_const.dart';
import '../model/attendence_sheet_teacher.dart';
import '../../teachers_home/model/teacher_schedule.dart';

class TeacherAttendanceController extends GetxController {
  RxBool isOpen = false.obs;

  // Selected schedule (holds selected class and subject)
  Rxn<RoutineModel> selectedSchedule = Rxn<RoutineModel>();

  // Date selection (today's date initially)
  Rx<DateTime> selectedDate = DateTime.now().obs;

  // Attendance Sheet
  RxList<TeacherStudentAttendance> attendanceSheet = <TeacherStudentAttendance>[].obs;
  RxBool isAttendanceLoading = false.obs;
  Rx<Status> rxAttendanceStatus = Status.loading.obs;

  @override
  void onInit() {
    super.onInit();
    resetState();
  }

  // Reset states as required: today's date, no schedule selected, no attendance data
  void resetState() {
    selectedSchedule.value = null;
    selectedDate.value = DateTime.now();
    attendanceSheet.clear();
    studentStatus.clear();
  }

  // Fetch Student Attendance Sheet
  Future<void> getAttenddenceSheet() async {
    if (selectedSchedule.value == null) return;

    isAttendanceLoading.value = true;
    rxAttendanceStatus.value = Status.loading;
    attendanceSheet.clear();

    // Use schedule's ID as the studentId parameter
    final routineId = selectedSchedule.value?.id ?? '';

    try {
      final response = await ApiClient.getData(
        ApiUrl.getTeacherStudentsAttenddenceSheet(page: 1, studentId: routineId),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);
        final TeacherStudentsAttendenceSheet model = TeacherStudentsAttendenceSheet.fromJson(jsonResponse);

        if (model.data != null && model.data!.data != null) {
          attendanceSheet.value = model.data!.data!;
          // Populate studentStatus map for tracking changes in UI
          for (var item in attendanceSheet) {
            if (item.studentId != null) {
              studentStatus[item.studentId!] = '';
            }
          }
        }
        rxAttendanceStatus.value = Status.completed;
      } else {
        rxAttendanceStatus.value = Status.error;
        final Map<String, dynamic> errorResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to load attendance sheet',
          isError: true,
        );
      }
    } catch (e) {
      rxAttendanceStatus.value = Status.error;
      debugPrint('getAttenddenceSheet Error: $e');
      showCustomSnackBar('Error: ${e.toString()}', isError: true);
    } finally {
      isAttendanceLoading.value = false;
    }
  }

  void toggle() {
    isOpen.value = !isOpen.value;
  }

  void selectClass(RoutineModel value) {
    selectedSchedule.value = value;
    isOpen.value = false;
    getAttenddenceSheet();
  }

  // attendance status tracking
  var studentStatus = <String, String>{}.obs;
  void setStatus(String studentId, String status) {
    studentStatus[studentId] = status;
  }

  /// Button labels
  final List<String> statusList = ["Present", "Absent", "Late"];

  /// -1 = nothing selected
  RxInt selectedIndex = (-1).obs;

  void selectStatus(int index) {
    selectedIndex.value = index;
  }

  bool get isPresent => selectedIndex.value == 0;
  bool get isAbsent => selectedIndex.value == 1;
  bool get isLate => selectedIndex.value == 2;
}
