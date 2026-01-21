import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_nav_bar/teacher_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_tab_selected/custom_fill_tab_bar.dart';
import '../../../../../components/custom_tab_selected/custom_tab_bar.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../parents/widget/custom_parents_show_card.dart';
import '../../teachers_home/widget/custom_homework_card.dart';
import '../controller/teacher_create_controller.dart';
import 'package:get/get.dart';

import '../widget/custom_create_assignment_card.dart';


class TeachersAssignmentScreen extends StatelessWidget {
  TeachersAssignmentScreen({super.key});
  final TeacherCreateController teacherCreateController = Get.put(TeacherCreateController());

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                SizedBox(height: 40),
                //card show
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomParentsShowCard(
                        count: "Active Assignments",
                        label: "3",
                        icon: Icons.assignment,
                      ),
                      SizedBox(width: 12),
                      //Children
                      CustomParentsShowCard(
                        count: "Submissions today",
                        label: "2",
                        icon: Icons.people,
                      ),
                      SizedBox(width: 12),
                      //Ave Attendance
                      CustomParentsShowCard(
                        count: "Pending Reviews",
                        label: "95",
                        icon: Icons.error,
                      ),
                    ],
                  ),
                ),

                //create assignment
                Container(
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
                      children: [
                        //Assignment
                        Obx(() => CustomFillTabBar(
                          tabs: const ["All", "Active", "Completed"],
                          selectedIndex: teacherCreateController.selectedIndex.value,
                          onTabSelected: teacherCreateController.changeTab,
                          selectedTextColor: AppColors.primary,
                          unselectedTextColor: Colors.grey,
                        )),
                        SizedBox(height: 20),
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
                                    CustomText(text: "Create Assignment", fontSize: 14.sp, fontWeight: FontWeight.w500,color: AppColors.white,),
                                  ],
                                )
                            )
                        ),
                        SizedBox(height: 20),
                        Obx(() {
                          if (teacherCreateController.selectedIndex.value == 0) {
                            // TAB 0
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return CustomCreateAssignmentCard(
                                        subject: index==0 ? "Quadratic Equations" : "NewTown's Laws Lab",
                                        grade: "Grade 10-A",
                                        submission: index==0 ? "18/24": "20/40",
                                        time: "Dec 15, 2024",
                                        status:  index==0 ?"Active" : "Completed",
                                        homeWork: index==0 ? "Homework" : "Practice",
                                        progressValue: index==0 ? 75 : 40,
                                        onTapEdit: () {

                                        },
                                        onTapView: () {

                                        },
                                      );
                                    }
                                ),
                              ],
                            );
                          }
                          else if (teacherCreateController.selectedIndex.value == 1) {
                            // TAB 1
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 2,
                                    itemBuilder: (context, index) {
                                      return CustomCreateAssignmentCard(
                                        subject: index==0 ? "Quadratic Equations" : "NewTown's Laws Lab",
                                        grade: "Grade 10-A",
                                        submission: index==0 ? "18/24": "20/40",
                                        time: "Dec 15, 2024",
                                        status:  index==0 ?"Active" : "Completed",
                                        homeWork: index==0 ? "Homework" : "Practice",
                                        progressValue: index==0 ? 75 : 40,
                                        onTapEdit: () {

                                        },
                                        onTapView: () {

                                        },
                                      );
                                    }
                                ),
                              ],
                            );
                          }
                          else  {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 1,
                                    itemBuilder: (context, index) {
                                      return CustomCreateAssignmentCard(
                                        subject: index==0 ? "Quadratic Equations" : "NewTown's Laws Lab",
                                        grade: "Grade 10-A",
                                        submission: index==0 ? "18/24": "20/40",
                                        time: "Dec 15, 2024",
                                        status:  index==0 ?"Active" : "Completed",
                                        homeWork: index==0 ? "Homework" : "Practice",
                                        progressValue: index==0 ? 75 : 40,
                                        onTapEdit: () {

                                        },
                                        onTapView: () {

                                        },
                                      );
                                    }
                                ),
                              ],
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: TeacherNavBar(currentIndex: 2),
      ),
    );
  }
}
