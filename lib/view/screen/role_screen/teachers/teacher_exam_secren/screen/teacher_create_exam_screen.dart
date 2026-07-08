import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../teachers_home/controller/teachers_controller.dart';
import '../../teachers_home/model/teacher_schedule.dart';
import '../controller/teacher_create_exam_controller.dart';

class TeacherCreateExamScreen extends StatelessWidget {
  TeacherCreateExamScreen({super.key});

  final TeacherCreateExamController controller = Get.find<TeacherCreateExamController>();
  final TeachersController teachersController = Get.find<TeachersController>();

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey.shade400),
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: CustomRoyelAppbar(
        titleName: controller.isEditing.value ? "Edit Exam" : "Create Exam",
        leftIcon: true,
      ),
      body: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Select Class (Dropdown) ---
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Select Class",
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF374151),
                        ),
                        SizedBox(height: 6.h),
                        Obx(() {
                          final itemsList = teachersController.allScheduleList
                              .map<DropdownMenuItem<String>>(
                                (RoutineModel value) =>
                                    DropdownMenuItem<String>(
                                  value: value.id,
                                  child: Text(
                                    "${value.assignableSubject ?? ''} - ${value.classLevel ?? ''}",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              )
                              .toList();

                          final String? selectedId = (controller
                                          .selectedClassDistributionId.value !=
                                      null &&
                                  teachersController.allScheduleList.any((e) =>
                                      e.id ==
                                      controller
                                          .selectedClassDistributionId.value))
                              ? controller.selectedClassDistributionId.value
                              : null;

                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                dropdownColor: Colors.white,
                                value: selectedId,
                                hint: Text(
                                  "Select Class/Subject",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                isExpanded: true,
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.grey.shade400,
                                ),
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black87,
                                ),
                                onChanged: (String? newId) {
                                  if (newId != null) {
                                    controller.selectedClassDistributionId
                                        .value = newId;
                                  }
                                },
                                items: itemsList,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // --- Row: Exam Name & Exam Date ---
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Exam Name",
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF374151),
                        ),
                        SizedBox(height: 6.h),
                        TextField(
                          controller: controller.examNameController,
                          decoration: _buildInputDecoration(
                              "e.g., Mid-Term Mathematics"),
                        ),
                      ],
                    ),
                    SizedBox(width: 12.w),
                    SizedBox(height: 16.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Exam Date",
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF374151),
                        ),
                        SizedBox(height: 6.h),
                        InkWell(
                          onTap: () => controller.selectDate(context),
                          child: IgnorePointer(
                            child: TextField(
                              controller: controller.examDateController,
                              decoration:
                                  _buildInputDecoration("mm/dd/yyyy").copyWith(
                                suffixIcon: Icon(Icons.calendar_today_outlined,
                                    size: 16.sp, color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // --- Chapter/Topic ---
                    CustomText(
                      text: "Chapter/Topic",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF374151),
                    ),
                    SizedBox(height: 6.h),
                    TextField(
                      controller: controller.topicController,
                      decoration: _buildInputDecoration("e.g., Chapter 1-5"),
                    ),
                    SizedBox(height: 16.h),

                    // --- Total Marks ---
                    CustomText(
                      text: "Total Marks",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF374151),
                    ),
                    SizedBox(height: 6.h),
                    TextField(
                      controller: controller.marksController,
                      keyboardType: TextInputType.number,
                      decoration: _buildInputDecoration("e.g., 100"),
                    ),
                    SizedBox(height: 16.h),

                    // --- Duration (minutes) ---
                    CustomText(
                      text: "Duration (minutes)",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF374151),
                    ),
                    SizedBox(height: 6.h),
                    TextField(
                      controller: controller.durationController,
                      keyboardType: TextInputType.number,
                      decoration: _buildInputDecoration("e.g., 60"),
                    ),
                    SizedBox(height: 20.h),

                    // --- Instructions ---
                    CustomText(
                      text: "Instructions",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF374151),
                    ),
                    SizedBox(height: 8.h),
                    TextField(
                      controller: controller.instructionsController,
                      maxLines: 5,
                      decoration:
                          _buildInputDecoration("Enter exam instructions..."),
                    ),
                    SizedBox(height: 30.h),

                    // --- Submit Button ---
                    CustomButton(
                      onTap: controller.submitExam,
                      title: controller.isEditing.value ? "Update Exam" : "Submit Exam",
                      height: 48.h,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      fillColor: AppColors.primary,
                      textColor: Colors.white,
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              if (controller.isLoading.value)
                Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                ),
            ],
          ),
    ));
  }
}
