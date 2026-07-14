import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:america_ayber_squad/service/api_client.dart';
import 'package:america_ayber_squad/service/api_url.dart';
import 'package:america_ayber_squad/utils/ToastMsg/toast_message.dart';
import 'package:america_ayber_squad/utils/app_const/app_const.dart';
import '../model/student_schedule_model.dart';
import '../model/resource_list_model.dart';
import '../model/student_fees_model.dart';

class StudentProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getStudentSchedule();
    getStudentOverview();
    getStudentClassMaterial();
    getStudentFees();
  }

  RxList<StudentFeesModel> studentFeesList = <StudentFeesModel>[].obs;
  RxBool isFeesLoading = false.obs;
  RxDouble totalDue = 0.0.obs;

  Future<void> getStudentFees() async {
    isFeesLoading.value = true;
    try {
      final response = await ApiClient.getData(ApiUrl.studentFees);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String 
            ? jsonDecode(response.body) 
            : Map<String, dynamic>.from(response.body);
            
        final dataMap = jsonResponse['data'];
        if (dataMap != null && dataMap['data'] != null) {
          final List dynamicList = dataMap['data'];
          List<StudentFeesModel> fees = dynamicList.map((e) => StudentFeesModel.fromJson(e)).toList();
          studentFeesList.value = fees;
          
          double due = 0.0;
          for (var item in fees) {
            due += item.unpaidAmount;
          }
          totalDue.value = due;
        }
      }
    } catch (e) {
      debugPrint("Error fetching fees: $e");
    } finally {
      isFeesLoading.value = false;
    }
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

  RxList<ResourceModel> materialFiles = <ResourceModel>[].obs;
  RxBool isMaterialLoading = false.obs;

  Future<void> getStudentClassMaterial() async {
    isMaterialLoading.value = true;
    try {
      final response = await ApiClient.getData(ApiUrl.studentclassMaterial);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String 
            ? jsonDecode(response.body) 
            : Map<String, dynamic>.from(response.body);
            
        final dataMap = jsonResponse['data'];
        if (dataMap != null && dataMap['data'] != null) {
          final List dynamicList = dataMap['data'];
          List<ResourceModel> tempMaterials = [];
          
          for (var branchItem in dynamicList) {
            final classDistributions = branchItem['classDistributions'] as List?;
            if (classDistributions != null) {
              for (var distItem in classDistributions) {
                final subject = distItem['assignableSubject'] ?? "Unknown";
                final classMaterials = distItem['classMaterials'] as List?;
                if (classMaterials != null) {
                  for (var material in classMaterials) {
                    final desc = material['description'] ?? "Class Material";
                    final type = material['materialType'] ?? "Link";
                    final date = material['createdAt'] != null ? material['createdAt'].toString().substring(0, 10) : "N/A";
                    
                    String? fUrl;
                    final externalLink = material['external_link'];
                    if (externalLink != null && externalLink.toString().isNotEmpty) {
                      fUrl = externalLink.toString();
                    } else {
                      final files = material['materialFiles'] as List?;
                      if (files != null && files.isNotEmpty) {
                        final path = files.first.toString();
                        fUrl = path.startsWith("http") ? path : "${ApiUrl.imageUrl}$path";
                      }
                    }
                    
                    tempMaterials.add(ResourceModel(
                      fileName: desc,
                      size: "N/A",
                      subject: subject,
                      type: type,
                      date: date,
                      icon: Icons.description_outlined,
                      color: Colors.blue,
                      fileUrl: fUrl,
                    ));
                  }
                }
              }
            }
          }
          materialFiles.value = tempMaterials;
        }
      }
    } catch (e) {
      debugPrint("Error fetching materials: $e");
    } finally {
      isMaterialLoading.value = false;
    }
  }
}
