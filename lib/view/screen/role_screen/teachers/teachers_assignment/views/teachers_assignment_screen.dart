import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_nav_bar/teacher_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_tab_selected/custom_fill_tab_bar.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../controller/teacher_create_controller.dart';
import 'package:get/get.dart';
import '../../teachers_home/controller/teachers_controller.dart';
import '../widget/custom_create_assignment.dart';
import '../widget/custom_create_assignment_card.dart';
import 'package:america_ayber_squad/view/components/custom_loader/custom_loader.dart';
import 'package:intl/intl.dart';

class TeachersAssignmentScreen extends StatelessWidget {
  TeachersAssignmentScreen({super.key});

  final TeacherAssignmentController teacherCreateController =
      Get.find<TeacherAssignmentController>();
  final TeachersController teachersController =
      Get.find<TeachersController>();

  @override
  Widget build(BuildContext context) {
    // Initial fetch of schedules on load if list is empty
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (teachersController.allScheduleList.isEmpty) {
        teachersController.getTeacherSchedule();
      }
    });

    return CustomGradient(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              
              // --- Static Dropdown Block ---
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Select Class",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF374151),
                    ),
                    SizedBox(height: 8.h),
                    Obx(() {
                      final uniqueClasses = teachersController.allScheduleList
                          .map((e) => e.classLevel)
                          .where((c) => c != null && c.isNotEmpty)
                          .map((c) => c!)
                          .toSet()
                          .toList();

                      final itemsList = uniqueClasses
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          )
                          .toList();

                      final String? selectedClass = (teacherCreateController
                                      .selectedClassLevel.value !=
                                  null &&
                              uniqueClasses.contains(
                                  teacherCreateController
                                      .selectedClassLevel.value))
                          ? teacherCreateController.selectedClassLevel.value
                          : null;

                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: Colors.white,
                            value: selectedClass,
                            hint: Text(
                              "Select Class",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            isExpanded: true,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey.shade400,
                            ),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black87,
                            ),
                            onChanged: (String? val) {
                              if (val != null) {
                                teacherCreateController.selectedClassLevel.value = val;
                                final matchedSchedules = teachersController.allScheduleList
                                    .where((e) => e.classLevel == val)
                                    .toList();
                                if (matchedSchedules.isNotEmpty) {
                                  teacherCreateController.selectedClassId.value =
                                      matchedSchedules.first.id;
                                }
                                teacherCreateController.getAssignmentsList();
                              }
                            },
                            items: itemsList,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              
              SizedBox(height: 20.h),
              
              // --- Scrollable list and create assignment area ---
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => CustomFillTabBar(
                              tabs: const ["All", "Active", "Completed"],
                              selectedIndex:
                                  teacherCreateController.selectedIndex.value,
                              onTabSelected: teacherCreateController.changeTab,
                              selectedTextColor: AppColors.primary,
                              unselectedTextColor: Colors.grey,
                            )),
                        SizedBox(height: 20.h),
                        
                        GestureDetector(
                          onTap: () {
                            if (teacherCreateController.selectedClassId.value == null) {
                              Get.snackbar("Error", "Please select a Class/Subject first");
                              return;
                            }
                            showCreateAssignmentPopup(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: AppColors.white,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 5.w),
                                CustomText(
                                  text: "Create Assignment",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 20.h),
                        
                        // Assignments List View
                        Obx(() {
                          if (teacherCreateController.isGetLoading.value) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: CustomLoader(),
                              ),
                            );
                          }

                          if (teacherCreateController.assignments.isEmpty) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Text("No assignments found"),
                              ),
                            );
                          }

                          final now = DateTime.now();

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: teacherCreateController.assignments.length,
                            itemBuilder: (context, index) {
                              final assignment = teacherCreateController.assignments[index];
                              final title = assignment['assignmentTitle']?.toString() ?? "N/A";
                              final type = assignment['assignmentType']?.toString() ?? "Homework";
                              final classLevel = assignment['classLevel']?.toString() ?? "N/A";
                              
                              final dueStr = assignment['assignmentDueDate']?.toString() ?? "";
                              final dueDateTime = DateTime.tryParse(dueStr);
                              final formattedDate = dueDateTime != null 
                                  ? DateFormat('MMM d, yyyy').format(dueDateTime)
                                  : "N/A";
                              
                              final isCompleted = dueDateTime != null && dueDateTime.isBefore(now);

                              return CustomCreateAssignmentCard(
                                subject: title,
                                grade: classLevel,
                                submission: "0/0", // Default submission progress placeholder
                                time: formattedDate,
                                status: isCompleted ? "Completed" : "Active",
                                homeWork: type,
                                progressValue: isCompleted ? 100 : 0,
                                onTapEdit: () {},
                                onTapView: () {},
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: TeacherNavBar(currentIndex: 2),
      ),
    );
  }
}
