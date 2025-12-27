import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../components/custom_text/custom_text.dart';

class StudentAttandancePointCard extends StatelessWidget {
  const StudentAttandancePointCard({
    super.key,
    this.point,
    this.title,
    required this.textColor,
    required this.bgColor,
  });

  final String? point;
  final String? title;
  final Color textColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: const EdgeInsets.all(4),
        height: 118.h,
        width: MediaQuery.sizeOf(context).width / 3.6,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: point ?? "0",
              fontSize: 24.w,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
            const SizedBox(height: 4),
            CustomText(
              text: title ?? "",
              fontSize: 16.w,
              fontWeight: FontWeight.w400,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
