import 'package:flutter/material.dart';

class InstitutionHomeScreen extends StatelessWidget {
  const InstitutionHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Institution Home Screen"),
      ),
      body: const Center(
        child: Text("Institution Home Screen"),
      ),
    );
  }
}
