import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_nav_bar/navbar.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
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
                    CustomText(
                      text: "Sarah Johnson",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [

                    //card show
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CustomParentsShowCard(
                            count: "Total Fees Due",
                            label: "\$ 450",
                            icon: Icons.credit_card,
                          ),
                          SizedBox(width: 12),
                          //Children
                          CustomParentsShowCard(
                            count: "Children",
                            label: "2",
                            icon: Icons.people,
                          ),
                          SizedBox(width: 12),
                          //Ave Attendance
                          CustomParentsShowCard(
                            count: "Ave Attendance",
                            label: "95 %",
                            icon: Icons.trending_up,
                          ),
                          SizedBox(width: 12),
                          CustomParentsShowCard(
                            count: "Pending Notices",
                            label: "2",
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
