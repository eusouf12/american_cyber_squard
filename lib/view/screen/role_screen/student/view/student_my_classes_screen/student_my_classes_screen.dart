import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_nav_bar/student_nav_bar.dart';
import '../../../../../components/custom_text_field/custom_text_field.dart';
import '../../../parents/widget/custom_welcome_card.dart';
import '../../widget/custom_subject_card.dart';

class StudentMyClassesScreen extends StatelessWidget {
  const StudentMyClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CustomPrimaryCard(
                title: "My Classes",
                description: "Access your course material and details",
                isInbox: true,
                icon: Icons.assignment,
                inboxTitle: "6 Active Course",
              ),

              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.only(top: 20.h),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return CustomSubjectCard(
                        title: "Advanced Mathematics",
                        subTitle: "MAT-101",
                        teachersName: "Dr. Sarah Johnson",
                        date: "Mon, Wed, Fri • 09:00 AM",
                        progress: 0.75,
                        room: "Room 101",
                      );
                    }),
              ),
            ],
          ),
        ),
        bottomNavigationBar: StudentNavBar(currentIndex: 4));
  }
}
