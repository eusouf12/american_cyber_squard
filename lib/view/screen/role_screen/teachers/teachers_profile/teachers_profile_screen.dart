import 'package:flutter/material.dart';

import '../../../../components/custom_nav_bar/teacher_nav_bar.dart';

class TeachersProfileScreen extends StatelessWidget {
  const TeachersProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teachers Profile Screen"),
      ),
      body: const Center(
        child: Text("Teachers Profile Screen"),
      ),
      bottomNavigationBar: TeacherNavBar(currentIndex: 4),
    );
  }
}
