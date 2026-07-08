import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:america_ayber_squad/service/api_client.dart';
import 'package:america_ayber_squad/service/api_url.dart';
import 'package:america_ayber_squad/utils/ToastMsg/toast_message.dart';
import 'package:america_ayber_squad/utils/app_const/app_const.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/attendence_sheet_teacher.dart';
import '../../teachers_home/model/teacher_schedule.dart';
import 'package:intl/intl.dart';

class TeacherAttendanceController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    resetState();
  }

  void resetState() {
    selectedSchedule.value = null;
    selectedDate.value = DateTime.now();
    attendanceSheet.clear();
    studentStatus.clear();
  }

  //================================= Get Attendence Sheet ==============================
  Rxn<RoutineModel> selectedSchedule = Rxn<RoutineModel>();
  RxBool isOpen = false.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxList<TeacherStudentAttendance> attendanceSheet =
      <TeacherStudentAttendance>[].obs;
  RxBool isAttendanceLoading = false.obs;
  RxBool isSaveLoading = false.obs;
  Rx<Status> rxAttendanceStatus = Status.loading.obs;

  Future<void> getAttenddenceSheet() async {
    if (selectedSchedule.value == null) return;

    isAttendanceLoading.value = true;
    rxAttendanceStatus.value = Status.loading;
    attendanceSheet.clear();

    final routineId = selectedSchedule.value?.id ?? '';

    try {
      final localDate = selectedDate.value;
      final startOfDay = DateTime(localDate.year, localDate.month, localDate.day);
      final response = await ApiClient.getData(
          ApiUrl.getTeacherStudentsAttenddenceSheet(
              page: 1,
              classId: routineId,
              date: DateFormat('yyyy-MM-dd').format(startOfDay.toUtc())));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);
        final TeacherStudentsAttendenceSheet model =
            TeacherStudentsAttendenceSheet.fromJson(jsonResponse);

        if (model.data != null && model.data!.data != null) {
          attendanceSheet.value = model.data!.data!;
          for (var item in attendanceSheet) {
            if (item.studentId != null) {
              studentStatus[item.studentId!] = item.attendanceStatus ?? '';
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
          errorResponse['message']?.toString() ??
              'Failed to load attendance sheet',
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

  // Save/Update student attendance using PATCH API
  Future<void> saveAttendance() async {
    if (attendanceSheet.isEmpty) {
      showCustomSnackBar("No students to save attendance for", isError: true);
      return;
    }

    isSaveLoading.value = true;

    final String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    final List<Map<String, dynamic>> studentsList = [];
    for (var item in attendanceSheet) {
      final sId = item.studentId ?? '';
      final status = studentStatus[sId] ?? '';
      if (status.isNotEmpty) {
        studentsList.add({
          "studentId": sId,
          "attendanceStatus": status.toUpperCase(),
        });
      }
    }

    if (studentsList.isEmpty) {
      showCustomSnackBar("Please mark attendance for at least one student",
          isError: true);
      isSaveLoading.value = false;
      return;
    }

    final Map<String, dynamic> body = {
      "attendanceDate": formattedDate,
      "students": studentsList,
    };

    try {
      final response = await ApiClient.patchData(
          ApiUrl.updateTeacherStudentAttendanc, body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar("Attendance updated successfully!", isError: false);
        getAttenddenceSheet();
      } else {
        final Map<String, dynamic> errorResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to update attendance',
          isError: true,
        );
      }
    } catch (e) {
      debugPrint('saveAttendance Error: $e');
      showCustomSnackBar('Error: ${e.toString()}', isError: true);
    } finally {
      isSaveLoading.value = false;
    }
  }

  // Open phone's mail app to email parent
  Future<void> sendEmail(String email) async {
    if (email.isEmpty || email == "N/A") {
      showCustomSnackBar("Invalid email address", isError: true);
      return;
    }
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': 'Student Attendance Notification'},
    );
    try {
      final bool launched = await launchUrl(
        emailLaunchUri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        showCustomSnackBar("Could not launch mail application", isError: true);
      }
    } catch (e) {
      debugPrint("sendEmail Error: $e");
      showCustomSnackBar("Failed to open mail app: ${e.toString()}", isError: true);
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
