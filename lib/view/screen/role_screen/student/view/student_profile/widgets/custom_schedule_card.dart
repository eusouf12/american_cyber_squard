import 'package:america_ayber_squad/view/components/custom_button/custom_button.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomScheduleCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? buttonText;
  final VoidCallback? onPressed;
  final Color? cardColor;
  final bool online;
  final bool offline;
  final bool breakTime;



  const CustomScheduleCard({
    Key? key,
    this.title,
    this.subtitle,
    this.buttonText,
    this.onPressed,
    this.cardColor,
    this.offline=false,
    this.online=false,
    this.breakTime=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: title ?? "History", fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.green.shade700),
              Icon(Icons.location_on, color: Colors.green.shade700, size: 20.sp),
            ],
          ),
          SizedBox(height: 8.h),
          CustomText(text: subtitle ?? "Mr. Wilson", fontSize: 12.sp, color: Colors.green.shade600),
          SizedBox(height: 16),
          online == true
              ? CustomButton(
            height: 40.h,
            width: 100.w,
            icon: Icon( Icons.videocam, color: Colors.white, size: 20.sp),
            onTap: onPressed,
            title: buttonText ?? "Join Zoom",
            fontSize: 10.sp,
          ): SizedBox.shrink(),
          offline == false
              ? CustomButton(
            height: 40.h,
            width: 150.w,
            onTap: onPressed,
            icon: Icon(Icons.location_on, color: Colors.white, size: 20.sp),
            title: buttonText ?? "Room 105",
            fontSize: 12.sp,
          ): SizedBox(),
          breakTime == false
              ? SizedBox() : SizedBox(),
        ],
      ),
    );
  }
}

//hi eusouf
