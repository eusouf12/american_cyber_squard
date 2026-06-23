import 'package:flutter/material.dart';

class CustomAttendanceCard extends StatelessWidget {
  final String? day;
  final String? date;
  final String? status;
  final Color? color;

  const CustomAttendanceCard({
    super.key,
    this.day,
    this.date,
    this.status,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(day ?? "",
                    style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(date ?? "",
                    style: TextStyle(color: Colors.grey[500], fontSize: 13)),
              ],
            ),
          ),
          Text(status ?? "",
              style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(width: 10),
          Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[400]),
        ],
      ),
    );
  }
}
