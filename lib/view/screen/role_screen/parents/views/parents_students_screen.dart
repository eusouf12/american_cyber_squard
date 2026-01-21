import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../components/custom_nav_bar/navbar.dart';
import '../widget/custom_children_card.dart';
import '../widget/custom_welcome_card.dart';

class ParentsStudentsScreen extends StatelessWidget {
  const ParentsStudentsScreen({super.key});

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
                  title: "My Children",
                  description: "Manage profiles and view details for your linked students",
                  isInbox: true,
                  icon: Icons.group,
                  inboxTitle: "2 Students Linked",
                ),
                SizedBox(height: 12),
                //card show
                SizedBox(height: 30),

                CustomChildrenCard(
                  name: "Alex Thompson",
                  grade: "Grade 11-A",
                  studentId: "ST-2024-001",
                  attendance: "92%",
                  gpa: "3.8",
                  teachers: const [
                    "Mr. Anderson (Math)",
                    "Mrs. Davis (Physics)"
                  ],
                  onViewProfile: () {
                    Get.toNamed(AppRoutes.praentsStudentViewProfile);
                  },
                ),
                CustomChildrenCard(
                  name: "Ann",
                  grade: "Grade 9-A",
                  studentId: "ST-2024-001",
                  attendance: "82%",
                  gpa: "3.0",
                  teachers: const [
                    "Mr. Anderson (Math)",
                    "Mrs. Davis (Physics)"
                  ],
                  onViewProfile: () {
                    Get.toNamed(AppRoutes.praentsStudentViewProfile);
                  },
                ),


              ],
            ),
          ),
        ),
        bottomNavigationBar:Navbar(currentIndex: 1),
      ),
    );
  }


}
