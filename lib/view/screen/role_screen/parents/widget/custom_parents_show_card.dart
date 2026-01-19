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
      height: 130.h,
      width: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Color(0xFFFDFFA8), Color(0xFFC8E6C9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor?.withOpacity(0.1) ??Color(0xFF00A86B).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor ??Color(0xFF00A86B),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Amount/Count Text
              CustomText(
                text: count ?? '',
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 4),
              // Label Text
              CustomText(
                text: label ?? '',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ],
      ),
    );
  }
}