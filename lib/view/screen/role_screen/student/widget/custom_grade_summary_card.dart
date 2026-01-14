import 'package:flutter/material.dart';

class CustomGradeSummaryCard extends StatelessWidget {
  final String? count;
  final String? label;
  final List<Color>? gradientColors;

  const CustomGradeSummaryCard({
    super.key,
    this.count,
    this.label,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: gradientColors ?? [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 3)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Vertically center the content
          children: [
            // Count Text (Bold)
            Text(
              count ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 5),
            // Label Text (Grey color)
            Text(
              label ?? '',
              style: TextStyle(color: Colors.grey[800], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
