import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../components/custom_nav_bar/school_nurse_nav_bar.dart';
import '../widget/custom_compliance_rate_card.dart';

class SchoolNurseImmunizationScreen extends StatelessWidget {
  const SchoolNurseImmunizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ComplianceRateCard(
                          title: "Compliance Rate ${index + 1}",
                          complianceRate: (index + 1) * 20.0,
                          icon: Icons.check_circle,
                        ),
                        SizedBox(height: 10.h),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SchoolNurseNavBar(currentIndex: 2),
      ),
    );
  }
}
