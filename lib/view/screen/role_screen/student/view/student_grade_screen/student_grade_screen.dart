import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../components/custom_nav_bar/student_nav_bar.dart';

class StudentGradeScreen extends StatelessWidget {
  const StudentGradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        titleName: "My Results",
        leftIcon: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 155,
                  width: double.infinity,
                  color: AppColors.primary,
                  child: Column(
                    children: [
                      CustomText(
                          text: "Overall GPA"
                      ),
                      CustomText(
                        text: "3.4",
                      ),
                      CustomText(
                        text: "B+ Average",
                      ),
                    ]
                  ),
                )
              ],
            ),
          ],
        ),
      ),
        bottomNavigationBar: StudentNavBar(currentIndex: 3)
    );
  }
}
