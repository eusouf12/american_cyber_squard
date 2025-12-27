import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/custom_nav_bar/student_nav_bar.dart';
import '../../controller/student_home_controller.dart';


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
              _buildHeader(),
              const SizedBox(height: 20),

              // 2. Summary Cards (Classes & GPA)
              _buildSummaryCards(),
              const SizedBox(height: 25),

              // 3. Today's Schedule
              _buildSectionTitle("Today's Schedule", "View Week"),
              const SizedBox(height: 15),
              _buildScheduleItem("Mathematics", "Room 201 • Mr. Anderson", "08:00 - 09:30 AM", Colors.deepPurple, "In Progress", true),
              _buildScheduleItem("Physics", "Lab 3 • Dr. Smith", "10:00 - 11:30 AM", Colors.redAccent, "Upcoming", false),
              _buildScheduleItem("English Literature", "Room 105 • Ms. Davis", "12:00 - 01:30 PM", Colors.indigo, "Upcoming", false),
              const SizedBox(height: 25),

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
                  _buildGradeCard("Mathematics", "A", "82% Average", Icons.calculate_outlined, Colors.deepPurple),
                  _buildGradeCard("Physics", "B+", "65% Average", Icons.science_outlined, Colors.orange),
                  _buildGradeCard("English", "A-", "88% Average", Icons.book_outlined, Colors.indigo),
                  _buildGradeCard("History", "A", "90% Average", Icons.public, Colors.teal),
                ],
              ),
              const SizedBox(height: 25),

              // 5. Attendance Section
              _buildSectionTitle("Attendance", ""),
              const SizedBox(height: 15),
              _buildAttendanceCard(),
              const SizedBox(height: 25),

              // 6. Quick Actions
              _buildSectionTitle("Quick Actions", ""),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: _buildQuickAction("Reports", Icons.description, const Color(0xFFE8F5E9), Colors.green)),
                  const SizedBox(width: 15),
                  Expanded(child: _buildQuickAction("Messages", Icons.chat_bubble_outline, const Color(0xFFFFF3E0), Colors.orange)),
                ],
              ),
              const SizedBox(height: 25),

              // 7. Upcoming Assignments (Example)
              _buildSectionTitle("Upcoming Assignments", "View All"),
              const SizedBox(height: 15),
              _buildAssignmentCard("Math Homework", "Due Tomorrow", Colors.purple.shade50),

              const SizedBox(height: 80), // Bottom padding
            ],
          ),
        ),
      ),
        bottomNavigationBar: StudentNavBar(currentIndex: 0)
    );
  }

  // --- Helper Widgets ---

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
            ),
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
    );
  }

  Widget _buildSummaryCards() {
    return Row(
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
                colors: [Color(0xFFFDFFA8), Color(0xFFC8E6C9)], // Yellow to Green
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

  Widget _buildScheduleItem(String subject, String details, String time, Color color, String status, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade100, blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 50,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(subject, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(time, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 5),
                Text(details, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isActive ? Colors.green.shade50 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: isActive ? Colors.green : Colors.grey,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGradeCard(String subject, String grade, String avg, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 5, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: color, size: 20),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                child: Text(grade, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subject, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 4),
              Text(avg, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: 0.82,
                backgroundColor: Colors.grey.shade200,
                color: color,
                minHeight: 4,
                borderRadius: BorderRadius.circular(5),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAttendanceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 10)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Overall Attendance", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text("This semester", style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
              Text("92%", style: TextStyle(color: Colors.green[700], fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.92,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              color: Colors.green[600],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAttendanceStat("185", "Present", Colors.green),
              _buildAttendanceStat("8", "Late", Colors.orange),
              _buildAttendanceStat("8", "Absent", Colors.red),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAttendanceStat(String value, String label, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildQuickAction(String title, IconData icon, Color bgColor, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 5)],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(15)),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAssignmentCard(String title, String dueText, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.edit, color: Colors.purple, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text("Chapter 5: Quadratic Equations", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(5)),
            child: Text(dueText, style: const TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}