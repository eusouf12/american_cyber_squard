import 'package:flutter/material.dart';

import '../../../../components/custom_nav_bar/teacher_nav_bar.dart';

class TeachersAssignmentScreen extends StatelessWidget {
  const TeachersAssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teachers Assignment Screen"),
      ),
      body: const Center(
        child: Text("Teachers Assignment Screen"),
      ),
      bottomNavigationBar: TeacherNavBar(currentIndex: 2),
    );
  }
}
