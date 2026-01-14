import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import '../../../../../components/custom_nav_bar/student_nav_bar.dart';
import '../../controller/student_attandance_controller.dart';
import '../../widget/custom_attendanceCard.dart';
import '../../widget/custom_attendance_tabbar.dart';
import '../../widget/student_attandance_point_card.dart';

class StudentAttendanceScreen extends StatelessWidget {
  StudentAttendanceScreen({super.key});

  final StudentAttendanceController studentAttendanceController = Get.put(StudentAttendanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomRoyelAppbar(
        titleName: "Attendance",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 🔹 Attendance Summary
            Column(
              children: [
                CustomText(
                  text: "90%",
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 10),
                const CustomText(
                  text: "Overall Attendance",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// 🔹 Progress Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.grey_03,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                          text: "Progress",
                        fontWeight: FontWeight.w500,
                          fontSize: 14,
                      ),
                      Text(
                        "${studentAttendanceController.presentDays.value}/${studentAttendanceController.totalDays.value} days",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: studentAttendanceController.progressValue/100,
                      minHeight: 12,
                      backgroundColor: Colors.grey.shade200,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("60%", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text("80%", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text("100%", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StudentAttandancePointCard(
                  point: "315",
                  title: "Present",
                  textColor: Color(0xFF2E7D32),
                  bgColor: Color(0xFFE8F5E9),
                ),
                StudentAttandancePointCard(
                  point: "8",
                  title: "Late",
                  textColor: Color(0xFFF9A825),
                  bgColor: Color(0xFFFFFDE7),
                ),
                StudentAttandancePointCard(
                  point: "8",
                  title: "Absent",
                  textColor: Color(0xFFC62828),
                  bgColor: Color(0xFFFFEBEE),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Tabs
            Obx(() => CustomAttendanceTabbar(
              textColor: AppColors.white,
              tabs: studentAttendanceController.tabNamelist,
              selectedIndex: studentAttendanceController.currentIndex.value,
              onTabSelected: (value) {
                studentAttendanceController.currentIndex.value = value;
                // Trigger data fetch (refresh)
                // studentAttendanceController.fetchAllCases();
              },
              selectedColor: AppColors.primary,
            )
            ),
            const SizedBox(height: 30),
            // Attendance List
      Obx(() {
        if (studentAttendanceController.currentIndex.value == 0) {
          return CustomAttendanceCard(
            day: "Monday",
            date: "Oct 10, 2023",
            status: "Present",
            color: AppColors.primary,
          );
        }
        else if (studentAttendanceController.currentIndex.value == 1) {
          return CustomAttendanceCard(
            day: "Tuesday",
            date: "Oct 11, 2023",
            status: "Absent",
            color: AppColors.orange,
          );
        }
        else if (studentAttendanceController.currentIndex.value == 2) {
          return CustomAttendanceCard(
            day: "Wednesday",
            date: "Oct 12, 2023",
            status: "Late",
            color: AppColors.accentsRed,
          );
        }
        // ✅ fallback widget (must)
        return const SizedBox.shrink();
      })

      ],
        ),
      ),
      bottomNavigationBar: const StudentNavBar(currentIndex: 1),
    );
  }
}
