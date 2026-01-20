import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_nav_bar/teacher_nav_bar.dart';
import 'package:america_ayber_squad/view/screen/role_screen/teachers/teachers_attendance/widgets/custom_teachers_attendance_card.dart';
import 'package:flutter/material.dart';

class TeachersAttendanceScreen extends StatelessWidget {
  const TeachersAttendanceScreen({super.key});

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTeachersAttendanceCard(
                      count: "Present",
                      icon: Icons.people,
                    ),
                    SizedBox(width: 12),
                    //Children
                    CustomTeachersAttendanceCard(
                      count: "Absent",
                      icon: Icons.people,
                    ),
                    SizedBox(width: 12),
                    //Ave Attendance
                    CustomTeachersAttendanceCard(
                      count: "Late",
                      icon: Icons.alarm,
                    ),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
        bottomNavigationBar: TeacherNavBar(currentIndex: 1),
      ),
    );
  }
}
