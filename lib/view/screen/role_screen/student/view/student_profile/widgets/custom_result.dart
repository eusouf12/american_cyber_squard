import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../components/custom_text/custom_text.dart';

class CustomCard extends StatelessWidget {
  final String? subject;
  final String? date;
  final String? score;
  final String? grade;
  final String? status;

  CustomCard({
    this.subject,
    this.date,
    this.score,
    this.grade,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor = status == 'Graded' ? Colors.green : Colors.orange;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomText(
                    text: subject ?? "",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    maxLines: 10,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  child: CustomText(
                    text: status ?? "",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: statusColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            CustomText(text: date ?? "", fontSize: 14, color: Colors.grey),
            SizedBox(height: 8),
            Divider(color: AppColors.greyLight, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Score: $score'),
                Text('Grade: $grade'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
