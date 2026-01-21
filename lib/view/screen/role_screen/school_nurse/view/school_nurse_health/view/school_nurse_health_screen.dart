import 'package:flutter/material.dart';
import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/screen/role_screen/school_nurse/view/school_nurse_health/widget/custom_health_card.dart';
import '../../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../components/custom_nav_bar/school_nurse_nav_bar.dart';
import '../../../../../../components/custom_text/custom_text.dart';
import '../../../../parents/widget/custom_parents_show_card.dart';

class SchoolNurseHealthScreen extends StatelessWidget {
  const SchoolNurseHealthScreen({super.key});

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
                // Cards at the top
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomParentsShowCard(
                        count: "Total Students",
                        label: "3",
                        icon: Icons.person,
                      ),
                      SizedBox(width: 12),
                      CustomParentsShowCard(
                        count: "Critical Cases",
                        label: "2",
                        icon: Icons.error,
                      ),
                      SizedBox(width: 12),
                      CustomParentsShowCard(
                        count: "Condition",
                        label: "95",
                        icon: Icons.favorite,
                      ),
                      SizedBox(width: 12),
                      CustomParentsShowCard(
                        count: "Allergies",
                        label: "95",
                        icon: Icons.show_chart,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Health Record Section
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
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                                text: "Health Record",
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
                                      text: "Add New",
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
                        SizedBox(height: 10),
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return CustomHealthRecord(
                              name: "Alex Thompson",
                              grade: "5-A",
                              bloodType: "O+",
                              condition: "Asthma",
                              allergies: ["Peanuts", "Dust"],
                              status: "Critical",
                              currentMedications: "Inhaler",
                              onTap: () {},
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SchoolNurseNavBar(currentIndex: 1),
      ),
    );
  }
}
