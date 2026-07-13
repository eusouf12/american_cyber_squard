import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/student_attandance_controller.dart';
import '../../../widget/custom_history_item.dart';

class StudentAttendanceHistoryAllScreen extends StatelessWidget {
  StudentAttendanceHistoryAllScreen({super.key});

  final StudentAttendanceController studentAttendanceController = Get.find<StudentAttendanceController>();

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        appBar: const CustomRoyelAppbar(titleName: "All Attendance History", leftIcon: true),
        body: Obx(() {
          if (studentAttendanceController.isHistoryLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (studentAttendanceController.historyList.isEmpty) {
            return const Center(
              child: Text("No attendance history found."),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: studentAttendanceController.historyList.length,
            itemBuilder: (context, index) {
              final item = studentAttendanceController.historyList[index];

              Color statusColor = Colors.grey;
              IconData iconData = Icons.info;
              String statusStr = item.attendanceStatus?.toLowerCase() ?? "";

              if (statusStr == "present") {
                statusColor = Colors.green;
                iconData = Icons.check_circle;
              } else if (statusStr == "absent") {
                statusColor = Colors.red;
                iconData = Icons.cancel;
              } else if (statusStr == "late") {
                statusColor = Colors.orange;
                iconData = Icons.access_time_filled;
              }

              String dateStr = "";
              if (item.attendanceDate != null) {
                dateStr = "${item.attendanceDate!.year}-${item.attendanceDate!.month.toString().padLeft(2, '0')}-${item.attendanceDate!.day.toString().padLeft(2, '0')}";
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: HistoryItem(
                  date: dateStr,
                  subtitle: "Regular Class Day",
                  status: item.attendanceStatus ?? "Unknown",
                  statusColor: statusColor,
                  icon: iconData,
                  iconBg: statusColor.withValues(alpha: 0.1),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
