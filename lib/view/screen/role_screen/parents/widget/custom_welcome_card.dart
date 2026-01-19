import 'package:flutter/material.dart';
import '../../../../components/custom_text/custom_text.dart';


class CustomPrimaryCard extends StatelessWidget {
  final String title;
  final String description;
  final String statusText;
  final IconData icon;

  const CustomPrimaryCard({
    super.key,
    required this.title,
    required this.description,
    required this.statusText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor, // আপনার অ্যাপের Primary Color
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title using CustomText
          CustomText(
            text: title,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            textAlign: TextAlign.start,
          ),

          // Description using CustomText
          CustomText(
            text: description,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white.withOpacity(0.9),
            top: 8,
            maxLines: 2,
            textAlign: TextAlign.start,
          ),

          const SizedBox(height: 20),

          // Status Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                // Status Text using CustomText
                CustomText(
                  text: statusText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}