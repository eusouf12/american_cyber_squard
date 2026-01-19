import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_nav_bar/student_nav_bar.dart';
import '../../../../../components/custom_text_field/custom_text_field.dart';
import '../../widget/custom_subject_card.dart';

class StudentMyClassesScreen extends StatelessWidget {
  const StudentMyClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomRoyelAppbar(
          titleName: "My Classes",
          leftIcon: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CustomTextField(
                fillColor: AppColors.white,
                fieldBorderColor: AppColors.greyLight,
                prefixIcon: Icon(Icons.search, color: AppColors.greyLight),
                hintText: "Search",
                hintStyle: TextStyle(color: AppColors.greyLight),
              ),
              SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade200,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    CustomText(
                        text: "My Classes",
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    const SizedBox(height: 4),
                    // Description
                    CustomText(
                      text: "Access your course material and details",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      maxLines: 3,
                      textAlign: TextAlign.start,
                    ),

                    const SizedBox(height: 16),

                    // Due Count Section with Icon
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade400,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.assignment,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          CustomText(
                              text: "6 Active Courses",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
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
                        title: "Debbendu Paul Oni",
                        date: "Fri, Mon, Tues . 08:00 AM",
                      );
                    }),
              ),
            ],
          ),
        ),
        bottomNavigationBar: StudentNavBar(currentIndex: 3));
  }
}
