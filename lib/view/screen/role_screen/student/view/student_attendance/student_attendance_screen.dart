import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../components/custom_nav_bar/student_nav_bar.dart';
import '../../../parents/widget/custom_welcome_card.dart';
import '../../controller/student_attandance_controller.dart';
import '../../widget/custom_grade_summary_card.dart';
import '../../widget/custom_history_item.dart';

class StudentAttendanceScreen extends StatelessWidget {
  StudentAttendanceScreen({super.key});

  final StudentAttendanceController studentAttendanceController = Get.put(StudentAttendanceController());

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 40,),
              // Horizontal Scrolling for Cards (Summary Cards)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Make it horizontally scrollable
                child: Row(
                  children: [
                    CustomGradeSummaryCard(
                      count: "92%",
                      label: "Average Attendance",
                    ),
                    const SizedBox(width: 10),
                    CustomGradeSummaryCard(
                      count: "3",
                      label: "Days Present",
                    ),
                    const SizedBox(width: 10),
                    CustomGradeSummaryCard(
                      count: "12",
                      label: "Late",
                    ),
                    const SizedBox(width: 10),
                    CustomGradeSummaryCard(
                      count: "12",
                      label: "Days Absent",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              CustomPrimaryCard(
                title: "Assignments",
                description: "Track your homework and project \n deadlines",
                isInbox: true,
                icon: Icons.assignment,
                inboxTitle: "2 Due Today",
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
        bottomNavigationBar: const StudentNavBar(currentIndex: 1),
      ),
    );
  }
}
