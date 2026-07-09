import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:america_ayber_squad/service/api_client.dart';
import 'package:america_ayber_squad/service/api_url.dart';
import 'package:america_ayber_squad/utils/ToastMsg/toast_message.dart';
import '../model/exam_list.dart';
import '../model/exam_perticipent.dart';
import 'package:america_ayber_squad/view/screen/role_screen/teachers/teachers_home/controller/teachers_controller.dart';

class TeacherCreateExamController extends GetxController {
  final examNameController = TextEditingController();
  final examDateController = TextEditingController();
  final topicController = TextEditingController();
  final marksController = TextEditingController();
  final durationController = TextEditingController();
  final instructionsController = TextEditingController();

  // --- Edit Mode state ---
  RxBool isEditing = false.obs;
  RxString editingExamId = "".obs;

  @override
  void onInit() {
    super.onInit();
    getExamsList();
  }

  @override
  void onClose() {
    examNameController.dispose();
    examDateController.dispose();
    topicController.dispose();
    marksController.dispose();
    durationController.dispose();
    instructionsController.dispose();
    super.onClose();
  }

  void setupEditMode(ExamList exam) {
    isEditing.value = true;
    editingExamId.value = exam.id ?? "";
    examNameController.text = exam.examName ?? "";
    examDateController.text = exam.examDate ?? "";
    topicController.text = exam.topic ?? "";
    marksController.text = exam.totalMarks ?? "";
    durationController.text = exam.duration ?? "";
    instructionsController.text = exam.instruction ?? "";
    selectedClassDistributionId.value = exam.classDistribution?.id;
  }

  void clearFields() {
    isEditing.value = false;
    editingExamId.value = "";
    examNameController.clear();
    examDateController.clear();
    topicController.clear();
    marksController.clear();
    durationController.clear();
    instructionsController.clear();
    selectedClassDistributionId.value = null;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      examDateController.text = DateFormat('MM/dd/yyyy').format(picked);
    }
  }

//==========================Create Exam list ========================================
  Future<void> submitExam() async {
    final String examName = examNameController.text.trim();
    final String examDate = examDateController.text.trim();
    final String topic = topicController.text.trim();
    final String marks = marksController.text.trim();
    final String duration = durationController.text.trim();
    final String instructions = instructionsController.text.trim();

    if (selectedClassDistributionId.value == null) {
      showCustomSnackBar("Please select a class", isError: true);
      return;
    }
    if (examName.isEmpty) {
      showCustomSnackBar("Please enter the exam name", isError: true);
      return;
    }
    if (examDate.isEmpty) {
      showCustomSnackBar("Please select the exam date", isError: true);
      return;
    }
    if (topic.isEmpty) {
      showCustomSnackBar("Please enter the topic", isError: true);
      return;
    }

    isLoading.value = true;

    try {
      if (isEditing.value) {
        final body = {
          "examName": examName,
          "examDate": examDate,
          "topic": topic,
          "totalMarks": marks,
          "duration": duration,
          "instruction": instructions,
        };

        final response = await ApiClient.patchData(
          ApiUrl.updateExam(examId: editingExamId.value),
          jsonEncode(body),
          isContentType: true,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          showCustomSnackBar("Exam updated successfully!", isError: false);
          await getExamsList(); // Refresh exam list
          Get.back(result: true);
        } else {
          final Map<String, dynamic> errorResponse = response.body is String
              ? jsonDecode(response.body)
              : Map<String, dynamic>.from(response.body ?? {});
          showCustomSnackBar(
            errorResponse['message']?.toString() ?? 'Failed to update exam',
            isError: true,
          );
        }
      } else {
        final body = {
          "examName": examName,
          "examDate": examDate,
          "topic": topic,
          "totalMarks": marks,
          "duration": duration,
          "instruction": instructions,
          "classDistributionId": selectedClassDistributionId.value,
        };

        final response = await ApiClient.postData(
          ApiUrl.createExam,
          jsonEncode(body),
          isContentType: true,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          showCustomSnackBar("Exam created successfully!", isError: false);
          await getExamsList(); // Refresh exam list
          Get.back(result: true);
        } else {
          final Map<String, dynamic> errorResponse = response.body is String
              ? jsonDecode(response.body)
              : Map<String, dynamic>.from(response.body ?? {});
          showCustomSnackBar(
            errorResponse['message']?.toString() ?? 'Failed to create exam',
            isError: true,
          );
        }
      }
    } catch (e) {
      showCustomSnackBar("Error submitting exam: ${e.toString()}",
          isError: true);
    } finally {
      isLoading.value = false;
    }
  }

//========================== Exam list GET API ========================================
  RxList<ExamList> exams = <ExamList>[].obs;
  RxBool isExamLoading = false.obs;
  RxnString selectedClassId = RxnString();
  Rxn<ExamStatusCount> statusCount = Rxn<ExamStatusCount>();
  RxnString selectedClassDistributionId = RxnString();

  Future<void> getExamsList({String? className, String? subject}) async {
    isExamLoading.value = true;

    String targetClass = className ?? "";
    String targetSubject = subject ?? "";

    if (className == null && subject == null) {
      if (selectedClassId.value != null) {
        try {
          final teachersController = Get.find<TeachersController>();
          final selected = teachersController.allScheduleList
              .firstWhere((e) => e.id == selectedClassId.value);
          targetClass = selected.classLevel ?? "";
          targetSubject = selected.assignableSubject ?? "";
        } catch (_) {}
      }
    }

    try {
      final response = await ApiClient.getData(
        ApiUrl.getExamlistTeacher(
          page: 1,
          className: targetClass,
          subject: targetSubject,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);
        final ExamListResponse model = ExamListResponse.fromJson(jsonResponse);
        if (model.data != null) {
          if (model.data!.examList != null) {
            exams.value = model.data!.examList!;
          } else {
            exams.clear();
          }
          statusCount.value = model.data!.statusCount;
        } else {
          exams.clear();
          statusCount.value = null;
        }
      } else {
        final Map<String, dynamic> errorResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to load exams',
          isError: true,
        );
      }
    } catch (e) {
      debugPrint("getExamsList Error: $e");
      showCustomSnackBar("Error loading exams: ${e.toString()}", isError: true);
    } finally {
      isExamLoading.value = false;
    }
  }

//==================== Delete Exam ===========================
  RxBool isLoading = false.obs;

  Future<void> deleteExam(String examId) async {
    isLoading.value = true;
    try {
      final response = await ApiClient.deleteData(
        ApiUrl.deleteExam(examId: examId),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar("Exam deleted successfully!", isError: false);
        await getExamsList(); // Refresh exams list
      } else {
        final Map<String, dynamic> errorResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to delete exam',
          isError: true,
        );
      }
    } catch (e) {
      showCustomSnackBar("Error deleting exam: ${e.toString()}", isError: true);
    } finally {
      isLoading.value = false;
    }
  }

//========================== tExamParticipants GET API ========================================
  RxList<ExamParticipant> participants = <ExamParticipant>[].obs;
  RxBool isParticipantLoading = false.obs;

  Future<void> getExamParticipants(String examId) async {
    isParticipantLoading.value = true;
    try {
      final response = await ApiClient.getData(
        ApiUrl.getExamParticipant(examId: examId),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);
        final ExamParticipantResponse model =
            ExamParticipantResponse.fromJson(jsonResponse);
        if (model.data != null && model.data!.participants != null) {
          participants.value = model.data!.participants!;
        } else {
          participants.clear();
        }
      } else {
        final Map<String, dynamic> errorResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to load participants',
          isError: true,
        );
        participants.clear();
      }
    } catch (e) {
      debugPrint("getExamParticipants Error: $e");
      showCustomSnackBar("Error loading participants: ${e.toString()}",
          isError: true);
      participants.clear();
    } finally {
      isParticipantLoading.value = false;
    }
  }

//========================== submit StudentGrade post API ========================================

  Future<bool> submitStudentGrade({
    required String examAnnouncementId,
    required String studentId,
    required num totalMarks,
    required num marks,
    required String instructions,
  }) async {
    isLoading.value = true;
    try {
      final body = {
        "examAnnouncementId": examAnnouncementId,
        "studentId": studentId,
        "totalMarks": totalMarks,
        "marks": marks,
        "instructions": instructions,
      };

      final response = await ApiClient.postData(
        ApiUrl.submitExamGrade,
        jsonEncode(body),
        isContentType: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar("Grade submitted successfully!", isError: false);
        return true;
      } else {
        final Map<String, dynamic> errorResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to submit grade',
          isError: true,
        );
        return false;
      }
    } catch (e) {
      debugPrint("submitStudentGrade Error: $e");
      showCustomSnackBar("Error submitting grade: ${e.toString()}",
          isError: true);
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
