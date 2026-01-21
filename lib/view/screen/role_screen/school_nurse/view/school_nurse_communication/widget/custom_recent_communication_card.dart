import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../components/custom_text/custom_text.dart';

class CustomRecentCommunicationCard extends StatelessWidget {
  final String? recipient;
  final String? studentName;
  final String? reason;
  final String? time;

  const CustomRecentCommunicationCard({
    Key? key,
    this.recipient,
    this.studentName,
    this.reason,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.w),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.email_outlined,
                size: 20.sp,
                color: AppColors.black,
              ),
              SizedBox(width: 8.w),
              CustomText(
                text: 'To: $recipient',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
              Spacer(),
              CustomText(
                text: time ?? "",
                fontSize: 8.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          CustomText(
            text: 'Student: $studentName',
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
          SizedBox(height: 5.h),
          CustomText(
            text: 'Reason: $reason',
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),

        ],
      ),
    );
  }
}
