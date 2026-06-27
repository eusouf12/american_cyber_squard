import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:america_ayber_squad/service/api_client.dart';
import 'package:america_ayber_squad/service/api_url.dart';
import 'package:america_ayber_squad/utils/ToastMsg/toast_message.dart';
import 'package:america_ayber_squad/utils/app_const/app_const.dart';
import '../model/teacher_under_students.dart';

class TeacherStudentController extends GetxController {
  final ScrollController scrollController = ScrollController();

  var selectedClass = "All".obs;
  var searchQuery = "".obs;
  RxList<String> myClass = <String>["All"].obs;

  RxList<TeacherUnderStudentItem> studentList = <TeacherUnderStudentItem>[].obs;
  RxBool isStudentsLoading = false.obs;
  RxBool isMoreStudentsLoading = false.obs;
  Rx<Status> rxStudentsStatus = Status.loading.obs;
  var studentsPage = 1.obs;
  var hasMoreStudents = true.obs;

  @override
  void onInit() {
    super.onInit();
    selectedClass.value = "All";
    myClass.value = ["All"];
    
    // Fetch classes and students
    getClasses().then((_) {
      getStudents();
    });

    // Automatically trigger search on text change (with 500ms debounce)
    debounce(searchQuery, (_) {
      getStudents();
    }, time: const Duration(milliseconds: 500));

    // Automatically refetch students when selected class changes
    ever(selectedClass, (_) {
      getStudents();
    });

    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      getStudents(isLoadMore: true);
    }
  }

  Future<void> getClasses() async {
    try {
      final response = await ApiClient.getData(ApiUrl.getteacherClassDistribute());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);
        
        if (jsonResponse['data'] != null) {
          final list = jsonResponse['data'] as List;
          final uniqueClasses = list
              .map((e) => e['classLevel']?.toString() ?? '')
              .where((element) => element.isNotEmpty)
              .toSet()
              .toList();
          
          myClass.value = ["All", ...uniqueClasses];
        }
      }
    } catch (e) {
      debugPrint('getClasses error: $e');
    }
  }

  Future<void> getStudents({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (isMoreStudentsLoading.value || !hasMoreStudents.value) return;
      isMoreStudentsLoading.value = true;
      studentsPage.value++;
    } else {
      isStudentsLoading.value = true;
      rxStudentsStatus.value = Status.loading;
      studentsPage.value = 1;
      hasMoreStudents.value = true;
    }

    try {
      final response = await ApiClient.getData(
        ApiUrl.getTeacherUnderStudents(
          page: studentsPage.value,
          className: selectedClass.value,
          name: searchQuery.value,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);
        final TeacherUnderStudentResponse model =
            TeacherUnderStudentResponse.fromJson(jsonResponse);

        if (model.data != null && model.data!.data != null) {
          if (isLoadMore) {
            studentList.addAll(model.data!.data!);
          } else {
            studentList.value = model.data!.data!;
          }

          if (model.data!.data!.isEmpty ||
              (model.data!.meta != null &&
                  model.data!.meta!.totalPage != null &&
                  studentsPage.value >= model.data!.meta!.totalPage!)) {
            hasMoreStudents.value = false;
          }
        } else {
          hasMoreStudents.value = false;
        }

        rxStudentsStatus.value = Status.completed;
      } else {
        rxStudentsStatus.value = Status.error;
        final Map<String, dynamic> errorResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to load students',
          isError: true,
        );
      }
    } catch (e) {
      rxStudentsStatus.value = Status.error;
      debugPrint('getStudents Error: $e');
      showCustomSnackBar('Error: ${e.toString()}', isError: true);
    } finally {
      if (isLoadMore) {
        isMoreStudentsLoading.value = false;
      } else {
        isStudentsLoading.value = false;
      }
    }
  }
}
