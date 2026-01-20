import 'package:flutter/material.dart';

import '../../../../components/custom_nav_bar/teacher_nav_bar.dart';

class TeachersRecordingClasses extends StatelessWidget {
  const TeachersRecordingClasses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teachers Recording Classes Screen"),
      ),
      body: const Center(
        child: Text("Teachers Recording Classes Screen"),
      ),
      bottomNavigationBar: TeacherNavBar(currentIndex: 3),
    );
  }
}
