import 'package:flutter/material.dart';

class ParentsHomeScreen extends StatelessWidget {
  const ParentsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ParentsHomeScreen Home Screen"),
      ),
      body: const Center(
        child: Text("ParentsHomeScreen Home Screen"),
      ),
    );
  }
}
