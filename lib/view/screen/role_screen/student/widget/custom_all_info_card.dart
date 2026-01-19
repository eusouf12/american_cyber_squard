import 'package:flutter/material.dart';

class CustomAllInfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String count;
  final IconData icon;
  final Color cardColor;
  final Color textColor;

  const CustomAllInfoCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.count,
    required this.icon,
    this.cardColor = const Color(0xFFFDFFA8), // Light Yellowish default color
    this.textColor = Colors.black, // Default text color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor, // Customizable background color
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Icon Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 40,),
              Icon(
                icon,
                size: 20,
                color: textColor,
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Subtitle
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),

          // Count
          Text(
            count,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
