import 'package:america_ayber_squad/view/components/custom_button/custom_button.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

class CustomScheduleItem extends StatelessWidget {
  final String? subject;
  final String? details;
  final String? time;
  final Color? color;
  final String? status;
  final bool isActive;
  final VoidCallback onTap;

  const CustomScheduleItem({
    super.key,
    this.subject,
    this.details,
    this.time,
    this.color,
    this.status,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(color: Colors.grey.shade100, blurRadius: 10, offset: const Offset(0, 5)),
            ],
          ),
          child: Row(
            children: [
              // --- Color Bar Section ---
              Container(
                width: 5,
                height: 50,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(5)
                ),
              ),
              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Title & Time ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(text: subject ?? "Subject Name", fontWeight: FontWeight.w600, fontSize: 16),
                        CustomText(text: time ?? "00:00 - 00:00", color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400,),

                        // Text(
                        //   time ?? "00:00 - 00:00",
                        //   style: TextStyle(color: Colors.grey[500], fontSize: 12),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 5),

                    // --- Details ---
                    CustomText(text: details ?? "Room 101 • Teacher Name", color: Colors.grey, fontSize: 13),

                    // Text(
                    //   details ?? "Room 101 • Teacher Name",
                    //   style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    // ),
                    const SizedBox(height: 8),

                    // --- Status ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isActive ? Colors.green.shade50 : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: CustomText(
                            text: status ?? "Status",
                            color: isActive ? Colors.green : Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),

                        ),
                        // CustomButton(
                        //     onTap: onTap,
                        //     title: "Join Now",
                        //     height: 30,
                        //     width: 100,
                        //     fontSize: 12,
                        // )
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
