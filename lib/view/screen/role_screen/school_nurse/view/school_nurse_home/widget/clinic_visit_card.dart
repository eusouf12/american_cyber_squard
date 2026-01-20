import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../utils/app_colors/app_colors.dart';

class ClinicVisitCard extends StatelessWidget {
  final String? name;
  final String? grade;
  final String? time;
  final VoidCallback? onTap;

  const ClinicVisitCard({
    Key? key,
    this.name,
    this.grade,
    this.time,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.greyLight.withOpacity(0.2),
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
                CustomText(text: grade ?? "", fontSize: 10.sp,color: Colors.black.withOpacity(0.7),),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.access_time_outlined, size: 18, color: Colors.grey,),
                    SizedBox(width: 10,),
                    CustomText(text: time ?? "", fontSize: 10.sp,color: Colors.grey,),
                  ],
                ),
              ],
            ),
            // More button (three dots)
            IconButton(
              onPressed: onTap ?? () {},
              icon: Icon(Icons.more_vert),
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );

  }
}
