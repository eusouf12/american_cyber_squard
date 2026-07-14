import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/student_profile_controller.dart';
import '../model/student_fees_model.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';

class StudentFeesScreen extends StatelessWidget {
  const StudentFeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentProfileController controller =
        Get.find<StudentProfileController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F6),
      appBar: const CustomRoyelAppbar(
        titleName: "Fees & Payments",
        leftIcon: true,
      ),
      body: Obx(() {
        if (controller.isFeesLoading.value) {
          return const Center(
              child: CircularProgressIndicator(color: Color(0xFF00BFA5)));
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gorgeous Header Stack
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Premium Gradient Background
                  Container(
                    width: double.infinity,
                    height: 220,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF059669),
                          Color(0xFF10B981),
                          Color(0xFF34D399)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Decorative glowing circles
                        Positioned(
                          top: -30,
                          right: -20,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.05),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -50,
                          right: 80,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.03),
                            ),
                          ),
                        ),

                        // Text Content
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, top: 40, right: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Fees & Payments",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Manage your tuition fees and\ntransaction history seamlessly.",
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Floating Total Due Card
                  Positioned(
                    bottom: -35,
                    left: 24,
                    right: 24,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color:
                                const Color(0xFF10B981).withValues(alpha: 0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Total Due Amount",
                                style: TextStyle(
                                  color: Color(0xFF64748B),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Text(
                                    "\$",
                                    style: TextStyle(
                                      color: Color(0xFF0F2027),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    controller.totalDue.value
                                        .toStringAsFixed(2),
                                    style: const TextStyle(
                                      color: Color(0xFF0F2027),
                                      fontSize: 28,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Pay Now Action
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF416C), Color(0xFFFF4B2B)],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFF416C)
                                      .withValues(alpha: 0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: const Icon(
                              Icons.payment_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 65),

              // Invoice History List
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text(
                        "Invoice History",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ),
                    if (controller.studentFeesList.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(32),
                        child: Center(
                          child: Text("No fees record found",
                              style: TextStyle(color: Colors.grey)),
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.studentFeesList.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final fee = controller.studentFeesList[index];
                          return _buildInvoiceRow(fee);
                        },
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInvoiceRow(StudentFeesModel fee) {
    bool isPaid =
        fee.paymentStatus.toUpperCase() == 'PAID' || fee.unpaidAmount <= 0;
    bool isPartial = fee.paymentStatus.toUpperCase() == 'PARTIAL';

    Color statusColor;
    Color statusBgColor;
    String statusText;

    if (isPaid) {
      statusColor = const Color(0xFF00C853);
      statusBgColor = const Color(0xFFE8F5E9);
      statusText = "Paid";
    } else if (isPartial) {
      statusColor = const Color(0xFFFF9800);
      statusBgColor = const Color(0xFFFFF3E0);
      statusText = "Partial";
    } else {
      statusColor = const Color(0xFFF44336);
      statusBgColor = const Color(0xFFFFEBEE);
      statusText = "Pending";
    }

    String formattedDate = "N/A";
    if (fee.createdAt.isNotEmpty) {
      try {
        final date = DateTime.parse(fee.createdAt);
        formattedDate = DateFormat('MMM dd, yyyy').format(date);
      } catch (e) {
        // ignore
      }
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left side: Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Tuition Fee (${fee.feesManagement.classLevel})",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                          fontSize: 16),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusBgColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        statusText,
                        style: TextStyle(
                            color: statusColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "Amount: \$${fee.feesManagement.totalFees}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF00BFA5),
                      fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  "Due Date: $formattedDate",
                  style:
                      const TextStyle(color: Color(0xFF64748B), fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  "Method: ${fee.paymentMethod}",
                  style:
                      const TextStyle(color: Color(0xFF64748B), fontSize: 13),
                ),
              ],
            ),
          ),

          // Right side: Action Button
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color:
                    isPaid ? const Color(0xFFF1F5F9) : const Color(0xFF00BFA5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isPaid ? "Receipt" : "Pay Now",
                style: TextStyle(
                  color: isPaid ? const Color(0xFF64748B) : Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
