import 'package:flutter/material.dart';

import '../../../../components/custom_nav_bar/teacher_nav_bar.dart';

class TeachersAttendanceScreen extends StatelessWidget {
  const TeachersAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teachers Attendance Screen"),
      ),
      body: const Center(
        child: Text("Teachers Attendance Screen"),
      ),
      bottomNavigationBar: TeacherNavBar(currentIndex: 1),
    );
  }
}
