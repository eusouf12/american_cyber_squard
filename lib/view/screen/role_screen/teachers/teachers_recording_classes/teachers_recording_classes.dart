import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/screen/role_screen/teachers/teachers_recording_classes/widget/custom_teacher_record_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_nav_bar/teacher_nav_bar.dart';
import '../../../../components/custom_text/custom_text.dart';
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
                color: Colors.grey,
              ),
              hintText: "Search Your Recorded class",
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),

          toolbarHeight: 60,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 6,vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, color: AppColors.white,size: 20,),
                                SizedBox(width: 5),
                                CustomText(text: "Upload Recording", fontSize: 14.sp, fontWeight: FontWeight.w500,color: AppColors.white,),
                              ],
                            )
                        )
                    ),
                    SizedBox(height: 20.h),
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return CustomTeacherRecordCard(
                            subject:  (index ==0 || index== 2) ? "Quadratic Equations" : "NewTown's Laws Lab",
                            grade: "Grade 10-A",
                            time: index==0 ? "41 min": "90 min",
                            date: "Dec 15, 2024",
                            status:  ( index ==0 || index== 2 || index == 4) ?"Available" : "recording Railed",
                            onTapView: () {

                            },
                          );
                        }
                    ),
                  ],
                ),
              ),
            )
          ),
        ),
        bottomNavigationBar: TeacherNavBar(currentIndex: 4),
      ),
    );
  }
}
