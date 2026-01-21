import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_button/custom_button.dart';

class CustomTeacherExamCard extends StatelessWidget {
  final String? grade;
  final String? subject;
  final String? submission;
  final String? date;
  final String? status;
  final VoidCallback? onTapView;
  final VoidCallback? onTapEdit;
  final VoidCallback? onTapGrade;

  const CustomTeacherExamCard({
    super.key,
    this.grade,
    this.subject,
    this.date,
    this.submission,
    this.status,
    this.onTapView,
    this.onTapEdit,
    this.onTapGrade,
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
            fontSize: 12,
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
                    color: status =="Completed" ? AppColors.primary.withOpacity(0.2)  : status =="Upcoming" ?Colors.blue.withOpacity(0.2) :Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: CustomText(text: status ?? "",fontSize: 10.sp, fontWeight: FontWeight.w500,color:status =="Completed" ?AppColors.primary :  status =="Upcoming" ?Colors.blue : Colors.red)
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
                    text: submission ??"",
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
          status =="Completed"
              ? CustomButton(
            onTap: onTapView,
            title: "View",
            height: 36,
            width: 100,
            fontSize: 10.sp,
            fillColor: Colors.blue.withOpacity(0.2),
            fontWeight: FontWeight.w400,
            textColor:Color(0xFF2563EB) ,
          )
              : status =="Pending"
              ? CustomButton(
            onTap: onTapGrade,
            title: "Grade View",
            height: 36,
            width: 100,
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
          )
          :  CustomButton(
            onTap: onTapEdit,
            title: "Edit",
            height: 36,
            width: 100,
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            fillColor: AppColors.grey_02 ,
            textColor: Colors.black ,
          )
        ],
      ),
    );
  }
}