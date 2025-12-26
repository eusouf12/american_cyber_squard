import 'package:flutter/material.dart';

class TeachersHomeScreen extends StatelessWidget {
  const TeachersHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TeachersHomeScreen Home Screen"),
      ),
      body: const Center(
        child: Text("TeachersHomeScreen Home Screen"),
      ),
    );
  }
}
