import 'package:america_ayber_squad/view/components/custom_button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../components/custom_text/custom_text.dart';

class CustomParentShowProfile extends StatelessWidget {
  final String? name;
  final String? grade;
  final String? attendance;
  final String? nextExam;
  final VoidCallback onViewProfile;

  const CustomParentShowProfile({
    super.key,
    required this.name,
    required this.grade,
    required this.attendance,
    required this.nextExam,
    required this.onViewProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: name ?? "",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.start,
          ),
          CustomText(
            text: grade ?? "",
            fontSize: 14,
            color: Colors.grey[600]!,
            top: 4,
            textAlign: TextAlign.start,
          ),

          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFF1F1F1)),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Attendance",
                fontSize: 15,
                color: Colors.grey[600]!,
              ),
              CustomText(
                text: attendance ??"",
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF00A86B),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Next Exam",
                fontSize: 15,
                color: Colors.grey[600]!,
              ),
              CustomText(
                text: nextExam ?? "",
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ],
          ),

          const SizedBox(height: 20),
          CustomButton(
            onTap: () {},
            title: "View Profile",
            height: 48,
            width: 130,
            fontSize: 10.sp,
          ),
        ],
      ),
    );
  }
}