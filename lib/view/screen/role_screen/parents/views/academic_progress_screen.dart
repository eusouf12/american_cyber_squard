import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_tab_selected/custom_tab_bar.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../components/custom_nav_bar/navbar.dart';
import '../controller/academic_controller.dart';
import '../widget/custom_gread_card.dart';
import '../widget/custom_welcome_card.dart';

class AcademicProgressScreen extends StatelessWidget {
   AcademicProgressScreen({super.key});
   final TabControllerX controller = Get.put(TabControllerX());

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
                Obx(() => CustomTabBar(
                  tabs: const ["Will", "Jak"],
                  selectedIndex: controller.selectedIndex.value,
                  onTabSelected: controller.changeTab,
                  selectedColor: const Color(0xFF00A86B),
                  unselectedColor: Colors.grey,
                  textColor: Colors.black,
                  isTextColorActive: true,
                )),
                SizedBox(height: 20),
                Obx(() {
                  if (controller.selectedIndex.value == 0) {
                    /// TAB 0
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: "Current Grades",fontWeight: FontWeight.w600,fontSize: 18.sp,),
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
                    );
                  } else  {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: "Current Grades",fontWeight: FontWeight.w600,fontSize: 18.sp,),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          itemCount: 2,
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
                    );
                  }
                }),

                //Current Grades


              ],
            ),
          ),
        ),
        bottomNavigationBar:Navbar(currentIndex: 3),
      ),
    );
  }
}
