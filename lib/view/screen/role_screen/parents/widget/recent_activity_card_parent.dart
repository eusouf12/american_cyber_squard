import 'package:flutter/material.dart';

import '../../../../components/custom_text/custom_text.dart';

class ActivityItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;

  const ActivityItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: Color(0xFF00A86B),
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                fontSize: 15,
                maxLines: 5,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.start,
              ),
              CustomText(
                text: subtitle,
                fontSize: 13,
                maxLines: 5,
                color: Colors.grey[600]!,
                top: 2,
                textAlign: TextAlign.start,
              ),
              CustomText(
                text: time,
                fontSize: 12,
                color: Colors.grey[400]!,
                top: 4,
                bottom: 20,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}