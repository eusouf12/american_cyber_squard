import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomGradeSummaryCard extends StatelessWidget {
  final String? count;
  final String? label;

  const CustomGradeSummaryCard({
    super.key,
    this.count,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 130,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.primary2,
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Count Text (Bold)
          Text(
            count ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.white),
          ),
          const SizedBox(height: 5),
          // Label Text (Grey color)
          Text(
            label ?? '',
            style: TextStyle(color: AppColors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
