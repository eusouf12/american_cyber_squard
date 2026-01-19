import 'package:flutter/material.dart';

import '../widget/custom_welcome_card.dart';

class ParentsHomeScreen extends StatelessWidget {
  const ParentsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ParentsHomeScreen Home Screen"),
      ),
      body: Column(
        children: [
          CustomPrimaryCard(
            title: "Assignments",
            description: "Track your homework and project deadlines",
            statusText: "2 Due Today",
            icon: Icons.assignment,
          ),
        ],
      ),
    );
  }
}
