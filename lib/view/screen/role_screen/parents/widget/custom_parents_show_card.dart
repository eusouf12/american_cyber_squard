import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../components/custom_text/custom_text.dart';

class CustomParentsShowCard extends StatelessWidget {
  final String? count;
  final String? label;
  final IconData icon;
  final Color? iconColor;

  const CustomParentsShowCard({
    super.key,
    this.count,
    this.label,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: 200.w,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor?.withOpacity(0.1) ??
                  Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor ?? AppColors.white,
              size: 24,
            ),
          ),
          Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Amount/Count Text
                    CustomText(
                      text: count ?? '',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    // Label Text
                    CustomText(
                      text: label ?? '',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white.withOpacity(0.8),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}