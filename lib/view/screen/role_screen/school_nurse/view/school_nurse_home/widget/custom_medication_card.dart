import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:america_ayber_squad/view/components/custom_button/custom_button.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicationCard extends StatelessWidget {
  final String? name;
  final String? grade;
  final String? medication;
  final String? time;
  final VoidCallback? onAdministerTap;
  final VoidCallback? onSnoozeTap;

  const MedicationCard({
    Key? key,
    this.name,
    this.grade,
    this.medication,
    this.time,
    this.onAdministerTap,
    this.onSnoozeTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name and Grade
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: "$name ($grade)", fontSize: 14.sp, fontWeight: FontWeight.w600),
              CustomText(text: time ?? "", fontSize: 12.sp, color: Colors.grey),
            ],
          ),
          SizedBox(height: 8),
          // Medication Info
          CustomText(text: "Medication:", fontSize: 12.sp, fontWeight: FontWeight.w400, color: Colors.grey),
          SizedBox(height: 16),
          // Action buttons
          Row(
            children: [
              CustomButton(
                  onTap: onSnoozeTap,
                  title: "Administer",
                fontSize: 10.sp,
                height: 40,
                width: 100,
              ),
              SizedBox(width: 10,),
              CustomButton(
                onTap: onAdministerTap,
                title: "Snooze",
                fontSize: 10.sp,
                height: 40,
                width: 100,
                fillColor: Colors.white,
                isBorder: true,
                borderWidth: 1,
                borderColor: AppColors.grey_02,
                textColor: AppColors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
