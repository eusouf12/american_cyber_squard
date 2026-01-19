import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/custom_nav_bar/student_nav_bar.dart';
import '../../widget/custom_assignment_status.dart';
import '../../widget/custom_grade_summary_card.dart';

class StudentAssignmentScreen extends StatelessWidget {
  const StudentAssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Assignments",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CustomGradeSummaryCard(
                    count: "8",
                    label: "Completed",
                    gradientColors: [Color(0xFFFDFFA8), Color(0xFFC8E6C9)],
                  ),
                  const SizedBox(width: 10),
                  CustomGradeSummaryCard(
                    count: "3",
                    label: "Pending",
                    gradientColors: [Color(0xFFFFF9C4), Color(0xFFB2DFDB)],
                  ),
                  const SizedBox(width: 10),
                  CustomGradeSummaryCard(
                    count: "12",
                    label: "In Progress",
                    gradientColors: [Color(0xFFFDFFA8), Color(0xFFC8E6C9)],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
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
                  // Title
                  CustomText(
                      text: "Assignments",
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                  ),
                  const SizedBox(height: 4),

                  // Description

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
            const SizedBox(height: 25),
            CustomAssignmentCard(
              title: "Math Homework 1",
              subject: "Algebra & Functions",
              tagText: "Due in 1 day",
              tagColor: Colors.red.shade50,
              tagTextColor: Colors.red,
              dateLabel: "Due:",
              dateValue: "Oct 5, 2025",
              status: "Pending",
              statusColor: Colors.orange.shade100,
              statusTextColor: Colors.orange.shade800,
              showSubmitButton: true,
              onViewDetails: () {},
            ),
            CustomAssignmentCard(
              title: "Science Lab Report",
              subject: "Chemistry",
              tagText: "Due in 3 days",
              tagColor: Colors.orange.shade50,
              tagTextColor: Colors.orange,
              dateLabel: "Due:",
              dateValue: "Oct 5, 2025",
              status: "Pending",
              statusColor: Colors.orange.shade100,
              statusTextColor: Colors.orange.shade800,
              showSubmitButton: true,
              onViewDetails: () {},
            ),
            CustomAssignmentCard(
              title: "History Essay",
              subject: "History",
              tagText: "Submitted",
              tagColor: Colors.green.shade50,
              tagTextColor: Colors.green,
              isCheckIcon: true,
              dateLabel: "Submitted:",
              dateValue: "Oct 1, 2025",
              status: "Submitted",
              statusColor: Colors.green.shade50,
              statusTextColor: Colors.green,
              showSubmitButton: false,
              onViewDetails: () {},
            ),
            CustomAssignmentCard(
              title: "Physics Problem Set",
              subject: "Physics",
              tagText: "Due in 5 days",
              tagColor: Colors.purple.shade50,
              tagTextColor: Colors.purple,
              dateLabel: "Due:",
              dateValue: "Oct 10, 2025",
              status: "Pending",
              statusColor: Colors.orange.shade100,
              statusTextColor: Colors.orange.shade800,
              showSubmitButton: false,
              onViewDetails: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: StudentNavBar(currentIndex: 2),
    );
  }
}
