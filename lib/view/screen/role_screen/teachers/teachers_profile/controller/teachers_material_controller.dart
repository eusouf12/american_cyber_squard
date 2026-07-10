import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:america_ayber_squad/service/api_client.dart';
import 'package:america_ayber_squad/service/api_url.dart';
import 'package:america_ayber_squad/utils/ToastMsg/toast_message.dart';
import '../model/metarial.dart';

class TeachersMaterialController extends GetxController {
  final RxBool isOpen = false.obs;

  // Selected Class States
  final RxnString selectedClassLevel = RxnString();
  final RxnString selectedClassId = RxnString();

  // Materials List State
  final RxList<MaterialItem> materialsList = <MaterialItem>[].obs;
  final RxBool isGetLoading = false.obs;

  // Create/Update Loading State
  final RxBool isLoading = false.obs;

  // Picked files for creation/update
  final RxList<File> pickedFiles = <File>[].obs;

  // Details State
  final Rxn<MaterialItem> specificMaterialData = Rxn<MaterialItem>();
  final RxBool isSpecificLoading = false.obs;

  Future<void> pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );
      if (result != null) {
        pickedFiles.addAll(
            result.paths.where((path) => path != null).map((path) => File(path!)));
      }
    } catch (e) {
      debugPrint("pickFiles Error: $e");
    }
  }

  void removeFile(int index) {
    pickedFiles.removeAt(index);
  }

  // Fetch Materials list by classDistributionId (selectedClassId)
  Future<void> getMaterialsList() async {
    final String? classId = selectedClassId.value;
    if (classId == null || classId.isEmpty) {
      materialsList.clear();
      return;
    }

    isGetLoading.value = true;
    try {
      final String url = ApiUrl.getTeacherMaterials(id: classId);
      final response = await ApiClient.getData(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);

        final MaterialResponse model = MaterialResponse.fromJson(jsonResponse);
        materialsList.value = model.data?.data ?? [];
      } else {
        final Map<String, dynamic> errorResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to load materials',
          isError: true,
        );
      }
    } catch (e) {
      debugPrint("getMaterialsList Error: $e");
      showCustomSnackBar("Error: ${e.toString()}", isError: true);
    } finally {
      isGetLoading.value = false;
    }
  }

  // Create new material
  Future<bool> createMaterial({
    required String classDistributionId,
    required String materialType,
    required String description,
    required String externalLink,
    required String assignmenttitle,
  }) async {
    isLoading.value = true;
    try {
      final Map<String, String> data = {
        "assignmentTitle": assignmenttitle,
        "classDistributionId": classDistributionId,
        "materialType": materialType,
        "description": description,
        "external_link": externalLink,
      };

      final body = {
        "data": jsonEncode(data),
      };

      List<MultipartBody> multipartBody = [];
      for (var file in pickedFiles) {
        multipartBody.add(MultipartBody('materialFiles', file));
      }

      final response = await ApiClient.postMultipartData(
        ApiUrl.createMaterials,
        body,
        multipartBody: multipartBody,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar("Material uploaded successfully", isError: false);
        pickedFiles.clear();
        getMaterialsList();
        return true;
      } else {
        final Map<String, dynamic> errorResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to create material',
          isError: true,
        );
        return false;
      }
    } catch (e) {
      debugPrint("createMaterial Error: $e");
      showCustomSnackBar("Error: ${e.toString()}", isError: true);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Update material
  Future<bool> updateMaterial({
    required String materialId,
    required String classDistributionId,
    required String materialType,
    required String description,
    required String externalLink,
    required String assignmentTitle,
  }) async {
    isLoading.value = true;
    try {
      final Map<String, String> data = {
        "assignmentTitle": assignmentTitle,
        "classDistributionId": classDistributionId,
        "materialType": materialType,
        "description": description,
        "external_link": externalLink,
      };

      final body = {
        "data": jsonEncode(data),
      };

      List<MultipartBody> multipartBody = [];
      for (var file in pickedFiles) {
        multipartBody.add(MultipartBody('materialFiles', file));
      }

      final response = await ApiClient.postMultipartData(
        ApiUrl.updateMaterials(materialId: materialId),
        body,
        multipartBody: multipartBody,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar("Material updated successfully", isError: false);
        pickedFiles.clear();
        getMaterialsList();
        return true;
      } else {
        final Map<String, dynamic> errorResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to update material',
          isError: true,
        );
        return false;
      }
    } catch (e) {
      debugPrint("updateMaterial Error: $e");
      showCustomSnackBar("Error: ${e.toString()}", isError: true);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Delete material
  Future<void> deleteMaterial(String materialId) async {
    try {
      final response = await ApiClient.deleteData(
        ApiUrl.deleteMaterials(materialId: materialId),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar("Material deleted successfully", isError: false);
        getMaterialsList();
      } else {
        final Map<String, dynamic> errorResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to delete material',
          isError: true,
        );
      }
    } catch (e) {
      debugPrint("deleteMaterial Error: $e");
      showCustomSnackBar("Error: ${e.toString()}", isError: true);
    }
  }

  // Fetch specific material details
  Future<void> getSpecificMaterial(String materialId) async {
    isSpecificLoading.value = true;
    specificMaterialData.value = null;
    try {
      final response = await ApiClient.getData(
        ApiUrl.specificMaterials(materialId: materialId),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);

        // API might wrap inside dynamic model under "data" key
        final dynamic nestedData = jsonResponse['data'];
        if (nestedData != null) {
          specificMaterialData.value = MaterialItem.fromJson(nestedData);
        }
      } else {
        final Map<String, dynamic> errorResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to load details',
          isError: true,
        );
      }
    } catch (e) {
      debugPrint("getSpecificMaterial Error: $e");
      showCustomSnackBar("Error: ${e.toString()}", isError: true);
    } finally {
      isSpecificLoading.value = false;
    }
  }
}
