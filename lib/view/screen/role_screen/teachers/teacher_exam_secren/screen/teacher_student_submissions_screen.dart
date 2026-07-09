import 'package:america_ayber_squad/view/components/custom_loader/custom_loader.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../controller/teacher_create_exam_controller.dart';
import '../model/exam_list.dart';
import '../model/exam_perticipent.dart';

class TeacherStudentSubmissionsScreen extends StatelessWidget {
  TeacherStudentSubmissionsScreen({super.key});

  final TeacherCreateExamController controller =
      Get.find<TeacherCreateExamController>();

  void _showGradeInputModel(
      BuildContext context, ExamList exam, ExamParticipant participant) {
    final marksInputController = TextEditingController();
    final instructionsInputController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: CustomText(
          text: "Grade ${participant.name ?? 'Student'}",
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
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
                  final totalMarks = double.tryParse(exam.totalMarks ?? "100") ?? 100;
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
                        final studentId = participant.id ?? "";
                        final success = await controller.submitStudentGrade(
                          examAnnouncementId: exam.id ?? "",
                          studentId: studentId,
                          totalMarks:
                              double.tryParse(exam.totalMarks ?? "100") ?? 100,
                          marks:
                              double.tryParse(marksInputController.text) ?? 0,
                          instructions: instructionsInputController.text,
                        );
                        if (success) {
                          Get.back(); // Close dialog
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

    // Trigger participants load on screen enter
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (exam.id != null) {
        controller.getExamParticipants(exam.id!);
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomRoyelAppbar(
        titleName: "Grade Exam",
        leftIcon: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBEB),
                border: Border.all(color: const Color(0xFFFDE68A)),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline,
                          color: const Color(0xFFD97706), size: 18.sp),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: CustomText(
                          text: exam.examName ?? "N/A",
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: const Color(0xFF92400E),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Obx(() {
                    final count = controller.participants.length;
                    return CustomText(
                      text:
                          "Total Registered: $count students. Please review and grade all student submissions.",
                      fontSize: 12.sp,
                      color: const Color(0xFFB45309),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            CustomText(
              text: "Student Submissions",
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 12.h),

            // Student List
            Expanded(
              child: Obx(() {
                if (controller.isParticipantLoading.value) {
                  return const Center(child: CustomLoader());
                }

                if (controller.participants.isEmpty) {
                  return const Center(
                    child: Text(
                      "No student submissions or participants found",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.participants.length,
                  itemBuilder: (context, idx) {
                    final participant = controller.participants[idx];
                    final studentName =
                        participant.name ?? "Student ${idx + 1}";
                    final studentId = participant.studentId ?? "";

                    return Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
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
                                  SizedBox(height: 4.h),
                                  CustomText(
                                    text: "ID: $studentId",
                                    fontSize: 12.sp,
                                    color: Colors.grey.shade500,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _showGradeInputModel(context, exam, participant);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00A36C),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
                            ),
                            child: const Text("Grade"),
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
