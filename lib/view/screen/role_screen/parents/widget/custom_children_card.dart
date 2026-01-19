import 'package:flutter/material.dart';
import '../../../../components/custom_text/custom_text.dart';

class CustomChildrenCard extends StatelessWidget {
  final String? name;
  final String? grade;
  final String? studentId;
  final String? attendance;
  final String? gpa;
  final List<String> teachers;
  final VoidCallback onViewProfile;

  const CustomChildrenCard({
    super.key,
    required this.name,
    required this.grade,
    this.studentId,
    required this.attendance,
    required this.gpa,
    required this.teachers,
    required this.onViewProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFFF0FAF6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: name ?? "",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                ),
                CustomText(
                  text: grade ?? "",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF00A86B),
                  top: 4,
                  textAlign: TextAlign.start,
                ),
                if (studentId != null)
                  CustomText(
                    text: "ID: $studentId",
                    fontSize: 12,
                    color: Colors.grey[600]!,
                    top: 2,
                    textAlign: TextAlign.start,
                  ),
              ],
            ),
          ),

          // নিচের সাদা সেকশন
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoBox(
                        icon: Icons.access_time,
                        label: "Attendance",
                        value: attendance ?? "0%",
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _buildInfoBox(
                        icon: Icons.menu_book_outlined,
                        label: "GPA",
                        value: gpa ?? "0.0",
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                CustomText(
                  text: "Key Teachers",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: teachers.map((teacher) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CustomText(
                      text: teacher,
                      fontSize: 12,
                      color: const Color(0xFF4A5568),
                    ),
                  )).toList(),
                ),

                const SizedBox(height: 25),
                // View Profile
                SizedBox(
                  width: 140,
                  child: ElevatedButton(
                    onPressed: onViewProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00A86B),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text("View Profile"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox({required IconData icon, required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 6),
              CustomText(
                text: label,
                fontSize: 13,
                color: Colors.grey[600]!,
              ),
            ],
          ),
          const SizedBox(height: 8),
          CustomText(
            text: value,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}