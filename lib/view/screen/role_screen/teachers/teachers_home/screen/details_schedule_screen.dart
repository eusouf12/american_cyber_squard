import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:america_ayber_squad/view/screen/role_screen/teachers/teachers_home/model/teacher_schedule.dart';

class DetailsScheduleScreen extends StatelessWidget {
  const DetailsScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RoutineModel routine = Get.arguments as RoutineModel;

    return CustomGradient(
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: const CustomRoyelAppbar(
          titleName: "Schedule Details",
          leftIcon: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Main Card Displaying Subject and Timing ---
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withValues(alpha: 0.85),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: CustomText(
                              text: routine.isOnline == true ? "ONLINE SESSION" : "IN-PERSON",
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            routine.isOnline == true ? Icons.videocam : Icons.room,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      CustomText(
                        text: routine.assignableSubject ?? "No Subject",
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 6.h),
                      CustomText(
                        text: routine.classLevel ?? "No Class Level",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.85),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // --- Section Title ---
                CustomText(
                  text: "Schedule Information",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black_02,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 12.h),

                // --- Details Grid/List ---
                _buildDetailTile(
                  icon: Icons.calendar_today_rounded,
                  title: "Day of Week",
                  value: routine.day ?? "N/A",
                ),
                _buildDetailTile(
                  icon: Icons.access_time_filled_rounded,
                  title: "Class Time",
                  value: routine.time ?? "N/A",
                ),
                _buildDetailTile(
                  icon: Icons.meeting_room_rounded,
                  title: "Room Number",
                  value: routine.roomNumber ?? "N/A",
                ),
                _buildDetailTile(
                  icon: Icons.people_alt_rounded,
                  title: "Class Capacity",
                  value: routine.capacity != null ? "${routine.capacity} Students" : "N/A",
                ),
                _buildDetailTile(
                  icon: Icons.check_circle_rounded,
                  title: "Session Status",
                  value: routine.isOnline == true ? "Online Session via Portal" : "On-Campus Class",
                ),

                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.015),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.primary1,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade500,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 2.h),
                CustomText(
                  text: value,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
