import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../components/custom_text/custom_text.dart'; // আপনার কাস্টম টেক্সট পাথ

class CustomInvoiceCard extends StatelessWidget {
  final String? invoiceName;
  final String? studentName;
  final String? amount;
  final bool isHeader;

  const CustomInvoiceCard({
    super.key,
     this.invoiceName,
     this.studentName,
     this.amount,
     required this.isHeader,

  });

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          // Invoice Details Column
          Expanded(
            flex: 2,
            child: CustomText(
              text: invoiceName ??"",
              fontSize: isHeader ? 14.sp : 12.sp,
              fontWeight: isHeader ? FontWeight.w600 : FontWeight.w500,
              color: isHeader ? const Color(0xFF64748B) : Colors.black,
              textAlign: TextAlign.start,
              maxLines: 5,
            ),
          ),

          // Student Column
          Expanded(
            flex: 2,
            child: CustomText(
              text: studentName ?? "",
              fontSize: isHeader ? 14.sp : 12.sp,
              fontWeight: isHeader ? FontWeight.w600 : FontWeight.w500,
              color: isHeader ? const Color(0xFF64748B) : Colors.black,
              textAlign: TextAlign.start,
              maxLines: 5,
            ),
          ),

          // Amount Column
          Expanded(
            flex: 1,
            child: CustomText(
              text: amount ??"",
              fontSize: isHeader ? 14.sp : 12.sp,
              fontWeight: isHeader ? FontWeight.w600 : FontWeight.w600,
              color: isHeader ? const Color(0xFF64748B) : const Color(0xFF00A86B),
              textAlign: TextAlign.end,
              maxLines: 2,
            ),
          ),
        ],
      );
  }
}