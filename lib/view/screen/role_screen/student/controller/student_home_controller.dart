import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
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
    initData();
  }

  Future<void> initData() async {
    await getStudentSubjects();
    await getStudentAssignments();
  }

  RxList<StudentAssignmentClassDistribution> assignmentsList =
      <StudentAssignmentClassDistribution>[].obs;
  RxBool isAssignmentLoading = true.obs;
  Rx<Status> rxAssignmentStatus = Status.loading.obs;

  RxInt totalCount = 0.obs;
  RxInt completedCount = 0.obs;
  RxInt overdueCount = 0.obs;
  RxInt dueCount = 0.obs;

  final RxnString selectedSubject = RxnString("All");
  final RxList<String> studentSubjectsList = <String>["All"].obs;

  Future<void> getStudentSubjects() async {
    try {
      final response =
          await ApiClient.getData(ApiUrl.getStudentSchedule(page: 1));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);

        final dataMap = jsonResponse['data'];
        if (dataMap is Map) {
          final dataInner = dataMap['data'];
          if (dataInner is Map) {
            final classDists = dataInner['classDistributions'];
            if (classDists is List) {
              final Set<String> subjects = {};
              for (var dist in classDists) {
                if (dist is Map && dist['assignableSubject'] != null) {
                  subjects.add(dist['assignableSubject'].toString());
                }
              }
              studentSubjectsList.value = ["All", ...subjects];
              if (selectedSubject.value == null) {
                selectedSubject.value = "All";
              }
            }
          }
        }
      }
    } catch (e) {
      debugPrint("getStudentSubjects Error: $e");
    }
  }

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

      final String classLevel =
          (loginController.myProfileData.value?.assignClass != null &&
                  loginController.myProfileData.value!.assignClass.isNotEmpty)
              ? loginController.myProfileData.value!.assignClass.first
              : "";

      final response = await ApiClient.getData(
        ApiUrl.getStudentAssignment(
          page: 1,
          classLevel: classLevel,
          subject: selectedSubject.value == "All"
              ? ""
              : (selectedSubject.value ?? ""),
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);

        debugPrint("STUDENT ASSIGNMENTS RESPONSE: ${jsonEncode(jsonResponse)}");
        final StudentAssignmentResponse model =
            StudentAssignmentResponse.fromJson(jsonResponse);

        if (model.data != null) {
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

          // Calculate summary counts dynamically
          int completed = 0;
          int overdue = 0;
          int pending = 0;

          for (var dist in temp) {
            if (dist.classAssignments != null) {
              for (var ass in dist.classAssignments!) {
                final bool isSub = ass.isSubmitted ?? false;
                final bool isOver = ass.assessmentAvailable ?? false;

                if (isSub) {
                  completed++;
                } else {
                  if (isOver) {
                    overdue++;
                  } else {
                    pending++;
                  }
                }
              }
            }
          }

          completedCount.value = completed;
          overdueCount.value = overdue;
          dueCount.value = pending; // Pending
          totalCount.value = completed + overdue + pending;
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
          if (ass.assignmentDueDate != null &&
              (ass.isSubmitted ?? false) == false &&
              (ass.assessmentAvailable ?? false) == false) {
            final dueLocal = ass.assignmentDueDate!.toLocal();
            final dueDay =
                DateTime(dueLocal.year, dueLocal.month, dueLocal.day);
            if (dueDay.isAtSameMomentAs(localToday)) {
              count++;
            }
          }
        }
      }
    }
    return count;
  }

  // Submission States
  final RxList<File> submissionFiles = <File>[].obs;
  final RxBool isSubmitting = false.obs;

  Future<void> pickSubmissionFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );
      if (result != null) {
        submissionFiles.addAll(result.paths
            .where((path) => path != null)
            .map((path) => File(path!)));
      }
    } catch (e) {
      debugPrint("pickSubmissionFiles Error: $e");
    }
  }

  void removeSubmissionFile(int index) {
    submissionFiles.removeAt(index);
  }

  Future<bool> submitAssignment(String assignmentId) async {
    if (submissionFiles.isEmpty) {
      showCustomSnackBar("Please select at least one file to submit",
          isError: true);
      return false;
    }
    isSubmitting.value = true;
    try {
      final Map<String, String> data = {
        "classAssignmentId": assignmentId,
      };
      final body = {
        "data": jsonEncode(data),
      };

      List<MultipartBody> multipartBody = [];
      for (var file in submissionFiles) {
        multipartBody.add(MultipartBody('fileUrl', file));
      }

      final response = await ApiClient.patchMultipartData(
        ApiUrl.submitAssignment,
        body,
        multipartBody: multipartBody,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar("Assignment submitted successfully!",
            isError: false);
        submissionFiles.clear();
        getStudentAssignments(); // Refresh assignments list
        return true;
      } else {
        final Map<String, dynamic> errorResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to submit assignment',
          isError: true,
        );
        return false;
      }
    } catch (e) {
      debugPrint("submitAssignment Error: $e");
      showCustomSnackBar("Error submitting assignment: ${e.toString()}",
          isError: true);
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }
}
