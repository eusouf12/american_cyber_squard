import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGradeSummaryCard extends StatelessWidget {
  final String? count;
  final String? label;

  const CustomGradeSummaryCard({
    super.key,
    this.count,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: 200.w,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.primary,
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Count Text (Bold)
          Text(
            count ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.white),
          ),
          const SizedBox(height: 5),
          // Label Text (Grey color)
          CustomText(text: label ?? "", fontSize: 12.sp, fontWeight: FontWeight.w400, color: AppColors.white),
        ],
      ),
    );
  }
}
