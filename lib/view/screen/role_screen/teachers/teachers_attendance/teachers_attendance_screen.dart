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

class TeachersAttendanceScreen extends StatelessWidget {
  TeachersAttendanceScreen({super.key});

  final TeacherAttendanceController teacherAttendanceController =
      Get.find<TeacherAttendanceController>();
  final TeachersController teachersController = Get.find<TeachersController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      teacherAttendanceController.resetState();
      teachersController.getTeacherSchedule();
    });

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
                                (RoutineModel value) =>
                                    DropdownMenuItem<String>(
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

                          final String? selectedId =
                              (teacherAttendanceController
                                              .selectedSchedule.value !=
                                          null &&
                                      teachersController.allScheduleList.any(
                                          (e) =>
                                              e.id ==
                                              teacherAttendanceController
                                                  .selectedSchedule.value?.id))
                                  ? teacherAttendanceController
                                      .selectedSchedule.value?.id
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
                                    final selected = teachersController
                                        .allScheduleList
                                        .firstWhere((e) => e.id == newId);
                                    teacherAttendanceController
                                        .selectClass(selected);
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
                              initialDate: teacherAttendanceController
                                      .selectedDate.value
                                      .isAfter(DateTime.now())
                                  ? DateTime.now()
                                  : teacherAttendanceController
                                      .selectedDate.value,
                              firstDate: DateTime(2020),
                              lastDate: DateTime
                                  .now(), // Disable future dates, enable today and past dates
                            );
                            if (picked != null) {
                              teacherAttendanceController.selectedDate.value =
                                  picked;
                              teacherAttendanceController.getAttenddenceSheet();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 12.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today_outlined,
                                    size: 20.sp, color: Colors.black87),
                                SizedBox(width: 12.w),
                                Obx(() => CustomText(
                                      text: DateFormat('MMMM d, yyyy').format(
                                          teacherAttendanceController
                                              .selectedDate.value),
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
                  if (teacherAttendanceController.selectedSchedule.value ==
                      null) {
                    return const SizedBox.shrink();
                  }
                  int totalCount = teacherAttendanceController.attendanceSheet.length;
                  int presentCount = teacherAttendanceController
                      .studentStatus.values
                      .where((v) => v.toLowerCase() == 'present')
                      .length;
                  int absentCount = teacherAttendanceController
                      .studentStatus.values
                      .where((v) => v.toLowerCase() == 'absent')
                      .length;
                  int lateCount = teacherAttendanceController
                      .studentStatus.values
                      .where((v) => v.toLowerCase() == 'late')
                      .length;

                   return Row(
                     children: [
                       Expanded(
                         child: CustomTeachersAttendanceCard(
                           count: "Total",
                           label: "$totalCount",
                           icon: Icons.groups,
                         ),
                       ),
                       SizedBox(width: 8.w),
                       Expanded(
                         child: CustomTeachersAttendanceCard(
                           count: "Present",
                           label: "$presentCount",
                           icon: Icons.people,
                         ),
                       ),
                       SizedBox(width: 8.w),
                       Expanded(
                         child: CustomTeachersAttendanceCard(
                           count: "Absent",
                           label: "$absentCount",
                           icon: Icons.people,
                         ),
                       ),
                       SizedBox(width: 8.w),
                       Expanded(
                         child: CustomTeachersAttendanceCard(
                           count: "Late",
                           label: "$lateCount",
                           icon: Icons.alarm,
                         ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomText(
                                text: "Attendance Sheet",
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Obx(() {
                              final DateTime now = DateTime.now();
                              final bool isDateToday =
                                  teacherAttendanceController
                                              .selectedDate.value.year ==
                                          now.year &&
                                      teacherAttendanceController
                                              .selectedDate.value.month ==
                                          now.month &&
                                      teacherAttendanceController
                                              .selectedDate.value.day ==
                                          now.day;

                              if (!isDateToday) {
                                return const SizedBox.shrink();
                              }

                              return GestureDetector(
                                onTap: teacherAttendanceController
                                        .isSaveLoading.value
                                    ? null
                                    : () => teacherAttendanceController
                                        .saveAttendance(),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 8.h),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.primary,
                                        Color(0xFF81C784)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(20.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primary
                                            .withValues(alpha: 0.3),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: teacherAttendanceController
                                          .isSaveLoading.value
                                      ? SizedBox(
                                          height: 14.h,
                                          width: 14.w,
                                          child:
                                              const CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.check_circle_outline,
                                                color: Colors.white,
                                                size: 12.sp),
                                            SizedBox(width: 4.w),
                                            CustomText(
                                              text: "Save Attendance",
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                ),
                              );
                            }),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Obx(() {
                          if (teacherAttendanceController
                                  .selectedSchedule.value ==
                              null) {
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
                          if (teacherAttendanceController
                              .isAttendanceLoading.value) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: CircularProgressIndicator(
                                    color: AppColors.primary),
                              ),
                            );
                          }
                          if (teacherAttendanceController
                              .attendanceSheet.isEmpty) {
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
                            itemCount: teacherAttendanceController
                                .attendanceSheet.length,
                            itemBuilder: (context, index) {
                              final student = teacherAttendanceController
                                  .attendanceSheet[index];
                              final studentId = student.studentId ?? '';

                              return Obx(() {
                                final currentStatus =
                                    teacherAttendanceController
                                            .studentStatus[studentId] ??
                                        '';
                                final DateTime now = DateTime.now();
                                final bool isDateToday =
                                    teacherAttendanceController
                                                .selectedDate.value.year ==
                                            now.year &&
                                        teacherAttendanceController
                                                .selectedDate.value.month ==
                                            now.month &&
                                        teacherAttendanceController
                                                .selectedDate.value.day ==
                                            now.day;

                                return CustomAttendanceCardTeacher(
                                  parentsName: student.staffs?.name ?? "N/A",
                                  name: student.name ?? "N/A",
                                  number: student.staffs?.phoneNumber ?? "N/A",
                                  email: student.staffs?.email ?? "N/A",
                                  isPresent:
                                      currentStatus.toLowerCase() == 'present',
                                  isAbsent:
                                      currentStatus.toLowerCase() == 'absent',
                                  isLate: currentStatus.toLowerCase() == 'late',
                                  onTapPresent: isDateToday
                                      ? () => teacherAttendanceController
                                          .setStatus(studentId, 'Present')
                                      : null,
                                  onTapAbsent: isDateToday
                                      ? () => teacherAttendanceController
                                          .setStatus(studentId, 'Absent')
                                      : null,
                                  onTapLate: isDateToday
                                      ? () => teacherAttendanceController
                                          .setStatus(studentId, 'Late')
                                      : null,
                                  onTapMail: () => teacherAttendanceController
                                      .sendEmail(student.staffs?.email ?? ''),
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
