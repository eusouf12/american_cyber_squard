import 'package:flutter/material.dart';

class CustomOverallAttendance extends StatelessWidget {
  final String? title;
  final String? semesterStatus;
  final String? overallAttendance;
  final double? progressValue;
  final String? presentCount;
  final String? lateCount;
  final String? absentCount;

  const CustomOverallAttendance({
    super.key,
    this.title,
    this.semesterStatus,
    this.overallAttendance,
    this.progressValue = 0.92,
    this.presentCount = "185",
    this.lateCount = "8",
    this.absentCount = "8",
  });

  @override
  Widget build(BuildContext context) {
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
          // --- Title and Semester Status ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Use null-aware operator to provide default if not passed
                  Text(
                    title ?? "Overall Attendance", // Default title
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    semesterStatus ?? "Semester 1, 2024", // Default semester status
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              // Use null-aware operator to provide default if not passed
              Text(
                overallAttendance ?? "92%", // Default overall attendance
                style: TextStyle(color: Colors.green[700], fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // --- Progress Bar ---
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progressValue,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              color: Colors.green[600],
            ),
          ),
          const SizedBox(height: 20),

          // --- Attendance Stats (Present, Late, Absent) ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Use null-aware operator to provide default if not passed
              _buildAttendanceStat(presentCount ?? "185", "Present", Colors.green),
              _buildAttendanceStat(lateCount ?? "8", "Late", Colors.orange),
              _buildAttendanceStat(absentCount ?? "8", "Absent", Colors.red),
            ],
          ),
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
}
