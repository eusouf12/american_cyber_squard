import 'package:flutter/material.dart';
import 'package:america_ayber_squad/view/components/custom_button/custom_button.dart'; // Custom button import
import '../../../../../utils/app_colors/app_colors.dart'; // Assuming this is where your colors are defined
import '../../../../components/custom_text/custom_text.dart'; // Assuming your custom text widget

class CustomAssignmentCard extends StatelessWidget {
  final String? title;
  final String? subject;
  final String? tagText;
  final Color? tagColor;
  final Color? tagTextColor;
  final bool isCheckIcon; // Check if the icon is a check
  final String? dateLabel;
  final String? dateValue;
  final String? status;
  final Color? statusColor;
  final Color? statusTextColor;
  final bool showSubmitButton;
  final VoidCallback? onViewDetails;
  final VoidCallback? onSubmit;

  const CustomAssignmentCard({
    super.key,
    this.title,
    this.subject,
    this.tagText,
    this.tagColor,
    this.tagTextColor,
    this.isCheckIcon = false,
    this.dateLabel,
    this.dateValue,
    this.status,
    this.statusColor,
    this.statusTextColor,
    this.showSubmitButton = false,
    this.onViewDetails,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tag Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomText(
                      text: title ?? "Assignment Title",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: tagColor ?? Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        CustomText(
                          text: tagText ?? "Due Soon",
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: tagTextColor ?? Colors.blue,
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          isCheckIcon ? Icons.check_circle : Icons.access_time_filled,
                          size: 12,
                          color: tagTextColor ?? Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),

            // Subject Text with Border
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomText(
                text: subject ?? "Subject Name",
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 10),

            // Date and Status Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomText(
                        text: dateLabel ?? "Due: ",
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                      CustomText(
                        text: dateValue ?? "Date Not Provided",
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor ?? Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: CustomText(
                      text: status ?? "Pending",
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: statusTextColor ?? Colors.orange.shade800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // Action Buttons Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onViewDetails,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.black,
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text("View details"),
                    ),
                  ),
                  if (showSubmitButton) ...[
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text("Submit"),
                      ),
                    ),
                  ]
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
