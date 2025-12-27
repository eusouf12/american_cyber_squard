import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/custom_nav_bar/student_nav_bar.dart';

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
            // 1. Top Summary Cards (Gradient)
            Row(
              children: [
                _buildSummaryCard("8", "Submitted", const [Color(0xFFFDFFA8), Color(0xFFC8E6C9)]),
                const SizedBox(width: 10),
                _buildSummaryCard("3", "Pending", const [Color(0xFFFFF9C4), Color(0xFFB2DFDB)]),
                const SizedBox(width: 10),
                _buildSummaryCard("12", "Graded", const [Color(0xFFFDFFA8), Color(0xFFC8E6C9)]),
              ],
            ),
            const SizedBox(height: 25),

            // 2. Assignment List
            // Card 1: Pending (Due Soon)
            _buildAssignmentCard(
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
            ),

            // Card 2: Pending (Due later)
            _buildAssignmentCard(
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
            ),

            // Card 3: Submitted
            _buildAssignmentCard(
              title: "History Essay",
              subject: "History", // Subject corrected
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
            ),

            // Card 4: Graded (With Progress Bar)
            _buildGradedCard(
              title: "English Literature Analysis",
              subject: "English",
              grade: "A-",
              percentage: 0.92,
              gradedDate: "Sep 28, 2025",
            ),

            // Card 5: Physics (Pending)
            _buildAssignmentCard(
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
              showSubmitButton: false, // Image shows only 'View details' for this one logic
            ),
          ],
        ),
      ),
      bottomNavigationBar: StudentNavBar(currentIndex: 2),
    );
  }

  // --- Helper Widgets ---

  // 1. Top Gradient Summary Card
  Widget _buildSummaryCard(String count, String label, List<Color> gradientColors) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 3)),
          ],
        ),
        child: Column(
          children: [
            Text(count, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 5),
            Text(label, style: TextStyle(color: Colors.grey[800], fontSize: 12)),
          ],
        ),
      ),
    );
  }

  // 2. Standard Assignment Card (Pending/Submitted)
  Widget _buildAssignmentCard({
    required String title,
    required String subject,
    required String tagText,
    required Color tagColor,
    required Color tagTextColor,
    bool isCheckIcon = false,
    required String dateLabel,
    required String dateValue,
    required String status,
    required Color statusColor,
    required Color statusTextColor,
    required bool showSubmitButton,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Title & Tag
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: tagColor, borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Text(tagText, style: TextStyle(color: tagTextColor, fontSize: 10, fontWeight: FontWeight.bold)),
                    if (isCheckIcon) ...[
                      const SizedBox(width: 4),
                      Icon(Icons.check_circle, size: 12, color: tagTextColor),
                    ] else ...[
                      const SizedBox(width: 4),
                      Icon(Icons.access_time_filled, size: 12, color: tagTextColor),
                    ]
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          Text(subject, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          const SizedBox(height: 15),

          // Date & Status Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(dateLabel, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                  const SizedBox(width: 5),
                  Text(dateValue, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(5)),
                child: Text(status, style: TextStyle(color: statusTextColor, fontSize: 11, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          const SizedBox(height: 15),

          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("View details"),
                ),
              ),
              if (showSubmitButton) ...[
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF008955), // Green Button
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("Submit"),
                  ),
                ),
              ]
            ],
          )
        ],
      ),
    );
  }

  // 3. Special Card for Graded Items (Progress Bar)
  Widget _buildGradedCard({
    required String title,
    required String subject,
    required String grade,
    required double percentage,
    required String gradedDate,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Text("Grade: $grade", style: const TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 4),
                    const Icon(Icons.emoji_events_outlined, size: 14, color: Colors.grey),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          Text(subject, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          const SizedBox(height: 15),

          // Progress Bar Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Grade", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text("${(percentage * 100).toInt()}%", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              value: percentage,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              color: Colors.blueGrey.shade700,
            ),
          ),
          const SizedBox(height: 15),

          // Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("Graded:", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                  const SizedBox(width: 5),
                  Text(gradedDate, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
                child: Text("Graded", style: TextStyle(color: Colors.grey[700], fontSize: 11, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ],
      ),
    );
  }
}