import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:america_ayber_squad/view/components/custom_tab_selected/custom_tab_bar.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../components/custom_nav_bar/student_nav_bar.dart';
import '../../../../parents/widget/custom_gread_card.dart';
import '../../../../parents/widget/custom_welcome_card.dart';
import '../widgets/custom_result.dart';

class StudentGradeScreen extends StatelessWidget {
  StudentGradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(
          titleName: "Grade & Exams",
          leftIcon: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomPrimaryCard(
                  title: "Academic Progress",
                  description: "Deep dive into grades and attendance \nrecords",
                  isInbox: true,
                  icon: Icons.workspace_premium,
                  inboxTitle: "3.8 / 4.0",
                ),
                SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.09),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(text: "Current Standing", fontWeight: FontWeight.w600,fontSize: 16.sp,),
                          InkWell(
                            onTap: (){},
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade400),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.download, size: 16, color: Colors.grey,),
                                  SizedBox(width: 4,),
                                  CustomText(text: "Report Card", ),
                                ],
                              )
                            ),
                          )
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: CustomSubjectGradeCard(
                              gradeLetter: index == 0 ? "A" : (index == 1 ? "B" : index == 3?"C":"A+"),
                              subjectName: index == 0 ? "Chemistry" : (index == 1 ? "Physics" : index == 3?"English":"Mathematics"),
                              teacherName: "Mr. Anderson",
                              averageScore: index == 0 ? "79%" : (index == 1 ? "60%" : index == 3?"89%":"94%"),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.09),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: "Current Standing", fontWeight: FontWeight.w600,fontSize: 16.sp,),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: CustomResult(
                              subject: 'Physics - Chapter 4 Quiz ',
                              date: 'Nov 20, 2024',
                              score: '18/20',
                              grade: 'A',
                              status: 'Graded',
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
        bottomNavigationBar: StudentNavBar(currentIndex: 3),
      ),
    );
  }
}
