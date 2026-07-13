import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_loader/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../components/custom_nav_bar/student_nav_bar.dart';

import 'controller/student_attandance_controller.dart';
import '../../widget/custom_grade_summary_card.dart';
import '../../widget/custom_history_item.dart';

import 'view_all_history/student_attendance_history_all_screen.dart';

class StudentAttendanceScreen extends StatelessWidget {
  StudentAttendanceScreen({super.key});

  final StudentAttendanceController studentAttendanceController =
      Get.find<StudentAttendanceController>();

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              // Summary Cards
              Obx(() {
                final stats = studentAttendanceController.statistics.value;
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomGradeSummaryCard(
                            count:
                                "${stats?.presentPercentage?.toStringAsFixed(2) ?? 0}%",
                            label: "Average Attendance",
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomGradeSummaryCard(
                            count: "${stats?.totalAttendance ?? 0}",
                            label: "Total Attendance",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: CustomGradeSummaryCard(
                            count: "${stats?.present ?? 0}",
                            label: "Days Present",
                            cardColor: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomGradeSummaryCard(
                            count: "${stats?.absent ?? 0}",
                            label: "Days Absent",
                            cardColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),

              const SizedBox(height: 30),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Recent History",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => StudentAttendanceHistoryAllScreen());
                        },
                        child: const Text("View All",
                            style: TextStyle(color: AppColors.primary)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Obx(() {
                    if (studentAttendanceController.isHistoryLoading.value) {
                      return const Center(child: CustomLoader());
                    }

                    if (studentAttendanceController.historyList.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text("No recent history found."),
                        ),
                      );
                    }

                    // Show up to 10 items
                    final displayList = studentAttendanceController.historyList
                        .take(10)
                        .toList();

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: displayList.length,
                      itemBuilder: (context, index) {
                        final item = displayList[index];

                        Color statusColor = Colors.grey;
                        IconData iconData = Icons.info;
                        String statusStr =
                            item.attendanceStatus?.toLowerCase() ?? "";

                        if (statusStr == "present") {
                          statusColor = Colors.green;
                          iconData = Icons.check_circle;
                        } else if (statusStr == "absent") {
                          statusColor = Colors.red;
                          iconData = Icons.cancel;
                        } else if (statusStr == "late") {
                          statusColor = Colors.orange;
                          iconData = Icons.access_time_filled;
                        }

                        String dateStr = "";
                        if (item.attendanceDate != null) {
                          dateStr =
                              "${item.attendanceDate!.year}-${item.attendanceDate!.month.toString().padLeft(2, '0')}-${item.attendanceDate!.day.toString().padLeft(2, '0')}";
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: HistoryItem(
                            date: dateStr,
                            subtitle: "Regular Class Day",
                            status: item.attendanceStatus ?? "Unknown",
                            statusColor: statusColor,
                            icon: iconData,
                            iconBg: statusColor.withValues(alpha: 0.1),
                          ),
                        );
                      },
                    );
                  }),
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: const StudentNavBar(currentIndex: 1),
      ),
    );
  }
}
