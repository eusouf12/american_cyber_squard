import 'package:america_ayber_squad/view/components/custom_button/custom_button.dart';
import 'package:america_ayber_squad/view/components/custom_dropdown/custom_royel_dropdown.dart';
import 'package:america_ayber_squad/view/components/custom_from_card/custom_from_card.dart';
import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../components/custom_nav_bar/school_nurse_nav_bar.dart';

class SchoolNurseCommunicationScreen extends StatelessWidget {
  const SchoolNurseCommunicationScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(
          titleName: "Quick Communication", leftSpace: 50,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      CustomText(
                        text: "One-Click Notify",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 10.h),

                      // Content Text
                      CustomText(
                        text: "Welcome to the School Nurse Communication Screen. Here, you can quickly reach out to students, parents, and staff regarding health-related matters. Whether it's sending reminders for medication, scheduling health check-ups, or sharing important health tips, this platform is designed to facilitate effective communication within the school community.",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        maxLines: 10,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 10.h),
                      CustomFormCard(
                          title: "Selected Student",
                          hintText: "Search student name",
                          controller: TextEditingController(),
                        fillBorderRadius: 10,
                        fieldBorderColor: Colors.grey.withOpacity(0.2),
                      ),
                      CustomRoyelDropdown(
                        title: "Visit Reason",
                        hintText: "Select Communication Type",
                        borderRadius: 10,
                        isBorder: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                      ),
                      SizedBox(height: 20.h),
                      CustomRoyelDropdown(
                        title: "Action Taken",
                        hintText: "Select Communication Type",
                        borderRadius: 10,
                        isBorder: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                      ),
                      SizedBox(height: 20.h),
                      CustomButton(
                          onTap: (){},
                          title: "Send Notification",
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      CustomText(
                        text: "Custom Message",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 10.h),

                      // Content Text
                      CustomText(
                        text: "Welcome to the School Nurse Communication Screen. Here, you can quickly reach out to students, parents, and staff regarding health-related matters.",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        maxLines: 10,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 10.h),
                      CustomFormCard(
                          title: "Recipient",
                          hintText: "Enter paarent/staff name",
                          controller: TextEditingController(),
                        fillBorderRadius: 10,
                        fieldBorderColor: Colors.grey.withOpacity(0.2),
                      ),
                      CustomFormCard(
                          title: "Subjet",
                          hintText: "Regarding",
                          controller: TextEditingController(),
                        fillBorderRadius: 10,
                        fieldBorderColor: Colors.grey.withOpacity(0.2),
                      ),
                      CustomFormCard(
                          title: "Message",
                          hintText: "Type your message here",
                          controller: TextEditingController(),
                        fillBorderRadius: 10,
                        fieldBorderColor: Colors.grey.withOpacity(0.2),
                      ),
                      SizedBox(height: 20.h),

                      CustomButton(
                          onTap: (){},
                          title: "Send Notification",
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SchoolNurseNavBar(currentIndex: 3),
      ),
    );
  }
}
