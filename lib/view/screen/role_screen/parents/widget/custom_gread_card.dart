import 'package:flutter/material.dart';
import '../../../../components/custom_text/custom_text.dart';

class CustomSubjectGradeCard extends StatelessWidget {
  final String? gradeLetter;
  final String? subjectName;
  final String ?teacherName;
  final String? averageScore;
  final Color? brandColor;

  const CustomSubjectGradeCard({
    super.key,
     this.gradeLetter,
     this.subjectName,
     this.teacherName,
     this.averageScore,
    this.brandColor = const Color(0xFF00A86B),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: brandColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomText(
              text: gradeLetter ?? "",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: subjectName ?? "",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                ),
                CustomText(
                  text: teacherName ??"",
                  fontSize: 13,
                  color: Colors.grey[600]!,
                  top: 2,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomText(
                text: averageScore ??"",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                text: "Average",
                fontSize: 12,
                color: Colors.grey[500]!,
                top: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}