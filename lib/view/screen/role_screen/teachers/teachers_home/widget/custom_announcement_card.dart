import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAnnouncementCard extends StatelessWidget {
  final String? title;
  final String? content;
  final String? date;
  final VoidCallback? onTap;

  const CustomAnnouncementCard({
    super.key,
    this.title,
    this.content,
    this.date,
    this.onTap,
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
                    text: title ?? "",
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(width: 8.w),
                CustomText(
                  text: date ?? "",
                  fontSize: 10.sp,
                  color: Colors.grey,
                ),
              ],
            ),
            SizedBox(height: 8.h),
            CustomText(
              text: content ?? "",
              fontSize: 12.sp,
              color: Colors.black87,
              maxLines: 3,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
