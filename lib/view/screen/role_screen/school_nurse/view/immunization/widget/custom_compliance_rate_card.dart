import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';

class ComplianceRateCard extends StatelessWidget {
  final String? title;
  final double? complianceRate;
  final IconData icon;

  const ComplianceRateCard({
    Key? key,
    this.title,
    this.complianceRate,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side: Title and Compliance Rate
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomText(
                    text: title ?? "Compliance Rate",
                    fontSize: 14.sp,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  Icon(
                    icon,
                    size: 24.sp,
                    color: Colors.green,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              CustomText(
                text: "${complianceRate?.toStringAsFixed(0)}%",
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              SizedBox(width: 8.w),
              Column(
                children: [
                  Container(
                    width: 300.w,
                    height: 8.h,
                    child: LinearProgressIndicator(
                      value: complianceRate! / 100,
                      backgroundColor: Colors.grey.withOpacity(0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
