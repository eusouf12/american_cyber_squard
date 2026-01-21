import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../utils/app_colors/app_colors.dart';

class CustomTodayScheduleCard extends StatelessWidget {
  final String? name;
  final String? subject;
  final String? time;

  const CustomTodayScheduleCard({
    super.key,
    this.name,
    this.subject,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.09),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: name ?? "", fontWeight: FontWeight.w500,fontSize: 14.sp,),
                SizedBox(height: 4),
                CustomText(text: subject ?? "", fontSize: 12.sp,color: Colors.grey)
              ],
            ),
            CustomText(text: time ?? "", fontWeight: FontWeight.w500,fontSize: 14.sp,color: AppColors.primary),
          ],
        ),
      ),
    );

  }
}
