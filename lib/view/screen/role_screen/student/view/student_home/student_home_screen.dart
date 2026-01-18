import 'package:america_ayber_squad/utils/app_const/app_const.dart';
import 'package:america_ayber_squad/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../components/custom_nav_bar/student_nav_bar.dart';
import '../../controller/student_home_controller.dart';
import '../../widget/custom_attenddance.dart';
import '../../widget/custom_grede_card.dart';
import '../../widget/custom_overall_attendance.dart';
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
              // 1. Header Section
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

              // 2. Summary Cards (Classes & GPA)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDFFA8), // Light Yellowish
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Today's Classes", style: TextStyle(color: Colors.grey[800], fontSize: 12)),
                              const Icon(Icons.calendar_today, size: 18),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text("5", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFDFFA8), Color(0xFFC8E6C9)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("GPA", style: TextStyle(color: Colors.grey[800], fontSize: 12)),
                              const Icon(Icons.show_chart, size: 18),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text("3.8", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // 3. Today's Schedule
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
                status: "Upcoming",
                isActive: false,
                onTap: () {},
              ),
              CustomScheduleItem(
                subject: "English Literature",
                details: "Room 105 • Ms. Davis",
                time: "12:00 - 01:30 PM",
                color: Colors.indigo,
                status: "Upcoming",
                isActive: false,
                onTap: () {},
              ),


              // 4. Recent Grades
              _buildSectionTitle("Recent Grades", "View All"),
              const SizedBox(height: 15),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.1,
                children: [
                  CustomGradeCard(
                    subject: "Mathematics",
                    grade: "A",
                    avg: "82% Average",
                    icon: Icons.calculate_outlined,
                    color: Colors.deepPurple,
                  ),
                  CustomGradeCard(
                    subject: "Physics",
                    grade: "B+",
                    avg: "65% Average",
                    icon: Icons.science_outlined,
                    color: Colors.orange,
                  ),
                  CustomGradeCard(
                    subject: "English",
                    grade: "A-",
                    avg: "88% Average",
                    icon: Icons.book_outlined,
                    color: Colors.indigo,
                  ),
                  CustomGradeCard(
                    subject: "History",
                    grade: "A",
                    avg: "90% Average",
                    icon: Icons.public,
                    color: Colors.teal,
                  ),
                ],
              ),


              const SizedBox(height: 25),

              // 5. Attendance Section
              _buildSectionTitle("Attendance", ""),
              const SizedBox(height: 15),
              CustomOverallAttendance(
                title: "Attendance Summary",
                semesterStatus: "Semester 2, 2024",
                overallAttendance: "85%",
                progressValue: 0.85,
                presentCount: "180",
                lateCount: "5",
                absentCount: "10",
              ),


              const SizedBox(height: 15),

              // 6. Upcoming Assignments (Example)
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