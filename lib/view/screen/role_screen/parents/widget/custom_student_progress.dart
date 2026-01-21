import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../controller/academic_controller.dart';

class AttendanceTrendContainer extends StatelessWidget {
  final TabControllerX controller;

  // Constructor to accept the controller
  const AttendanceTrendContainer({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch data from the controller
    final attendanceData = controller.getAttendanceData();
    final attendancePercentage = controller.getAttendancePercentage();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Attendance Status Text
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 20.sp),
                  SizedBox(width: 5.w),
                  Text(
                    "Present ($attendancePercentage)",
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                  ),
                ],
              ),
              Text(
                "Attendance Trend",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 20.h),


          // Bar Chart displaying the trend
          SizedBox(
            height: 220.h,
            child: BarChart(
              BarChartData(
                gridData: const FlGridData(show: false),
                alignment: BarChartAlignment.spaceAround,
                titlesData: const FlTitlesData(
                  show: true,
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(attendanceData.length, (index) {
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(

                        toY: attendanceData[index].toDouble(),
                        color: AppColors.primary.withOpacity(0.6),
                        width: 20.w,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}