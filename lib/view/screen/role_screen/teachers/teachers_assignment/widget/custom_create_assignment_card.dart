import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_button/custom_button.dart';

class CustomCreateAssignmentCard extends StatelessWidget {
  final String? grade;
  final String? subject;
  final String? submission;
  final String? time;
  final int? progressValue;
  final String? status;
  final String? homeWork;
  final VoidCallback onTapEdit;
  final VoidCallback onTapView;

  const CustomCreateAssignmentCard({
    super.key,
    this.grade,
    this.subject,
    this.submission,
    this.time,
    this.progressValue,
    this.status,
    this.homeWork,
    required this.onTapView,
    required this.onTapEdit,
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
          CustomText(
            text: grade ?? "",
            fontSize: 10.sp,
            color: Colors.black87,
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today,size: 16,color: Colors.black45,),
                  CustomText(
                    text: "Due: $time" ??"",
                    fontSize: 10.sp,
                    color: Colors.black87,
                    right: 10.sp,
                    left: 10,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.people,size: 18,color: Colors.black45,),
                  CustomText(
                    text: "$submission Submitted" ??"",
                    fontSize: 10.sp,
                    color: Colors.black87,
                    left: 10,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          //status
          Row(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: status =="Active" ? AppColors.primary.withOpacity(0.2)  : Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: CustomText(text: status ?? "",fontSize: 10.sp, fontWeight: FontWeight.w600,color:status =="Active" ? AppColors.primary :Color(0xFF2563EB))
              ),
              SizedBox(width: 8.h),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color:  Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: CustomText(text: homeWork ?? "",fontSize: 10.sp, fontWeight: FontWeight.w600,color:Colors.black54)
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Submission Progress",
                fontSize: 12.sp,
                color: Colors.black45,
                bottom: 5,
              ),
              CustomText(
                text: "${progressValue ?? 0} %",
                fontSize: 12.sp,
                color: Colors.black45,
                bottom: 5,
              ),
            ],
          ),

          LinearProgressIndicator(
            value: (progressValue ?? 0) / 100,
            minHeight: 6,
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.primary,
            ),
          ),
          SizedBox(height: 15.h),
          // btn
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onTap: onTapEdit,
                  title: "Edit",
                  height: 36,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  fillColor: AppColors.grey_02 ,
                  textColor: Colors.black ,
                ),
              ),

              SizedBox(width: 6.w),

              Expanded(
                child: CustomButton(
                  onTap: onTapView,
                  title: "View",
                  height: 36,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  fillColor: AppColors.primary,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),


        ],
      ),
    );
  }
}