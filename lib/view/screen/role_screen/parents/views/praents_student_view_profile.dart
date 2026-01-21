import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:america_ayber_squad/view/components/custom_button/custom_button.dart';
import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PraentsStudentViewProfile extends StatelessWidget {
  const PraentsStudentViewProfile({super.key});
  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context, designSize: Size(375, 812), minTextAdapt: true);

    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(
          titleName: "Student Details",
          leftIcon: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Text(
                  "Grade 11-A • ST-2024-001",
                  style: TextStyle(fontSize: 14.sp, color: Colors.black.withOpacity(0.7)),
                ),
                SizedBox(height: 20.h),
      
                // Academic Overview
                Text(
                  "Academic Overview",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.h),
                InfoCard(
                  icon: Icons.access_time,
                  title: "92%",
                  subtitle: "Attendance",
                ),
                InfoCard(
                  icon: Icons.grade,
                  title: "3.8",
                  subtitle: "GPA",
                ),
                InfoCard(
                  icon: Icons.book,
                  title: "Grade 11-A",
                  subtitle: "Current Grade",
                ),
                SizedBox(height: 20.h),
      
                // Personal Information
                Text(
                  "Personal Information",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.h),
                InfoCard(
                  icon: Icons.calendar_today,
                  title: "March 15, 2009",
                  subtitle: "Date of Birth",
                ),
                InfoCard(
                  icon: Icons.bloodtype,
                  title: "O+",
                  subtitle: "Blood Group",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// InfoCard Widget for displaying the information cards
class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const InfoCard({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Icon(icon, size: 24.sp, color: AppColors.primary),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 4.h),
                Text(subtitle, style: TextStyle(fontSize: 12.sp, color: Colors.black.withOpacity(0.6))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
