import 'package:america_ayber_squad/view/components/custom_loader/custom_loader.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../controller/teacher_create_exam_controller.dart';
import '../model/exam_list.dart';
import '../model/exam_grade_show.dart';

class TeacherViewResultsScreen extends StatelessWidget {
  TeacherViewResultsScreen({super.key});

  final TeacherCreateExamController controller =
      Get.find<TeacherCreateExamController>();

  void _showEditGradeDialog(BuildContext context, ExamList exam, ExamStudentGrade gradeRecord) {
    final marksInputController = TextEditingController(text: gradeRecord.marks?.toString() ?? "");
    final instructionsInputController = TextEditingController(text: gradeRecord.instructions ?? "");
    final formKey = GlobalKey<FormState>();

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: CustomText(
          text: "Update Grade",
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Student Profile Header Row
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    child: Icon(Icons.person, color: AppColors.primary, size: 20.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: gradeRecord.student?.name ?? 'Student',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.start,
                        ),
                        if (gradeRecord.student?.studentId != null) ...[
                          SizedBox(height: 2.h),
                          CustomText(
                            text: "ID: ${gradeRecord.student!.studentId}",
                            fontSize: 11.sp,
                            color: Colors.grey.shade500,
                            textAlign: TextAlign.start,
                          ),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: CustomText(
                    text: "Total Exam Marks: ${exam.totalMarks ?? '100'}",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              TextFormField(
                controller: marksInputController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Marks",
                  hintText: "Enter marks (e.g. 95)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return "Please enter marks";
                  }
                  final score = double.tryParse(val);
                  if (score == null) {
                    return "Please enter a valid number";
                  }
                  final totalMarks =
                      double.tryParse(exam.totalMarks ?? "100") ?? 100;
                  if (score > totalMarks) {
                    return "Marks cannot be greater than $totalMarks";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: instructionsInputController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Instructions",
                  hintText: "e.g. Good performance in the class test exam.",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          Obx(() {
            return ElevatedButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () async {
                      if (formKey.currentState!.validate()) {
                        // Use gradeRecord.id as studentId parameter as used in submission flow
                        final gradeRecordId = gradeRecord.id ?? "";
                        final success = await controller.updateStudentGrade(
                          studentId: gradeRecordId,
                          totalMarks: double.tryParse(exam.totalMarks ?? "100") ?? 100,
                          marks: double.tryParse(marksInputController.text) ?? 0,
                          instructions: instructionsInputController.text,
                        );
                        if (success) {
                          Get.back(); // Close dialog
                          if (exam.id != null) {
                            controller.fetchExamStudentGrades(exam.id!);
                          }
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: controller.isLoading.value
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text("Submit"),
            );
          }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ExamList exam = Get.arguments as ExamList;

    // Fetch grades on load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (exam.id != null) {
        controller.fetchExamStudentGrades(exam.id!);
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomRoyelAppbar(
        titleName: "Exam Results",
        leftIcon: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exam Header Info Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                border: Border.all(color: const Color(0xFFBFDBFE)),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: exam.examName ?? "N/A",
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: const Color(0xFF1E3A8A),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    text: "Topic: ${exam.topic ?? 'N/A'} | Total Marks: ${exam.totalMarks ?? 'N/A'}",
                    fontSize: 12.sp,
                    color: const Color(0xFF2563EB),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            CustomText(
              text: "Graded Student Submissions",
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 12.h),

            // Grades List
            Expanded(
              child: Obx(() {
                if (controller.isStudentGradesLoading.value) {
                  return const Center(child: CustomLoader());
                }

                if (controller.studentGrades.isEmpty) {
                  return const Center(
                    child: Text(
                      "No graded submissions found",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.studentGrades.length,
                  itemBuilder: (context, idx) {
                    final gradeRecord = controller.studentGrades[idx];
                    final studentName = gradeRecord.student?.name ?? "Student ${idx + 1}";
                    final studentId = gradeRecord.student?.studentId ?? "";

                    return Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: studentName,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                      textAlign: TextAlign.start,
                                    ),
                                    if (studentId.isNotEmpty) ...[
                                      SizedBox(height: 2.h),
                                      CustomText(
                                        text: "ID: $studentId",
                                        fontSize: 11.sp,
                                        color: Colors.grey.shade500,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: CustomText(
                                  text: "${gradeRecord.marks ?? 0} / ${gradeRecord.totalMarks ?? exam.totalMarks ?? 100}",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          if (gradeRecord.instructions != null && gradeRecord.instructions!.isNotEmpty) ...[
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Divider(color: Colors.grey.shade100, height: 1),
                            ),
                            CustomText(
                              text: "Feedback: ${gradeRecord.instructions}",
                              fontSize: 12.sp,
                              color: Colors.grey.shade600,
                              textAlign: TextAlign.start,
                              maxLines: 3,
                            ),
                          ],
                          SizedBox(height: 8.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                _showEditGradeDialog(context, exam, gradeRecord);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.5)),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.edit, size: 12.sp, color: AppColors.primary),
                                    SizedBox(width: 4.w),
                                    CustomText(
                                      text: "Edit Grade",
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
