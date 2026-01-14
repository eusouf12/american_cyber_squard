import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

class CustomGradeCard extends StatelessWidget {
  final String? subject;
  final String? grade;
  final String? avg;
  final IconData? icon;
  final Color? color;

  const CustomGradeCard({
    super.key,
    this.subject,
    this.grade,
    this.avg,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade100, blurRadius: 5, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color?.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  shape: BoxShape.circle,
                ),
                child: CustomText(
                    text: grade ?? "A",
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: 16
                ),

                // Text(
                //   grade ?? "Grade",
                //   style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12),
                // ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: subject ?? "Subject", fontWeight: FontWeight.w600, fontSize: 16),
              const SizedBox(height: 4),
              CustomText(text: avg ?? "Average", color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 12),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: 0.82,
                backgroundColor: Colors.grey.shade200,
                color: color,
                minHeight: 4,
                borderRadius: BorderRadius.circular(5),
              )
            ],
          ),
        ],
      ),
    );
  }
}
