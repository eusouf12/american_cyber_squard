import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../components/custom_button/custom_button.dart';

class TeacherMyStudentCard extends StatelessWidget {
  final String? grade;
  final String? subject;
  final String? phone;
  final String? email;
  final String? studentId;
  final VoidCallback? onTapView;

  const TeacherMyStudentCard({
    super.key,
    this.grade,
    this.subject,
    this.email,
    this.phone,
    this.studentId,
    this.onTapView,
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
            color: Colors.black.withValues(alpha: 0.03),
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
              if (studentId != null)
                CustomText(
                  text: "ID: $studentId",
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
            ],
          ),
          SizedBox(height: 6.h),
          //email
          Row(
                children: [
                  Icon(Icons.email,size: 16,color: Colors.black45,),
                  CustomText(
                    text: email ??"",
                    fontSize: 10.sp,
                    color: Colors.black87,
                    right: 10.sp,
                    left: 10,
                  ),
                ],
              ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.call,size: 18,color: Colors.black45,),
              CustomText(
                text: phone ??"",
                fontSize: 10.sp,
                color: Colors.black87,
                left: 10,
              ),
            ],
          ),
          SizedBox(height: 8.h),


          // btn
          CustomButton(
            onTap: onTapView,
            title: "View",
            height: 36,
            width: 100,
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
          )

        ],
      ),
    );
  }
}