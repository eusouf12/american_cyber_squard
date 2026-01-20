import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_nav_bar/teacher_nav_bar.dart';
import '../../../../components/custom_text_field/custom_text_field.dart';

class TeachersRecordingClasses extends StatelessWidget {
  const TeachersRecordingClasses({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          titleSpacing: 0,

          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              fillColor: AppColors.white,
              fieldBorderColor: AppColors.greyLight,
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.greyLight,
              ),
              hintText: "Search",
              hintStyle: TextStyle(color: AppColors.greyLight),
            ),
          ),

          toolbarHeight: 120,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                SizedBox(height: 40),


              ],
            ),
          ),
        ),
        bottomNavigationBar: TeacherNavBar(currentIndex: 3),
      ),
    );
  }
}
