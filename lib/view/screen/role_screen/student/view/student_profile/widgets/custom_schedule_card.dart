import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../utils/app_colors/app_colors.dart';

class CustomScheduleCard extends StatelessWidget {
  const CustomScheduleCard({
    super.key,
    required this.status,
    this.subject,
    this.teacher,
    this.room,
  });

  final ClassStatus status;
  final String? subject;
  final String? teacher;
  final String? room;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case ClassStatus.breakTime:
        return customOfflineCard(
          bgColor: Colors.amber.shade100.withOpacity(0.4),
          borderColor: Colors.amber.withOpacity(0.2),
        );

      case ClassStatus.free:
        return customOfflineCard(
          bgColor: Colors.grey.shade100,
          borderColor: Colors.grey.withOpacity(0.2),
        );

      case ClassStatus.online:
        return customOfflineCard(
          bgColor: AppColors.primary.withOpacity(0.2),
          icon: Icons.videocam,
          iconColor: AppColors.primary,
          borderColor: AppColors.primary.withOpacity(0.2),
        );

      case ClassStatus.offline:
        return customOfflineCard(
          bgColor: Colors.red.withOpacity(0.1),
          icon: Icons.location_on,
          iconColor: Colors.red,
          borderColor: Colors.red.withOpacity(0.2),
        );
    }
  }

  Widget customOfflineCard({
     Color? bgColor,
     IconData? icon,
     Color? iconColor,
    Color? borderColor,
  }) {
    return Container(
      height: 140.h,
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subject ?? "",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            teacher ?? "",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(icon, color: iconColor, size: 18.sp),
              SizedBox(width: 6.w),
              Text(
                (status == ClassStatus.offline)
                    ? (room ?? "")
                    : (status == ClassStatus.free || status == ClassStatus.breakTime)
                    ? ""
                    : "Join Zoom",

                style: TextStyle(
                  fontSize: 14.sp,
                  color: iconColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
enum ClassStatus {
  free,
  breakTime,
  online,
  offline,
}
