import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../components/custom_nav_bar/school_nurse_nav_bar.dart';
import '../../../../../../components/custom_tab_selected/custom_fill_tab_bar.dart';
import '../../../../../../components/custom_text/custom_text.dart';
import '../controller/immunization_controller.dart';
import '../widget/custom_compliance_rate_card.dart';
import '../widget/custom_health_checking_card.dart';
import 'package:get/get.dart';

import '../widget/custom_schedule_scrining_card.dart';

class SchoolNurseImmunizationScreen extends StatelessWidget {
  SchoolNurseImmunizationScreen({super.key});

  final ImmunizationController immunizationController = Get.put(ImmunizationController());

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                SizedBox(height: 40,),
                ComplianceRateCard(
                  title: "Compliance Rate ",
                  complianceRate: 20,
                  icon: Icons.error,
                ),
                SizedBox(height: 10.h),
                ComplianceRateCard(
                  title: "Vision Screenings",
                  complianceRate: 90,
                  icon: Icons.remove_red_eye,
                ),
                SizedBox(height: 10.h),
                ComplianceRateCard(
                  title: "BMI Checks",
                  complianceRate: 60,
                  icon: Icons.medical_services,
                ),
                SizedBox(height: 20.h),
                /// Health Card
                Obx(() => CustomFillTabBar(
                  tabs: const ["Vaccinations", "Health Screening"],
                  selectedIndex: immunizationController.selectedIndex.value,
                  onTabSelected: immunizationController.changeTab,
                  selectedTextColor: AppColors.primary,
                  unselectedTextColor: Colors.grey,
                )),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                  child: Obx(() {
                    if (immunizationController.selectedIndex.value == 0) {
                      // TAB 0
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: "Upcoming & Overdue",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                              ),
                              Spacer(),
                              // "Add New" Button
                              GestureDetector(
                                onTap: () {
                                  // Show the modal when the "Add New" button is clicked
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CustomText(
                                                text: "Lorem ipsum dolor sit amet",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.add, size: 18, color: Colors.white),
                                      CustomText(
                                        text: "Add Record",
                                        fontSize: 12,
                                        left: 5,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return CustomHealthCheckingCard(
                                name: "John Doe",
                                grade: "10th Grade",
                                vaccineName: "Covid-19",
                                condition: "Asthma",
                                lastCheckupDate: "Jan 01, 2026",
                                currentMedications: "Albuterol Inhaler",
                                allergies: const ["Peanuts", "Dust"],
                                status: "Upcoming",
                              );
                            },
                          ),
                        ],
                      );
                    }
                    else  {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: "Scheduled Screenings",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                              ),
                              Spacer(),
                              // "Add New" Button
                              GestureDetector(
                                onTap: () {
                                  // Show the modal when the "Add New" button is clicked
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CustomText(
                                                text: "Lorem ipsum dolor sit amet",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.add, size: 18, color: Colors.white),
                                      CustomText(
                                        text: "Add Record",
                                        fontSize: 12,
                                        left: 5,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return CustomScheduleScriningCard(
                                screeningName: "John Doe",
                                grade: "10th Grade",
                                date: "Jan 01, 2026",
                                status: "Upcoming",
                              );
                            },
                          ),
                        ],
                      );
                    }
                  }),
                ),
              ],
            )
          ),
        ),
        bottomNavigationBar: SchoolNurseNavBar(currentIndex: 2),
      ),
    );
  }
}
