import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_loader/custom_loader.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../../../components/custom_text_field/custom_text_field.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../controller/teacher_student_controller.dart';
import '../widget/teacher_my_student_card.dart';

class TeacherStudentScreen extends StatelessWidget {
  TeacherStudentScreen({super.key});

  final teacherStudentController = Get.find<TeacherStudentController>();

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: CustomRoyelAppbar(
          titleName: "My Students",
          leftIcon: true,
        ),
        body: SingleChildScrollView(
          controller: teacherStudentController.scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                // Subject Selector Dropdown
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
                  child: Row(
                    children: [
                      Icon(Icons.class_outlined,
                          color: AppColors.primary, size: 22.sp),
                      SizedBox(width: 12.w),
                      CustomText(
                        text: "Selected Class:",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black_03,
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Obx(() {
                            return DropdownButton<String>(
                              value:
                                  teacherStudentController.selectedClass.value,
                              icon: const Icon(Icons.keyboard_arrow_down,
                                  size: 18, color: Colors.grey),
                              dropdownColor: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.black),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  teacherStudentController.selectedClass.value =
                                      newValue;
                                }
                              },
                              items: teacherStudentController.myClass
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black)),
                                );
                              }).toList(),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                // Search Box
                CustomTextField(
                  fillColor: Colors.white,
                  fieldBorderColor: Colors.grey.shade300,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintText: "Search student name...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  onChanged: (value) {
                    teacherStudentController.searchQuery.value = value;
                  },
                ),

                SizedBox(
                  height: 20,
                ),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Students Directory
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: "Students Directory",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600),
                          ],
                        ),
                        SizedBox(height: 20),
                        Obx(() {
                          if (teacherStudentController.isStudentsLoading.value) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 30),
                                child: CustomLoader(),
                              ),
                            );
                          }
                          if (teacherStudentController.studentList.isEmpty) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 30),
                                child: CustomText(
                                  text: "No students found",
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          }
                          return Column(
                            children: [
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: teacherStudentController.studentList.length,
                                itemBuilder: (context, index) {
                                  final student = teacherStudentController.studentList[index];
                                  return TeacherMyStudentCard(
                                    phone: student.guardianPhone ?? "N/A",
                                    studentId: student.studentId ?? "N/A",
                                    email: student.email ?? "N/A",
                                    subject: student.name ?? "N/A",
                                    grade: student.className ?? "N/A",
                                    onTapView: () {},
                                  );
                                },
                              ),
                              if (teacherStudentController.isMoreStudentsLoading.value)
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Center(
                                    child: CustomLoader(),
                                  ),
                                ),
                            ],
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
      ),
    );
  }
}


