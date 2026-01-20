import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:america_ayber_squad/utils/app_const/app_const.dart';
import 'package:america_ayber_squad/view/components/custom_nav_bar/school_nurse_nav_bar.dart';
import 'package:america_ayber_squad/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../parents/widget/custom_parents_show_card.dart';
import '../widget/clinic_visit_card.dart';
import '../widget/custom_medication_card.dart';

class SchoolNurseHomeScreen extends StatelessWidget {
  SchoolNurseHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              //Card Section
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CustomParentsShowCard(
                      count: "Total Visits",
                      label: "3",
                      icon: Icons.people,
                    ),
                    SizedBox(width: 12),
                    // Children
                    CustomParentsShowCard(
                      count: "Active Cases",
                      label: "2",
                      icon: Icons.show_chart,
                    ),
                    SizedBox(width: 12),
                    // Ave Attendance
                    CustomParentsShowCard(
                      count: "Pending Reviews",
                      label: "95",
                      icon: Icons.thermostat,
                    ),
                    SizedBox(width: 12),
                    // Ave Attendance
                    CustomParentsShowCard(
                      count: "Pending Reviews",
                      label: "95",
                      icon: Icons.warning,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Clinic Visits
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
                          CustomText(text: "Clinic Visit", fontSize: 16, fontWeight: FontWeight.w600),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.add, size: 18, color: Colors.white,),
                                CustomText(text: "Add New", fontSize: 12, left: 5, color: Colors.white, fontWeight: FontWeight.w500),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),
                      SizedBox(height: 10,),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return ClinicVisitCard(
                            name: "Emily Davis",
                            grade: "Grade 4-A",
                            time: "11:30 AM",
                            onTap: () {},
                          );
                        }
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              // ListView to display multiple medication cards
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: "Medications to Administer", fontSize: 16, fontWeight: FontWeight.w600),
                      SizedBox(height: 10,),
                      CustomText(text: "Upcoming medications for the next day", fontSize: 12, color: Colors.grey),
                      SizedBox(height: 10,),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return MedicationCard(
                            name: "James Wilson",
                            grade: "Gr 6-B",
                            medication: "Asthma Inhaler • 2 Puffs",
                            time: "12:00 PM",
                            onAdministerTap: () {},
                            onSnoozeTap: () {},
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SchoolNurseNavBar(currentIndex: 0),
      ),
    );
  }
}
