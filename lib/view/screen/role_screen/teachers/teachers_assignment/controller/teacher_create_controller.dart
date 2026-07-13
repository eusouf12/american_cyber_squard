import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:america_ayber_squad/service/api_client.dart';
import 'package:america_ayber_squad/service/api_url.dart';
import 'package:america_ayber_squad/utils/ToastMsg/toast_message.dart';
import '../model/assignment_submit_list_model.dart';

class TeacherAssignmentController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getAssignmentsList();
  }

  void changeTab(int index) {
    selectedIndex.value = index;
    getAssignmentsList();
  }

  String getStatusFromIndex(int index) {
    if (index == 0) return "all";
    if (index == 1) return "active";
    return "completed";
  }

  final RxInt progress = 0.obs;

  // Selected class/subject from dropdown
  final RxnString selectedClassId = RxnString();
  final RxnString selectedClassLevel = RxnString();
  final RxnString selectedSubject = RxnString();

  // Dialog inputs / picker states
  final RxList<File> pickedFiles = <File>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isGetLoading = false.obs;

  // Assignments List
  final RxList<dynamic> assignments = <dynamic>[].obs;

  // Specific assignment detail (for details screen)
  final Rxn<Map<String, dynamic>> specificAssignmentData = Rxn<Map<String, dynamic>>();
  final RxBool isSpecificAssignmentLoading = false.obs;

  // Submitted student list
  final RxList<SubmittedAssignmentList> submittedList = <SubmittedAssignmentList>[].obs;
  final RxBool isSubmittedListLoading = false.obs;

  // Picker helper
  Future<void> pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );
      if (result != null) {
        pickedFiles.addAll(result.paths.where((path) => path != null).map((path) => File(path!)));
      }
    } catch (e) {
      debugPrint("pickFiles Error: $e");
    }
  }

  void removeFile(int index) {
    pickedFiles.removeAt(index);
  }

  // Get Assignments List
  Future<void> getAssignmentsList() async {
    isGetLoading.value = true;
    try {
      final status = getStatusFromIndex(selectedIndex.value);
      final String url = ApiUrl.getTeacherAssignment(
        status: status,
        classLevel: selectedClassLevel.value,
      );
      final response = await ApiClient.getData(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);
        
        final rawData = jsonResponse['data'];
        if (rawData is List) {
          assignments.value = rawData;
        } else if (rawData is Map && rawData['data'] is List) {
          assignments.value = rawData['data'];
        } else {
          assignments.clear();
        }
      } else {
        assignments.clear();
      }
    } catch (e) {
      debugPrint("getAssignmentsList Error: $e");
      assignments.clear();
    } finally {
      isGetLoading.value = false;
    }
  }

  // Post Assignment
  Future<bool> createAssignment({
    required String title,
    required String type,
    required String description,
    required String dueDate, // ISO format e.g. "2026-05-12T00:00:00.000Z"
  }) async {
    if (selectedClassLevel.value == null || selectedClassId.value == null) {
      showCustomSnackBar("Please select a class/subject first", isError: true);
      return false;
    }

    isLoading.value = true;
    try {
      final Map<String, String> data = {
        "classLevel": selectedClassLevel.value!,
        "classDistributionId": selectedClassId.value!,
        "assignmentTitle": title,
        "assignmentType": type,
        "assignmentDueDate": dueDate,
        "description": description,
      };

      final body = {
        "data": jsonEncode(data),
      };

      List<MultipartBody> multipartBody = [];
      for (var file in pickedFiles) {
        multipartBody.add(MultipartBody('attachments', file));
      }

      final response = await ApiClient.postMultipartData(
        ApiUrl.createAssignment,
        body,
        multipartBody: multipartBody.isNotEmpty ? multipartBody : null,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar("Assignment created successfully", isError: false);
        pickedFiles.clear();
        getAssignmentsList(); // Refresh list
        return true;
      } else {
        final Map<String, dynamic> errorResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to create assignment',
          isError: true,
        );
        return false;
      }
    } catch (e) {
      debugPrint("createAssignment Error: $e");
      showCustomSnackBar("Error creating assignment: ${e.toString()}", isError: true);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch Specific Assignment Details
  Future<Map<String, dynamic>?> fetchSpecificAssignment(String assignmentId) async {
    isSpecificAssignmentLoading.value = true;
    specificAssignmentData.value = null;
    try {
      final response = await ApiClient.getData(
        ApiUrl.specificAssignment(assignmentId: assignmentId),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);
        final data = jsonResponse['data'];
        specificAssignmentData.value = data != null ? Map<String, dynamic>.from(data) : null;
        return specificAssignmentData.value;
      } else {
        final Map<String, dynamic> errorResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to load details',
          isError: true,
        );
        return null;
      }
    } catch (e) {
      debugPrint("fetchSpecificAssignment Error: $e");
      showCustomSnackBar("Error loading details: ${e.toString()}", isError: true);
      return null;
    } finally {
      isSpecificAssignmentLoading.value = false;
    }
  }

  // Get Submitted Student List
  Future<void> assignmentSubmitedList(String assignmentId) async {
    isSubmittedListLoading.value = true;
    submittedList.clear();
    try {
      final response = await ApiClient.getData(
        ApiUrl.getAssignmentSubmitedList(assignmentId: assignmentId),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);
        final model = StudentSubmittedAssignmentResponse.fromJson(jsonResponse);
        if (model.data?.data != null) {
          submittedList.value = model.data!.data!;
        }
      } else {
        debugPrint("assignmentSubmitedList failed status: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("assignmentSubmitedList Error: $e");
    } finally {
      isSubmittedListLoading.value = false;
    }
  }

  // Update Assignment
  Future<bool> updateAssignment({
    required String assignmentId,
    required String title,
    required String type,
    required String description,
    required String dueDate,
  }) async {
    isLoading.value = true;
    try {
      final Map<String, String> data = {
        "classLevel": selectedClassLevel.value ?? "",
        "classDistributionId": selectedClassId.value ?? "",
        "assignmentTitle": title,
        "assignmentType": type,
        "assignmentDueDate": dueDate,
        "description": description,
      };

      final body = {
        "data": jsonEncode(data),
      };

      List<MultipartBody> multipartBody = [];
      for (var file in pickedFiles) {
        multipartBody.add(MultipartBody('attachments', file));
      }

      final response = await ApiClient.patchMultipartData(
        ApiUrl.updateAssignment(assignmentId: assignmentId),
        body,
        multipartBody: multipartBody.isNotEmpty ? multipartBody : null,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar("Assignment updated successfully", isError: false);
        pickedFiles.clear();
        getAssignmentsList(); // Refresh list
        return true;
      } else {
        final Map<String, dynamic> errorResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to update assignment',
          isError: true,
        );
        return false;
      }
    } catch (e) {
      debugPrint("updateAssignment Error: $e");
      showCustomSnackBar("Error updating assignment: ${e.toString()}", isError: true);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Delete Assignment
  Future<bool> deleteAssignment(String assignmentId) async {
    isLoading.value = true;
    try {
      final response = await ApiClient.deleteData(
        ApiUrl.deleteAssignment(assignmentId: assignmentId),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar("Assignment deleted successfully", isError: false);
        getAssignmentsList(); // Refresh list
        return true;
      } else {
        final Map<String, dynamic> errorResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to delete assignment',
          isError: true,
        );
        return false;
      }
    } catch (e) {
      debugPrint("deleteAssignment Error: $e");
      showCustomSnackBar("Error deleting assignment: ${e.toString()}", isError: true);
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
