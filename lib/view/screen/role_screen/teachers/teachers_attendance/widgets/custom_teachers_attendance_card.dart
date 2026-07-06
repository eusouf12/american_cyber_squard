import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomTeachersAttendanceCard extends StatelessWidget {
  final String? count;
  final String? label;
  final IconData icon;

  const CustomTeachersAttendanceCard({
    super.key,
    this.count,
    this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color baseColor;
    List<Color> gradientColors;

    final type = count?.toLowerCase() ?? '';
    if (type == 'present') {
      baseColor = const Color(0xFF10B981);
      gradientColors = [const Color(0xFF34D399), const Color(0xFF059669)];
    } else if (type == 'absent') {
      baseColor = const Color(0xFFEF4444);
      gradientColors = [const Color(0xFFF87171), const Color(0xFFDC2626)];
    } else if (type == 'late') {
      baseColor = const Color(0xFFF59E0B);
      gradientColors = [const Color(0xFFFBBF24), const Color(0xFFD97706)];
    } else {
      baseColor = AppColors.primary;
      gradientColors = [AppColors.primary.withValues(alpha: 0.8), AppColors.primary];
    }

    return Container(
      width: 100.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: baseColor.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
          SizedBox(height: 8.h),
          CustomText(
            text: count ?? '',
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2.h),
          CustomText(
            text: label ?? '0',
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
