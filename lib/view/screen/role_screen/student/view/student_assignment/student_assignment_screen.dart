import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:flutter/material.dart';
import '../../../../../components/custom_nav_bar/student_nav_bar.dart';
import '../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../parents/widget/custom_welcome_card.dart';
import '../../widget/custom_assignment_status.dart';
import '../../widget/custom_grade_summary_card.dart';

class StudentAssignmentScreen extends StatelessWidget {
  const StudentAssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomRoyelAppbar(titleName: "Assignments", leftSpace: 60,),
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
                    ),
                    const SizedBox(width: 10),
                    CustomGradeSummaryCard(
                      count: "3",
                      label: "Pending",
                    ),
                    const SizedBox(width: 10),
                    CustomGradeSummaryCard(
                      count: "12",
                      label: "In Progress",
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
      ),
    );
  }
}
