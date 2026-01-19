import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../components/custom_nav_bar/navbar.dart';
import '../widget/custom_payment_history_card.dart';
import '../widget/custom_welcome_card.dart';

class AcademicProgressScreen extends StatelessWidget {
  const AcademicProgressScreen({super.key});

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
                  title: "Academic Progress",
                  description: "Deep dive into grades and attendance \nrecords",
                  isInbox: false,
                ),
                SizedBox(height: 50),

                //Current Grades
                CustomText(text: "Current Grades",fontWeight: FontWeight.w600,fontSize: 18.sp,),
                SizedBox(height: 30),

              ],
            ),
          ),
        ),
        bottomNavigationBar:Navbar(currentIndex: 3),
      ),
    );
  }
}
