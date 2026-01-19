import 'package:america_ayber_squad/utils/app_const/app_const.dart';
import 'package:america_ayber_squad/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../components/custom_nav_bar/student_nav_bar.dart';
import '../../controller/student_home_controller.dart';
import '../../widget/custom_all_info_card.dart';
import '../../widget/custom_attenddance.dart';
import '../../widget/custom_shedule_item.dart';


class StudentHomeScreen extends StatelessWidget {
  StudentHomeScreen({super.key});

  final StudentHomeController controller = Get.put(StudentHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipOval(child: CustomNetworkImage(imageUrl: AppConstants.profileImage, height: 50, width: 50)),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sarah Johnson",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Grade 11 - Section A",
                            style: TextStyle(color: Colors.grey[600], fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, size: 28)),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                          child: const Text('2', style: TextStyle(color: Colors.white, fontSize: 10)),
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),

              // Summary Cards (Classes & GPA)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CustomAllInfoCard(
                      title: "Attendance",
                      subtitle: "Overall attendance rate",
                      count: "92%",
                      icon: Icons.check_circle_outline,
                      cardColor: Color(0xFFFDFFA8),
                      textColor: Colors.grey[800]!,
                    ),
                    const SizedBox(width: 8),
                    CustomAllInfoCard(
                      title: "Pending Assignments",
                      subtitle: "Assignments due soon",
                      count: "3",
                      icon: Icons.assignment_late,
                      cardColor: Color(0xFFFDFFA8),
                      textColor: Colors.grey[800]!,
                    ),
                    const SizedBox(width: 8),
                    CustomAllInfoCard(
                      title: "Upcoming Exams",
                      subtitle: "Exams scheduled soon",
                      count: "2",
                      icon: Icons.school_outlined,
                      cardColor: Color(0xFFFDFFA8),
                      textColor: Colors.grey[800]!,
                    ),
                    const SizedBox(width: 8),
                    CustomAllInfoCard(
                      title: "Grades Received",
                      subtitle: "Recent grades received",
                      count: "4",
                      icon: Icons.grade_outlined,
                      cardColor: Color(0xFFFDFFA8),
                      textColor: Colors.grey[800]!,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Today's Schedule
              _buildSectionTitle("Today's Schedule", "View Week"),
              const SizedBox(height: 15),

              CustomScheduleItem(
                subject: "Mathematics",
                details: "Room 201 • Mr. Anderson",
                time: "08:00 - 09:30 AM",
                color: Colors.deepPurple,
                status: "In Progress",
                isActive: true,
                onTap: () {},
              ),
              CustomScheduleItem(
                subject: "Physics",
                details: "Lab 3 • Dr. Smith",
                time: "10:00 - 11:30 AM",
                color: Colors.redAccent,
                status: "Completed",
                isActive: false,
                onTap: () {},
              ),
              CustomScheduleItem(
                subject: "English Literature",
                details: "Room 105 • Ms. Davis",
                time: "12:00 - 01:30 PM",
                color: Colors.indigo,
                status: "Completed",
                isActive: false,
                onTap: () {},
              ),

              // Upcoming Assignments (Example)
              _buildSectionTitle("Upcoming Assignments", "View All"),
              const SizedBox(height: 15),
              CustomAssignmentCard(
                title: "Math Homework",
                dueText: "Due Tomorrow",
                bgColor: Colors.purple.shade50,
                chapterDetails: "Chapter 5: Quadratic Equations",
              ),


              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
        bottomNavigationBar: StudentNavBar(currentIndex: 0)
    );
  }

  Widget _buildSectionTitle(String title, String actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        if (actionText.isNotEmpty)
          TextButton(
            onPressed: () {},
            child: Text(actionText, style: const TextStyle(color: Colors.purple)),
          )
      ],
    );
  }

}