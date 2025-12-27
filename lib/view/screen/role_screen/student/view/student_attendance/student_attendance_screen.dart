import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../components/custom_nav_bar/student_nav_bar.dart';

class StudentAttendanceScreen extends StatelessWidget {
  const StudentAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grades'),
      ),
      body: Center(child: CustomText(text: "This is Attendance Screen")
      ),
        bottomNavigationBar: StudentNavBar(currentIndex: 1)
    );
  }
}
