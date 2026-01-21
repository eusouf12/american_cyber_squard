import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_nav_bar/teacher_nav_bar.dart';
import 'package:america_ayber_squad/view/screen/role_screen/teachers/teachers_attendance/controller/teacher_attendence_controller.dart';
import 'package:america_ayber_squad/view/screen/role_screen/teachers/teachers_attendance/widgets/custom_attendance_card_teacher.dart';
import 'package:america_ayber_squad/view/screen/role_screen/teachers/teachers_attendance/widgets/custom_teachers_attendance_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_text/custom_text.dart';

class TeachersAttendanceScreen extends StatelessWidget {
   TeachersAttendanceScreen({super.key});
  final TeacherAttendanceController teacherAttendanceController = Get.put(TeacherAttendanceController());


  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                SizedBox(height: 40),
                // select class
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
                              value: teacherAttendanceController.selectedClass.value,
                              isExpanded: true,
                              icon: Icon(
                                teacherAttendanceController.isOpen.value
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.grey.shade400,
                              ),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black87,
                              ),
                              onTap: () {
                                teacherAttendanceController.isOpen.toggle();
                              },
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  teacherAttendanceController.selectedClass.value = newValue;
                                  teacherAttendanceController.isOpen.value = false;
                                }
                              },
                              items: teacherAttendanceController.classList
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
                SizedBox(height: 20),
                //card show
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTeachersAttendanceCard(
                      count: "Present",
                      label:"10",
                      icon: Icons.people,
                    ),
                    SizedBox(width: 12),
                    //Children
                    CustomTeachersAttendanceCard(
                      count: "Absent",
                      label:"3",
                      icon: Icons.people,
                    ),
                    SizedBox(width: 12),
                    //Ave Attendance
                    CustomTeachersAttendanceCard(
                      count: "Late",
                      label: "1",
                      icon: Icons.alarm,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // attendance sheet
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
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        //attendance
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(text: "Attendance Sheet", fontSize: 15.sp, fontWeight: FontWeight.w600),
                            Spacer(),
                            GestureDetector(
                                onTap: (){

                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                    decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: CustomText(text: "Save Attendance", fontSize: 10.sp, fontWeight: FontWeight.w500,color: AppColors.white,)
                                )
                            ),

                          ],
                        ),
                        SizedBox(height: 20),
                        Obx(
                              () => ListView(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  CustomAttendanceCardTeacher(
                                    parentsName: "Mr. Rahman",
                                    name: "Ayan Rahman",
                                    number: "017XXXXXXXX",
                                    email: "ayan@gmail.com",

                                    /// state from controller
                                    isPresent: teacherAttendanceController.isPresent,
                                    isAbsent: teacherAttendanceController.isAbsent,
                                    isLate: teacherAttendanceController.isLate,

                                    /// actions
                                    onTapPresent: () =>
                                        teacherAttendanceController.selectStatus(0),
                                    onTapAbsent: () =>
                                        teacherAttendanceController.selectStatus(1),
                                    onTapLate: () =>
                                        teacherAttendanceController.selectStatus(2),

                                    onTapMail: () {
                                      // navigate to mail / message screen
                                      // Get.to(() => SendMailScreen());
                                    },
                                  ),
                                  CustomAttendanceCardTeacher(
                                    parentsName: "Mr. Rahman",
                                    name: "Ayan Rahman",
                                    number: "017XXXXXXXX",
                                    email: "ayan@gmail.com",

                                    /// state from controller
                                    isPresent: teacherAttendanceController.isPresent,
                                    isAbsent: teacherAttendanceController.isAbsent,
                                    isLate: teacherAttendanceController.isLate,

                                    /// actions
                                    onTapPresent: () =>
                                        teacherAttendanceController.selectStatus(0),
                                    onTapAbsent: () =>
                                        teacherAttendanceController.selectStatus(1),
                                    onTapLate: () =>
                                        teacherAttendanceController.selectStatus(2),

                                    onTapMail: () {
                                      // navigate to mail / message screen
                                      // Get.to(() => SendMailScreen());
                                    },
                                  ),
                                  CustomAttendanceCardTeacher(
                                    parentsName: "Mr. Rahman",
                                    name: "Ayan Rahman",
                                    number: "017XXXXXXXX",
                                    email: "ayan@gmail.com",

                                    /// state from controller
                                    isPresent: teacherAttendanceController.isPresent,
                                    isAbsent: teacherAttendanceController.isAbsent,
                                    isLate: teacherAttendanceController.isLate,

                                    /// actions
                                    onTapPresent: () =>
                                        teacherAttendanceController.selectStatus(0),
                                    onTapAbsent: () =>
                                        teacherAttendanceController.selectStatus(1),
                                    onTapLate: () =>
                                        teacherAttendanceController.selectStatus(2),

                                    onTapMail: () {
                                      // navigate to mail / message screen
                                      // Get.to(() => SendMailScreen());
                                    },
                                  ),
                                  CustomAttendanceCardTeacher(
                                    parentsName: "Mr. Rahman",
                                    name: "Ayan Rahman",
                                    number: "017XXXXXXXX",
                                    email: "ayan@gmail.com",

                                    /// state from controller
                                    isPresent: teacherAttendanceController.isPresent,
                                    isAbsent: teacherAttendanceController.isAbsent,
                                    isLate: teacherAttendanceController.isLate,

                                    /// actions
                                    onTapPresent: () =>
                                        teacherAttendanceController.selectStatus(0),
                                    onTapAbsent: () =>
                                        teacherAttendanceController.selectStatus(1),
                                    onTapLate: () =>
                                        teacherAttendanceController.selectStatus(2),

                                    onTapMail: () {
                                      // navigate to mail / message screen
                                      // Get.to(() => SendMailScreen());
                                    },
                                  ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: TeacherNavBar(currentIndex: 1),
      ),
    );
  }
}
