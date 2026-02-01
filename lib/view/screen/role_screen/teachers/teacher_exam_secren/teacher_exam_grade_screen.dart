import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_nav_bar/teacher_nav_bar.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../parents/widget/custom_parents_show_card.dart';
import '../teachers_profile/controller/teachers_material_controller.dart';
import '../teachers_profile/model/teachers_resource_model.dart';
import '../teachers_profile/widget/custom_teacher_exam_card.dart';
import '../teachers_profile/widget/custom_teachers_material_card.dart';

class TeacherExamGradeScreen extends StatelessWidget {
  TeacherExamGradeScreen({super.key});

  final TeachersMaterialController teachersMaterialController = Get.put(TeachersMaterialController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomRoyelAppbar(titleName: "Exam & Grades ", leftIcon: false,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              //Card View
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CustomParentsShowCard(
                      count: "Upcoming Exams",
                      label: "3",
                      icon: Icons.calendar_today_outlined,
                    ),
                    SizedBox(width: 12),
                    //Children
                    CustomParentsShowCard(
                      count: "Completed",
                      label: "2",
                      icon: Icons.access_time,
                    ),
                    SizedBox(width: 12),
                    //Ave Attendance
                    CustomParentsShowCard(
                      count: "Pending Grading",
                      label: "95",
                      icon: Icons.access_time,
                    ),
                    SizedBox(width: 12),
                    CustomParentsShowCard(
                      count: "Total Students",
                      label: "95",
                      icon: Icons.people,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
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
                      Obx(() => Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 2.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: teachersMaterialController.selectedClass.value,
                            isExpanded: true,
                            icon: Icon(
                              teachersMaterialController.isOpen.value
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: Colors.grey.shade400,
                            ),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black87,
                            ),
                            onTap: () {
                              teachersMaterialController.isOpen.toggle();
                            },
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                teachersMaterialController.selectedClass.value = newValue;
                                teachersMaterialController.isOpen.value = false;
                              }
                            },
                            items: teachersMaterialController.classList
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
                                .toList(),
                          ),
                        ),
                      )),
                      SizedBox(height: 8.h),
                      CustomText(
                        text: "Select Date",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF374151),
                      ),
                      SizedBox(height: 8.h),
                      InkWell(
                        onTap: () {

                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Section A",
                                fontSize: 14.sp,
                                color: Colors.black87,
                              ),
                              SizedBox(width: 12.w),
                              Icon(Icons.keyboard_arrow_down, size: 20.sp, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              //Exam & Grades
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: "Exam & Grades Managements", fontSize: 14.sp, fontWeight: FontWeight.w600),
                      SizedBox(height: 20),
                      GestureDetector(
                          onTap: (){

                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 6,vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, color: AppColors.white,size: 20,),
                                  SizedBox(width: 5),
                                  CustomText(text: "Create Exam", fontSize: 14.sp, fontWeight: FontWeight.w500,color: AppColors.white,),
                                ],
                              )
                          )
                      ),
                      SizedBox(height: 20),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return CustomTeacherExamCard(
                            submission: index== 0 || index == 4 ?"28/28" :index== 1 ? "0/28" : "25/28",
                            status: index== 0 || index == 4 ?"Completed" :index== 1 ? "Pending" : "Upcoming",
                            date: "March 15,2026",
                            subject:index== 0 || index == 4 ?"Quiz _ Algebra" :index== 1 ? "Final Exam" : "Mid-term Mathematics",
                            grade: "Chapter 1-5",
                            onTapView: () {  },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
        bottomNavigationBar: TeacherNavBar(currentIndex: 3)
    );
  }
}