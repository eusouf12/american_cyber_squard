import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../../components/custom_text/custom_text.dart';
import '../controller/student_profile_controller.dart';
import '../widgets/custom_schedule_card.dart';
import '../widgets/custom_time_card.dart';

class StudentScheduleScreen extends StatelessWidget {
  const StudentScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // GetX Controller for day selection
    final StudentProfileController dayController = Get.find<StudentProfileController>();

    // Load latest schedule data on screen entry
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dayController.getStudentSchedule();
    });

    return Scaffold(
      appBar: CustomRoyelAppbar(
        titleName: "Schedule",
        leftIcon: true,
      ),
      body: SingleChildScrollView(  // Make the body scrollable
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Title Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Weekly Timetable",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    Icon(Icons.videocam_outlined, color: Colors.green, size: 20),
                    CustomText(text: "Online", fontSize: 12.sp, color: Colors.grey, left: 5),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: Colors.grey, size: 20),
                    CustomText(text: "Offline", fontSize: 12.sp, color: Colors.grey, left: 5),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            Row(
              children: [
                CustomText(text: "Time", fontWeight: FontWeight.w600, fontSize: 14.sp),
                const Spacer(),
                CustomText(text: "Day:", fontWeight: FontWeight.w600, fontSize: 14.sp),
                SizedBox(width: 12.w),

                // Dropdown for Day selection with different colors
                Obx(() => Container(
                      width: 130.w,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: dayController.selectedDay.value,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down),
                          style: TextStyle(fontSize: 14.sp, color: Colors.black),  // Text color for dropdown
                          onChanged: (String? newValue) {
                            if (newValue != null) dayController.selectedDay.value = newValue;
                          },
                          items: dayController.days.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(height: 20),

            // Schedule Cards
            Obx(() {
              if (dayController.isScheduleLoading.value) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: CustomLoader(),
                  ),
                );
              }

              final allItems = dayController.allScheduleList;

              // Filter by selected day
              final filtered = allItems
                  .where((e) =>
                      e.day?.trim().toLowerCase() ==
                      dayController.selectedDay.value.trim().toLowerCase())
                  .toList();

              if (filtered.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Column(
                      children: [
                        Icon(Icons.calendar_today_outlined,
                            size: 48.sp, color: Colors.grey.shade300),
                        SizedBox(height: 12.h),
                        CustomText(
                          text: "No schedule found",
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final item = filtered[index];

                  final bool isOnline = item.isOnline == true;
                  final String timeText = item.time ?? "N/A";
                  final String subjectText =
                      item.assignableSubject ?? "Subject";
                  final String teacherText = item.teacher?.teacherName ?? "";
                  final String roomText = item.roomNumber ?? "";

                  final ClassStatus cardStatus =
                      isOnline ? ClassStatus.online : ClassStatus.offline;

                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTimeCard(time: timeText),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: CustomScheduleCard(
                            status: cardStatus,
                            subject: subjectText,
                            teacher: teacherText.isNotEmpty ? teacherText : null,
                            room: isOnline ? null : (roomText.isNotEmpty ? roomText : null),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
