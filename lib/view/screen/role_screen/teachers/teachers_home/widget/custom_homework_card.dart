import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/app_colors/app_colors.dart';

class CustomHomeworkCard extends StatelessWidget {
  final String? grade;
  final String? subject;
  final String? chapter;
  final String? time;
  final String? status;
  final VoidCallback onTap;

  const CustomHomeworkCard({
    super.key,
    this.grade,
    this.subject,
    this.chapter,
    this.time,
    this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: subject ?? "",
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 6.h),
                  CustomText(
                    text: chapter ?? "",
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 6.h),
                  CustomText(
                    text: grade ?? "",
                    fontSize: 10.sp,
                    color: Colors.black,
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    text: "Due: $time" ??"",
                    fontSize: 10.sp,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: status =="Pending" ? Color(0xFFFFF9C4) : status =="Completed" ? AppColors.primary.withOpacity(0.2) :AppColors.red.withOpacity(0.2) ,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: CustomText(text: status ?? "Overdue",fontSize: 10.sp, fontWeight: FontWeight.w600,color:status =="Completed" ? AppColors.primary :Color(0xFF827717),)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}