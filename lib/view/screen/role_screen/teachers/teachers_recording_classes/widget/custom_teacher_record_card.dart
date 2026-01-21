import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_button/custom_button.dart';

class CustomTeacherRecordCard extends StatelessWidget {
  final String? grade;
  final String? subject;
  final String? time;
  final String? date;
  final String? status;
  final VoidCallback onTapView;

  const CustomTeacherRecordCard({
    super.key,
    this.grade,
    this.subject,
    this.date,
    this.time,
    this.status,
    required this.onTapView,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          //grade
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: grade ?? "",
                fontSize: 10.sp,
                color: Colors.black87,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: status =="Available" ? AppColors.primary.withOpacity(0.2)  : Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: CustomText(text: status ?? "",fontSize: 10.sp, fontWeight: FontWeight.w500,color:status =="Available" ? AppColors.primary :Colors.red)
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today,size: 16,color: Colors.black45,),
                  CustomText(
                    text: date ??"",
                    fontSize: 10.sp,
                    color: Colors.black87,
                    right: 10.sp,
                    left: 10,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.alarm,size: 18,color: Colors.black45,),
                  CustomText(
                    text: time ??"",
                    fontSize: 10.sp,
                    color: Colors.black87,
                    left: 10,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          SizedBox(height: 8.h),

          // btn
          status =="Available"
              ? CustomButton(
                onTap: onTapView,
                title: "View Recording",
                height: 36,
                width: 150,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                icon: Icon(Icons.play_arrow,color: Colors.white),
              )
              : CustomButton(
                onTap: onTapView,
                title: "Recording Failed",
                height: 36,
                width: 150,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                fillColor: AppColors.grey_02 ,
                textColor: Colors.black ,
                icon: Icon(Icons.error_outline,color: Colors.grey),
              )
        ],
      ),
    );
  }
}