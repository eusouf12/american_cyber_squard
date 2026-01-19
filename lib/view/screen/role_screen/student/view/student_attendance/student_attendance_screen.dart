import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import '../../../../../components/custom_nav_bar/student_nav_bar.dart';
import '../../controller/student_attandance_controller.dart';
import '../../widget/custom_grade_summary_card.dart';
import '../../widget/custom_history_item.dart';

class StudentAttendanceScreen extends StatelessWidget {
  StudentAttendanceScreen({super.key});

  final StudentAttendanceController studentAttendanceController = Get.put(StudentAttendanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        titleName: "Attendance",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Horizontal Scrolling for Cards (Summary Cards)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Make it horizontally scrollable
                  child: Row(
                    children: [
                      CustomGradeSummaryCard(
                        count: "92%",
                        label: "Average Attendance",
                        gradientColors: [Color(0xFFFDFFA8), Color(0xFFC8E6C9)],
                      ),
                      const SizedBox(width: 10),
                      CustomGradeSummaryCard(
                        count: "3",
                        label: "Days Present",
                        gradientColors: [Color(0xFFFFF9C4), Color(0xFFB2DFDB)],
                      ),
                      const SizedBox(width: 10),
                      CustomGradeSummaryCard(
                        count: "12",
                        label: "Late",
                        gradientColors: [Color(0xFFFDFFA8), Color(0xFFC8E6C9)],
                      ),
                      const SizedBox(width: 10),
                      CustomGradeSummaryCard(
                        count: "12",
                        label: "Days Absent",
                        gradientColors: [Color(0xFFFDFFA8), Color(0xFFC8E6C9)],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // Remaining Sections (e.g., Attendance Summary, Tabs, etc.)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade200,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          text: "Assignments",
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      ),
                      const SizedBox(height: 4),

                      CustomText(
                        text: "Track your homework and project deadlines",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        maxLines: 3,
                        textAlign: TextAlign.start,
                      ),

                      const SizedBox(height: 16),

                      // Due Count Section with Icon
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.green.shade400,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.assignment,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            CustomText(
                                text: "2 Due Today",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Recent History",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),

                HistoryItem(
                  date: "Dec 10, 2024",
                  subtitle: "Regular Class Day",
                  status: "Present",
                  statusColor: Colors.green,
                  icon: Icons.check_circle,
                  iconBg: Colors.green.withOpacity(0.1),
                ),

                HistoryItem(
                  date: "Dec 09, 2024",
                  subtitle: "Regular Class Day",
                  status: "Present",
                  statusColor: Colors.green,
                  icon: Icons.check_circle,
                  iconBg: Colors.green.withOpacity(0.1),
                ),

                HistoryItem(
                  date: "Dec 08, 2024",
                  subtitle: "Regular Class Day",
                  status: "Late",
                  statusColor: Colors.orange,
                  icon: Icons.access_time_filled,
                  iconBg: Colors.orange.withOpacity(0.1),
                ),

                HistoryItem(
                  date: "Dec 07, 2024",
                  subtitle: "Regular Class Day",
                  status: "Absent",
                  statusColor: Colors.red,
                  icon: Icons.cancel,
                  iconBg: Colors.red.withOpacity(0.1),
                ),

                HistoryItem(
                  date: "Dec 06, 2024",
                  subtitle: "Regular Class Day",
                  status: "Present",
                  statusColor: Colors.green,
                  icon: Icons.check_circle,
                  iconBg: Colors.green.withOpacity(0.1),
                ),
              ],
            )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const StudentNavBar(currentIndex: 1),
    );
  }
}
