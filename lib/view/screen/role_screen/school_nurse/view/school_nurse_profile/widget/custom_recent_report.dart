import 'package:america_ayber_squad/view/components/custom_button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../components/custom_text/custom_text.dart';

class CustomRecentReport extends StatelessWidget {
  final String title;
  final String studentName;
  final String grade;
  final String date;

  const CustomRecentReport({
    Key? key,
    required this.title,
    required this.studentName,
    required this.grade,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Incident Title using CustomText widget
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: title,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              SizedBox(height: 8.h),
              CustomButton(
                onTap: (){},
                height: 30,
                width: 100,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                title: date,
              ),
            ],
          ),

          // Student Name and Grade using CustomText widget
          CustomText(
            text: '$studentName ($grade)',
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),

          // Date button using ElevatedButton
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: ElevatedButton(
          //     onPressed: () {},
          //     style: ElevatedButton.styleFrom(
          //       primary: Colors.grey.withOpacity(0.2),
          //       onPrimary: Colors.black,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          //     ),
          //     child: CustomText(
          //       text: date,
          //       fontSize: 10.sp,
          //       fontWeight: FontWeight.w400,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
