import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

class CustomAssignmentCard extends StatelessWidget {
  final String? title;
  final String? dueText;
  final Color? bgColor;
  final String? chapterDetails;

  const CustomAssignmentCard({
    super.key,
    this.title,
    this.dueText,
    this.bgColor,
    this.chapterDetails
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          // --- Icon Section --- (Dynamic background color for icon container)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.edit, color: Colors.purple, size: 20),
          ),
          const SizedBox(width: 15),

          // --- Title and Details Section ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Title ---
                CustomText(text: title ?? "Math Homework", fontSize: 14, fontWeight: FontWeight.w600),
                const SizedBox(height: 5),
                CustomText(text: title ?? "Chapter details here", fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
              ],
            ),
          ),

          // --- Due Text Section (Red badge for due text) ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(5)),
            child: CustomText(text: dueText ?? "Due Tomorrow", fontSize: 10, fontWeight: FontWeight.w400, color: Colors.red)
          ),
        ],
      ),
    );
  }
}
