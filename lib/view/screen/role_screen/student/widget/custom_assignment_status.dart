import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

class CustomGradedCard extends StatelessWidget {
  final String? title;
  final String? subject;
  final String? grade;
  final double? percentage;
  final String? gradedDate;

  const CustomGradedCard({
    super.key,
    this.title,
    this.subject,
    this.grade,
    this.percentage,
    this.gradedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Title & Grade
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: CustomText(
                      text: title ?? "English Literature Analysis",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Text("Grade: ${grade ?? "A-"}",
                        style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 11,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(width: 4),
                    const Icon(Icons.emoji_events_outlined,
                        size: 14, color: Colors.grey),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 5),

          CustomText(
              text: "Subject",
              fontSize: 13,
              color: Colors.grey,
              fontWeight: FontWeight.w500),
          const SizedBox(height: 15),

          // Grade & Progress Bar Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Grade",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text("${(percentage! * 100).toInt()}%",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              value: percentage ?? 0.75,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              color: Colors.blueGrey.shade700,
            ),
          ),
          const SizedBox(height: 15),

          // Footer: Graded Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("Graded:",
                      style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                  const SizedBox(width: 5),
                  Text(gradedDate ?? "Sep 28, 2025",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5)),
                child: CustomText(text: 'Graded', color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500,)
              )
            ],
          ),
        ],
      ),
    );
  }
}
