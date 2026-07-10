import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:america_ayber_squad/view/components/custom_loader/custom_loader.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import '../../teachers_home/controller/teachers_controller.dart';
import '../../teachers_home/model/teacher_schedule.dart';
import '../controller/teachers_material_controller.dart';
import '../widget/custom_teachers_material_card.dart';
import 'add_material_screen.dart';

class TeachersMaterial extends StatelessWidget {
  TeachersMaterial({super.key});

  final TeachersMaterialController teachersMaterialController =
      Get.find<TeachersMaterialController>();
  final TeachersController teachersController = Get.find<TeachersController>();

  @override
  Widget build(BuildContext context) {
    // Initial fetch of schedules on load if list is empty
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (teachersController.allScheduleList.isEmpty) {
        await teachersController.getTeacherSchedule();
      }
      // Set default class distribution if not set
      final uniqueSchedules = teachersController.allScheduleList
          .where((e) => e.classLevel != null && e.classLevel!.isNotEmpty)
          .toList();

      if (teachersMaterialController.selectedClassId.value == null && uniqueSchedules.isNotEmpty) {
        final matched = uniqueSchedules.first;
        teachersMaterialController.selectedClassLevel.value = matched.classLevel;
        teachersMaterialController.selectedClassId.value = matched.id ?? matched.classDistributionId ?? "";
        teachersMaterialController.getMaterialsList();
      } else if (teachersMaterialController.selectedClassId.value != null) {
        teachersMaterialController.getMaterialsList();
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomRoyelAppbar(
        titleName: "Learning Materials",
        leftIcon: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            children: [
              // Dropdown Selection Container
              Container(
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
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Select Class Dropdown ---
                      CustomText(
                        text: "Select Class",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF374151),
                      ),
                      SizedBox(height: 8.h),
                      Obx(() {
                        final uniqueSchedules = teachersController.allScheduleList
                            .where((e) => e.classLevel != null && e.classLevel!.isNotEmpty)
                            .toList();

                        final String? selectedId = (teachersMaterialController.selectedClassId.value != null &&
                                uniqueSchedules.any((e) => (e.id ?? e.classDistributionId ?? "") == teachersMaterialController.selectedClassId.value))
                            ? teachersMaterialController.selectedClassId.value
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
                              value: selectedId,
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
                              onChanged: (String? newValueId) {
                                if (newValueId != null) {
                                  final matched = uniqueSchedules.firstWhere((e) => (e.id ?? e.classDistributionId ?? "") == newValueId);
                                  teachersMaterialController.selectedClassId.value = newValueId;
                                  teachersMaterialController.selectedClassLevel.value = matched.classLevel;
                                  teachersMaterialController.getMaterialsList();
                                }
                              },
                              items: uniqueSchedules
                                  .map<DropdownMenuItem<String>>(
                                    (RoutineModel routine) {
                                      final id = routine.id ?? routine.classDistributionId ?? "";
                                      final classText = "${routine.classLevel ?? ''} - ${routine.assignableSubject ?? ''}";
                                      return DropdownMenuItem<String>(
                                        value: id,
                                        child: Text(
                                          classText,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                  .toList(),
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: 16.h),
                      InkWell(
                        onTap: () {
                          Get.to(() => AddMaterialScreen());
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 18.sp,
                                color: Colors.white,
                              ),
                              CustomText(
                                text: "Add New Materials",
                                fontSize: 14.sp,
                                left: 8.w,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Course Materials Container
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Course Materials",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),

                      // Materials list loader / view builder
                      Obx(() {
                        if (teachersMaterialController.isGetLoading.value) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 30),
                              child: CustomLoader(),
                            ),
                          );
                        }

                        final list = teachersMaterialController.materialsList;

                        if (list.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 40.h),
                              child: Column(
                                children: [
                                  Icon(Icons.folder_open_outlined,
                                      size: 48.sp, color: Colors.grey.shade300),
                                  SizedBox(height: 12.h),
                                  CustomText(
                                    text: "No materials uploaded for this class",
                                    fontSize: 14.sp,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            final item = list[index];
                            return CustomTeachersMaterialCard(item: item);
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
