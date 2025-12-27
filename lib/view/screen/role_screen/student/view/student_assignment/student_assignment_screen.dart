import 'package:america_ayber_squad/view/components/custom_nav_bar/student_nav_bar.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

class StudentAssignmentScreen extends StatelessWidget {
  const StudentAssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grades'),
      ),
      body: Center(child: CustomText(text: "This is Assignment Screen")),
      bottomNavigationBar: StudentNavBar(currentIndex: 2)
    );
  }
}
