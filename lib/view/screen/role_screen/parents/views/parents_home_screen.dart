import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:flutter/material.dart';
import '../../../../components/custom_nav_bar/navbar.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../widget/custom_parent_show_profile.dart';
import '../widget/custom_parents_show_card.dart';
import '../widget/custom_welcome_card.dart';
import '../widget/recent_activity_card_parent.dart';

class ParentsHomeScreen extends StatelessWidget {
  const ParentsHomeScreen({super.key});

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
                    CustomPrimaryCard(
                      title: "Good Morning,\n Eusouf",
                      description:
                      "Here's a summary of your children's performance and school updates.",
                    ),
                    SizedBox(height: 12),
                    //card show
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CustomParentsShowCard(
                            count: "\$450.00",
                            label: "Total Fees Due",
                            icon: Icons.credit_card,
                          ),
                          SizedBox(width: 12),
                          //Children
                          CustomParentsShowCard(
                            count: "2",
                            label: "Children",
                            icon: Icons.people,
                          ),
                          SizedBox(width: 12),
                          //Ave Attendance
                          CustomParentsShowCard(
                            count: "95 %",
                            label: "Ave Attendance",
                            icon: Icons.trending_up,
                          ),
                          SizedBox(width: 12),
                          CustomParentsShowCard(
                            count: "2",
                            label: "Pending Notices",
                            icon: Icons.warning,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    // view student profile card
                    CustomParentShowProfile(
                      name: "Sarah Thompson",
                      grade: "Grade 8-B",
                      attendance: "96%",
                      nextExam: "Math (Monday)",
                      onViewProfile: () {
                        print("Profile Clicked!");
                      },
                    ),
                    SizedBox(height: 30),
                    //Recent Activity
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Recent Activity",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              GestureDetector(
                                onTap: (){
                                  // Navigate or other action
                                },
                                child: CustomText(
                                  text: "View All",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF00A86B),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Activity Items
                          ActivityItem(
                            title: "Report Card Released",
                            subtitle: "Alex Thompson",
                            time: "Today, 10:00 AM",
                          ),
                          const SizedBox(height: 10),
                          ActivityItem(
                            title: "Fee Invoice Generated",
                            subtitle: "Sarah Thompson",
                            time: "Yesterday, 2:00 PM",
                          ),
                          const SizedBox(height: 10),
                          ActivityItem(
                            title: "Absent Notification",
                            subtitle: "Alex Thompson",
                            time: "Dec 12, 2024",
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          bottomNavigationBar:Navbar(currentIndex: 0),
        ),
    );
  }
}
