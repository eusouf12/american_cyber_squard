import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:flutter/material.dart';

import '../../../../../components/custom_nav_bar/school_nurse_nav_bar.dart';
import '../../../parents/widget/custom_parents_show_card.dart';

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
                //card show
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
                      //Children
                      CustomParentsShowCard(
                        count: "Critical Cases",
                        label: "2",
                        icon: Icons.error,
                      ),
                      SizedBox(width: 12),
                      //Ave Attendance
                      CustomParentsShowCard(
                        count: "Condition",
                        label: "95",
                        icon: Icons.favorite,
                      ),
                      SizedBox(width: 12),
                      //Ave Attendance
                      CustomParentsShowCard(
                        count: "Allergies",
                        label: "95",
                        icon: Icons.show_chart,
                      ),
                    ],
                  ),
                ),


              ],
            ),
          ),
        ),
        bottomNavigationBar: SchoolNurseNavBar(currentIndex: 1),
      ),
    );
  }
}
