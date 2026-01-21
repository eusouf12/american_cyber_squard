import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomAttendanceCardTeacher extends StatelessWidget {
  final String? name;
  final String? email;
  final String? number;
  final String? parentsName;

  final bool isPresent;
  final bool isAbsent;
  final bool isLate;

  final VoidCallback? onTapPresent;
  final VoidCallback? onTapAbsent;
  final VoidCallback? onTapLate;
  final VoidCallback? onTapMail;

  const CustomAttendanceCardTeacher({
    super.key,
    this.name,
    this.email,
    this.number,
    this.parentsName,
    this.isPresent = false,
    this.isAbsent = false,
    this.isLate = false,
    this.onTapPresent,
    this.onTapAbsent,
    this.onTapLate,
    this.onTapMail,
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
          /// Parent + Student
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Parent
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Parent Name",
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                  CustomText(
                    text: parentsName ?? "",
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: Colors.black87,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),

              // Student
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Student Name",
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                  CustomText(
                    text: name ?? "",
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: Colors.black87.withOpacity(0.6),
                  ),
                ],
              ),
            ],
          ),

          CustomText(
            text: number ?? "",
            fontSize: 11.sp,
            color: Colors.grey.shade600,
            top: 5,
            bottom: 3,
          ),

          CustomText(
            text: email ?? "",
            fontSize: 11.sp,
            color: Colors.grey.shade600,
          ),

          SizedBox(height: 20),

          // Buttons
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onTap: onTapPresent,
                  title: "Present",
                  height: 36,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  fillColor:
                  isPresent ? AppColors.primary : Colors.grey.shade300,
                  textColor:
                  isPresent ? Colors.white : Colors.black54,
                ),
              ),

              SizedBox(width: 8.w),

              Expanded(
                child: CustomButton(
                  onTap: onTapAbsent,
                  title: "Absent",
                  height: 36,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  fillColor: isAbsent
                      ? AppColors.red.withOpacity(0.7)
                      : Colors.grey.shade300,
                  textColor:
                  isAbsent ? Colors.white : Colors.black54,
                ),
              ),

              SizedBox(width: 8.w),

              Expanded(
                child: CustomButton(
                  onTap: onTapLate,
                  title: "Late",
                  height: 36,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  fillColor:
                  isLate ? Colors.amber : Colors.grey.shade300,
                  textColor:
                  isLate ? Colors.white : Colors.black54,
                ),
              ),

              SizedBox(width: 8.w),

              if (isAbsent)
                GestureDetector(
                  onTap: onTapMail,
                  child: Container(
                    height: 36,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00B87C),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.mail_outline,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
