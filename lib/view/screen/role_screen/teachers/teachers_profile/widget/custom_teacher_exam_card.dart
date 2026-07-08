import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_button/custom_button.dart';

class CustomTeacherExamCard extends StatelessWidget {
  final String? grade;
  final String? subject;
  final String? submission;
  final String? date;
  final bool? isCompleted;
  final String? duration;
  final String? totalMarks;
  final VoidCallback? onTapView;
  final VoidCallback? onTapEdit;
  final VoidCallback? onTapGrade;

  const CustomTeacherExamCard({
    super.key,
    this.grade,
    this.subject,
    this.date,
    this.submission,
    this.isCompleted,
    this.duration,
    this.totalMarks,
    this.onTapView,
    this.onTapEdit,
    this.onTapGrade,
  });

  String _formatDate(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return "N/A";
    try {
      final DateTime parsed = DateTime.parse(rawDate);
      return DateFormat('MMM dd, yyyy').format(parsed);
    } catch (_) {
      if (rawDate.contains('T')) {
        return rawDate.split('T').first;
      }
      return rawDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    String calculatedStatus = "Upcoming";
    Color statusColor = const Color(0xFF2563EB);
    Color statusBgColor = const Color(0xFF2563EB).withValues(alpha: 0.1);

    if (isCompleted == true) {
      calculatedStatus = "Completed";
      statusColor = AppColors.primary;
      statusBgColor = AppColors.primary.withValues(alpha: 0.1);
    } else {
      DateTime? examDateTime;
      if (date != null && date!.isNotEmpty) {
        try {
          examDateTime = DateTime.parse(date!);
        } catch (_) {}
      }

      final now = DateTime.now();
      if (examDateTime != null && examDateTime.isAfter(now)) {
        calculatedStatus = "Upcoming";
        statusColor = const Color(0xFF2563EB);
        statusBgColor = const Color(0xFF2563EB).withValues(alpha: 0.1);
      } else {
        calculatedStatus = "Pending";
        statusColor = const Color(0xFFEF4444);
        statusBgColor = const Color(0xFFEF4444).withValues(alpha: 0.1);
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomText(
                  text: subject ?? "",
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  color: const Color(0xFF1F2937),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: CustomText(
                  text: calculatedStatus,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          CustomText(
            text: grade ?? "",
            fontSize: 12.sp,
            color: Colors.grey.shade600,
            textAlign: TextAlign.start,
            maxLines: 20,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.access_time_outlined,
                        size: 14.sp, color: Colors.grey.shade500),
                    SizedBox(width: 6.w),
                    CustomText(
                      text: duration != null ? "$duration" : "N/A",
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.grade_outlined,
                        size: 14.sp, color: Colors.grey.shade500),
                    SizedBox(width: 6.w),
                    CustomText(
                      text: totalMarks != null ? "$totalMarks Marks" : "N/A",
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined,
                  size: 14.sp, color: Colors.grey.shade500),
              SizedBox(width: 6.w),
              CustomText(
                text: _formatDate(date),
                fontSize: 12.sp,
                color: Colors.grey.shade600,
                maxLines: 1,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.centerLeft,
            child: calculatedStatus == "Completed"
                ? CustomButton(
                    onTap: onTapView,
                    title: "View Results",
                    height: 36.h,
                    width: 120.w,
                    fontSize: 11.sp,
                    fillColor: const Color(0xFF2563EB).withValues(alpha: 0.1),
                    fontWeight: FontWeight.w500,
                    textColor: const Color(0xFF2563EB),
                  )
                : calculatedStatus == "Pending"
                    ? CustomButton(
                        onTap: onTapGrade,
                        title: "Grade Submissions",
                        height: 36.h,
                        width: 140.w,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      )
                    : CustomButton(
                        onTap: onTapEdit,
                        title: "Edit Exam",
                        height: 36.h,
                        width: 100.w,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        fillColor: Colors.grey.shade200,
                        textColor: Colors.black87,
                      ),
          ),
        ],
      ),
    );
  }
}
