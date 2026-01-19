import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../components/custom_nav_bar/navbar.dart';
import '../widget/custom_children_card.dart';
import '../widget/custom_payment_history_card.dart';
import '../widget/custom_welcome_card.dart';

class FeeManagementScreen extends StatelessWidget {
  const FeeManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                CustomPrimaryCard(
                  title: "Fees & Payments",
                  description: "Manage tuition fees and view payment \nhistory",
                  isInbox: true,
                  icon: Icons.wallet,
                  inboxTitle: "Total due \$128 ",
                ),
                SizedBox(height: 50),
                //card show
               CustomText(text: "Invoice History",fontWeight: FontWeight.w600,fontSize: 18.sp,),
                SizedBox(height: 30),
                CustomInvoiceCard(
                  isHeader: true,
                  invoiceName: "Invoice \nDetails",
                  studentName: "Student \nName",
                  amount: "Amount",
                ),
                SizedBox(height: 20),
                CustomInvoiceCard(
                  isHeader: false,
                  invoiceName: "Tuition Fee",
                  studentName: "Justin",
                  amount: "\$120",
                ),
                SizedBox(height: 20),
                CustomInvoiceCard(
                  isHeader: false,
                  invoiceName: "Tuition Fee",
                  studentName: "Rana",
                  amount: "\$170",
                ),
                SizedBox(height: 20),
                CustomInvoiceCard(
                  isHeader: false,
                  invoiceName: "Library Fee",
                  studentName: "Will",
                  amount: "\$200",
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar:Navbar(currentIndex: 2),
      ),
    );
  }
}
