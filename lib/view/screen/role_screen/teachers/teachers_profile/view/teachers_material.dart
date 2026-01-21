import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../parents/widget/custom_parents_show_card.dart';
import '../../teachers_attendance/controller/teacher_attendence_controller.dart';
import '../controller/teachers_material_controller.dart';
import '../model/teachers_resource_model.dart';
import '../widget/custom_teachers_material_card.dart';

class TeachersMaterial extends StatelessWidget {
  TeachersMaterial({super.key});

  final TeachersMaterialController teachersMaterialController = Get.put(TeachersMaterialController());

  @override
  Widget build(BuildContext context) {
    final List<TeachersResourceModel> resources = [
      TeachersResourceModel(
        fileName: "Mathematics Formula Sheet",
        size: "1.2 MB",
        subject: "Mathematics",
        type: "PDF",
        date: "Dec 01, 2024",
        icon: Icons.description_outlined,
        color: Colors.green,
      ),
      TeachersResourceModel(
        fileName: "Physics Lecture: Newton's Laws",
        size: "450 MB",
        subject: "Physics",
        type: "Video",
        date: "Nov 28, 2024",
        icon: Icons.videocam_outlined,
        color: Colors.teal,
      ),
      TeachersResourceModel(
        fileName: "Chemistry Lab Safety Guidelines",
        size: "800 KB",
        subject: "Chemistry",
        type: "PDF",
        date: "Sep 15, 2024",
        icon: Icons.description_outlined,
        color: Colors.green,
      ),
      TeachersResourceModel(
        fileName: "Shakespeare's Works Archive",
        size: "N/A",
        subject: "English",
        type: "Link",
        date: "Oct 10, 2024",
        icon: Icons.link,
        color: Colors.blue,
      ),
      TeachersResourceModel(
        fileName: "Programming Basics 101",
        size: "15 MB",
        subject: "Computer Science",
        type: "ZIP",
        date: "Nov 05, 2024",
        icon: Icons.folder_open_outlined,
        color: Colors.orange,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomRoyelAppbar(
        titleName: "Learning Materials",
        leftIcon: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
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
                            children: [
                              Icon(Icons.calendar_today_outlined, size: 20.sp, color: Colors.black87),
                              SizedBox(width: 12.w),
                              CustomText(
                                text: "January 21st, 2026",
                                fontSize: 14.sp,
                                color: Colors.black87,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              //Card View
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CustomParentsShowCard(
                      count: "PDF Document",
                      label: "3",
                      icon: Icons.assignment,
                    ),
                    SizedBox(width: 12),
                    //Children
                    CustomParentsShowCard(
                      count: "Word Document",
                      label: "2",
                      icon: Icons.description_outlined,
                    ),
                    SizedBox(width: 12),
                    //Ave Attendance
                    CustomParentsShowCard(
                      count: "Play File",
                      label: "95",
                      icon: Icons.play_arrow_outlined,
                    ),
                    SizedBox(width: 12),
                    CustomParentsShowCard(
                      count: "External link",
                      label: "95",
                      icon: Icons.link,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              //Course material
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(text: "Course Materials", fontSize: 16, fontWeight: FontWeight.w600),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.add, size: 18, color: Colors.white,),
                                CustomText(text: "Add New Materials", fontSize: 12, left: 5, color: Colors.white, fontWeight: FontWeight.w500),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),
                      SizedBox(height: 10,),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                          final item = resources[index];
                          return CustomTeachersMaterialCard(item: item);
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
    );
  }
}