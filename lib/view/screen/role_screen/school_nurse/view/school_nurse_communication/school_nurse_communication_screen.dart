import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import '../../../../../components/custom_nav_bar/school_nurse_nav_bar.dart';

class SchoolNurseCommunicationScreen extends StatelessWidget {
  const SchoolNurseCommunicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(
          titleName: "Quick Communication", leftSpace: 50,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [

              ],
            ),
          ),
        ),
        bottomNavigationBar: SchoolNurseNavBar(currentIndex: 3),
      ),
    );
  }
}
