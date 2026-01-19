import 'package:america_ayber_squad/view/components/custom_button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_text/custom_text.dart';


class CustomPrimaryCard extends StatelessWidget {
  final String title;
  final String? inboxTitle;
  final bool? isInbox;
  final IconData? icon;
  final String description;

  const CustomPrimaryCard({
    super.key,
    required this.title,
    this.isInbox = false,
    this.inboxTitle,
    this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          CustomText(
            text: title,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            textAlign: TextAlign.start,
          ),

          // Description
          CustomText(
            text: description,
            fontSize: 11.sp,
            color: Colors.white.withOpacity(0.9),
            top: 8,
            bottom: 20,
            maxLines: 4,
            textAlign: TextAlign.start,
          ),
          isInbox== true ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(icon ?? Icons.group,color: Colors.white,),
                SizedBox(width: 12.w,),
                CustomText(text: inboxTitle ?? "2 Students Linked",
                  fontSize: 12.sp,fontWeight: FontWeight.w600,color: Colors.white,
                )
              ],
            ),

          )
          : SizedBox.shrink(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}