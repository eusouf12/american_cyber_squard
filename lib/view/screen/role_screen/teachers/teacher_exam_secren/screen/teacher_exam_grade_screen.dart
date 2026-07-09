import 'package:america_ayber_squad/view/components/custom_loader/custom_loader.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:america_ayber_squad/core/app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_nav_bar/teacher_nav_bar.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../teachers_home/controller/teachers_controller.dart';
import '../../teachers_home/model/teacher_schedule.dart';
import '../controller/teacher_create_exam_controller.dart';
import '../model/exam_list.dart';
import '../../teachers_attendance/widgets/custom_teachers_attendance_card.dart';
import '../../teachers_profile/widget/custom_teacher_exam_card.dart';

class TeacherExamGradeScreen extends StatelessWidget {
  TeacherExamGradeScreen({super.key});

  final TeacherCreateExamController controller =
      Get.find<TeacherCreateExamController>();
  final TeachersController teachersController = Get.find<TeachersController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomRoyelAppbar(
        titleName: "Exam & Grades ",
        leftIcon: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              // --- Select Class & Date selectors (moved to top) ---
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
                        final itemsList = teachersController.allScheduleList
                            .map<DropdownMenuItem<String>>(
                              (RoutineModel value) => DropdownMenuItem<String>(
                                value: value.id,
                                child: Text(
                                  "${value.assignableSubject ?? ''} - ${value.classLevel ?? ''}",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            )
                            .toList();

                        final String? selectedId = (controller
                                        .selectedClassId.value !=
                                    null &&
                                teachersController.allScheduleList.any((e) =>
                                    e.id == controller.selectedClassId.value))
                            ? controller.selectedClassId.value
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
                                "Select Class/Subject",
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
                              onChanged: (String? newId) {
                                if (newId != null) {
                                  controller.selectedClassId.value = newId;
                                  final selected = teachersController
                                      .allScheduleList
                                      .firstWhere((e) => e.id == newId);
                                  controller.getExamsList(
                                    className: selected.classLevel,
                                    subject: selected.assignableSubject,
                                  );
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
              ),
              SizedBox(height: 20),

              // --- Card View (Row of Expanded metrics cards) ---
              Obx(() {
                final int completed =
                    controller.statusCount.value?.completed ?? 0;
                final int upcoming =
                    controller.statusCount.value?.upcoming ?? 0;
                final int pending = controller.statusCount.value?.pending ?? 0;
                final int total = completed + upcoming + pending;
                return Row(
                  children: [
                    Expanded(
                      child: CustomTeachersAttendanceCard(
                        count: "Upcoming",
                        label: "$upcoming",
                        icon: Icons.calendar_today_outlined,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: CustomTeachersAttendanceCard(
                        count: "Completed",
                        label: "$completed",
                        icon: Icons.check_circle_outline,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: CustomTeachersAttendanceCard(
                        count: "Pending",
                        label: "$pending",
                        icon: Icons.pending_actions,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: CustomTeachersAttendanceCard(
                        count: "Total",
                        label: "$total",
                        icon: Icons.people,
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: 20),

              //Exam & Grades
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          text: "Exam & Grades Managements",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {
                          controller.clearFields(); // Clear any previous editing values
                          final result = await Get.toNamed(
                              AppRoutes.teacherCreateExamScreen);
                          if (result == true) {
                            controller.getExamsList();
                          }
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, color: AppColors.white, size: 20),
                              SizedBox(width: 5),
                              CustomText(
                                text: "Create Exam",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Obx(() {
                        if (controller.isExamLoading.value) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: CustomLoader(),
                            ),
                          );
                        }
                        if (controller.exams.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                "No exams found",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.exams.length,
                          itemBuilder: (context, index) {
                            final ExamList exam = controller.exams[index];
                            return CustomTeacherExamCard(
                              isCompleted: exam.isCompleted,
                              date: exam.examDate ?? "",
                              subject: exam.examName ?? "N/A",
                              grade: exam.topic ?? "N/A",
                              duration: exam.duration,
                              totalMarks: exam.totalMarks,
                              onTapView: () {},
                              onTapGrade: () {
                                if (exam.id != null) {
                                  Get.toNamed(
                                    AppRoutes.teacherStudentSubmissionsScreen,
                                    arguments: exam,
                                  );
                                }
                              },
                              onTapEdit: () async {
                                controller.setupEditMode(exam);
                                final result = await Get.toNamed(
                                    AppRoutes.teacherCreateExamScreen);
                                if (result == true) {
                                  controller.getExamsList();
                                }
                              },
                              onTapDelete: () {
                                Get.dialog(
                                  AlertDialog(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    title: const Text("Delete Exam"),
                                    content: const Text(
                                        "Are you sure you want to delete this exam announcement?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: const Text("Cancel",
                                            style: TextStyle(color: Colors.grey)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                          if (exam.id != null) {
                                            controller.deleteExam(exam.id!);
                                          }
                                        },
                                        child: const Text("Delete",
                                            style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
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
      bottomNavigationBar: TeacherNavBar(currentIndex: 3),
    );
  }
}
