import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_nav_bar/teacher_nav_bar.dart';
import 'package:america_ayber_squad/view/screen/role_screen/teachers/teachers_attendance/controller/teacher_attendence_controller.dart';
import 'package:america_ayber_squad/view/screen/role_screen/teachers/teachers_attendance/widgets/custom_attendance_card_teacher.dart';
import 'package:america_ayber_squad/view/screen/role_screen/teachers/teachers_attendance/widgets/custom_teachers_attendance_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../teachers_home/model/teacher_schedule.dart';
import '../teachers_home/controller/teachers_controller.dart';

class TeachersAttendanceScreen extends StatefulWidget {
  const TeachersAttendanceScreen({super.key});

  @override
  State<TeachersAttendanceScreen> createState() => _TeachersAttendanceScreenState();
}

class _TeachersAttendanceScreenState extends State<TeachersAttendanceScreen> {
  final TeacherAttendanceController teacherAttendanceController = Get.find<TeacherAttendanceController>();
  final TeachersController teachersController = Get.find<TeachersController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      teacherAttendanceController.resetState();
      teachersController.getTeacherSchedule();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                // select class
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

                          final String? selectedId = (teacherAttendanceController.selectedSchedule.value != null &&
                                  teachersController.allScheduleList.any((e) => e.id == teacherAttendanceController.selectedSchedule.value?.id))
                              ? teacherAttendanceController.selectedSchedule.value?.id
                              : null;

                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
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
                                onChanged: (String? newId) {
                                  if (newId != null) {
                                    final selected = teachersController.allScheduleList.firstWhere((e) => e.id == newId);
                                    teacherAttendanceController.selectClass(selected);
                                  }
                                },
                                items: itemsList,
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: 8.h),
                        CustomText(
                          text: "Select Date",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF374151),
                        ),
                        SizedBox(height: 8.h),
                        InkWell(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: teacherAttendanceController.selectedDate.value,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null) {
                              teacherAttendanceController.selectedDate.value = picked;
                              teacherAttendanceController.getAttenddenceSheet();
                            }
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
                                Obx(() => CustomText(
                                  text: DateFormat('MMMM d, yyyy').format(teacherAttendanceController.selectedDate.value),
                                  fontSize: 14.sp,
                                  color: Colors.black87,
                                )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                //card show
                Obx(() {
                  if (teacherAttendanceController.selectedSchedule.value == null) {
                    return const SizedBox.shrink();
                  }
                  int presentCount = teacherAttendanceController.studentStatus.values.where((v) => v.toLowerCase() == 'present').length;
                  int absentCount = teacherAttendanceController.studentStatus.values.where((v) => v.toLowerCase() == 'absent').length;
                  int lateCount = teacherAttendanceController.studentStatus.values.where((v) => v.toLowerCase() == 'late').length;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTeachersAttendanceCard(
                        count: "Present",
                        label: "$presentCount",
                        icon: Icons.people,
                      ),
                      const SizedBox(width: 12),
                      CustomTeachersAttendanceCard(
                        count: "Absent",
                        label: "$absentCount",
                        icon: Icons.people,
                      ),
                      const SizedBox(width: 12),
                      CustomTeachersAttendanceCard(
                        count: "Late",
                        label: "$lateCount",
                        icon: Icons.alarm,
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 20),
                // attendance sheet
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
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        //attendance
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(text: "Attendance Sheet", fontSize: 15.sp, fontWeight: FontWeight.w600),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                // Save attendance API action goes here
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: CustomText(
                                  text: "Save Attendance",
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Obx(() {
                          if (teacherAttendanceController.selectedSchedule.value == null) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: CustomText(
                                  text: "No attendance data to show",
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          }
                          if (teacherAttendanceController.isAttendanceLoading.value) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: CircularProgressIndicator(color: AppColors.primary),
                              ),
                            );
                          }
                          if (teacherAttendanceController.attendanceSheet.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: CustomText(
                                  text: "No students found in this class",
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          }

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: teacherAttendanceController.attendanceSheet.length,
                            itemBuilder: (context, index) {
                              final student = teacherAttendanceController.attendanceSheet[index];
                              final studentId = student.studentId ?? '';

                              return Obx(() {
                                final currentStatus = teacherAttendanceController.studentStatus[studentId] ?? '';
                                return CustomAttendanceCardTeacher(
                                  parentsName: student.staffs?.name ?? "N/A",
                                  name: student.name ?? "N/A",
                                  number: student.staffs?.phoneNumber ?? "N/A",
                                  email: student.staffs?.email ?? "N/A",

                                  isPresent: currentStatus.toLowerCase() == 'present',
                                  isAbsent: currentStatus.toLowerCase() == 'absent',
                                  isLate: currentStatus.toLowerCase() == 'late',

                                  onTapPresent: () => teacherAttendanceController.setStatus(studentId, 'Present'),
                                  onTapAbsent: () => teacherAttendanceController.setStatus(studentId, 'Absent'),
                                  onTapLate: () => teacherAttendanceController.setStatus(studentId, 'Late'),
                                  onTapMail: () {
                                    // navigate to mail / message screen
                                  },
                                );
                              });
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
        bottomNavigationBar: const TeacherNavBar(currentIndex: 1),
      ),
    );
  }
}
