import 'package:america_ayber_squad/utils/app_const/app_const.dart';
import 'package:america_ayber_squad/view/components/custom_nav_bar/teacher_nav_bar.dart';
import 'package:america_ayber_squad/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:america_ayber_squad/view/screen/role_screen/teachers/teachers_home/widget/custom_homework_card.dart';
import 'package:america_ayber_squad/view/screen/role_screen/teachers/teachers_home/widget/custom_quick_card.dart';
import 'package:america_ayber_squad/view/screen/role_screen/teachers/teachers_home/widget/custom_today_schedule_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../school_nurse/view/school_nurse_home/widget/clinic_visit_card.dart';

class TeachersHomeScreen extends StatelessWidget {
  TeachersHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> gridItems = [
      {'title': 'Mark Attendance', 'icon': Icons.assignment_turned_in_outlined},
      {'title': 'New Assignment', 'icon': Icons.add},
      {'title': 'Grade Papers', 'icon': Icons.description_outlined},
      {'title': 'Schedule Class', 'icon': Icons.calendar_today_outlined},
    ];

    return CustomGradient(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: CustomNetworkImage(
                          imageUrl: AppConstants.profileImage,
                          height: 45,
                          width: 45,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Sarah Johnson",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Grade 11 - Section A",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_none,
                          size: 28,
                          color: Colors.black,
                        ),
                      ),
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            '2',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 //today schedule
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(text: "Today's Schedule", fontSize: 16.sp, fontWeight: FontWeight.w600),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.primary1,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 18, color: AppColors.primary,),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return CustomTodayScheduleCard(
                                name: index == 0 ?"Physics" : "Mathematics",
                                subject: "Grade 4-A",
                                time: "11:00 - 12:00",
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                //quick actions
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: "Quick Actions", fontSize: 16.sp, fontWeight: FontWeight.w600),
                        SizedBox(height: 20),
                        GridView.builder(
                          shrinkWrap: true, 
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 1.2,
                          ),
                          itemCount: gridItems.length,
                          itemBuilder: (context, index) {
                            return CustomQuickCard(
                              title: gridItems[index]['title'],
                              icon: gridItems[index]['icon'],
                              onTap: () {
                                print("${gridItems[index]['title']} clicked");
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),

                // assignment and homework
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(text: "Assignment & HomeWork", fontSize: 15.sp, fontWeight: FontWeight.w600),
                            Spacer(),
                            GestureDetector(
                                onTap: (){

                                },
                                child: CustomText(text: "View All", fontSize: 12.sp, fontWeight: FontWeight.w600,color: AppColors.primary,)
                            ),

                          ],
                        ),
                        SizedBox(height: 20),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return CustomHomeworkCard(
                                subject: index==0 ? "Quadratic Equations" : "NewTown's Laws Lab",
                                chapter: index==0 ? "Chapter 5": "Report",
                                grade: "Grade 10-A • Mathematics",
                                time: "Dec 15, 2024",
                                onTap: () {

                                },
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
          bottomNavigationBar: TeacherNavBar(currentIndex: 0)
      ),
    );
  }


}