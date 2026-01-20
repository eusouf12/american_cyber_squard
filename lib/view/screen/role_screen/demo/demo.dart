import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/app_routes/app_routes.dart';
import '../../../components/custom_button/custom_button.dart';

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(text: "This is the Demo purpose"),
              SizedBox(height: 20,),
              CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.parentsHomeScreen);
                },
                title: "Parents",
                borderRadius: 30,
                textColor: Colors.white,
              ),
              SizedBox(height: 20,),
              CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.studentHomeScreen);

                },
                title: "Student",
                borderRadius: 30,
              ),
              SizedBox(height: 20,),
              CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.institutionHomeScreen);
                },
                title: "Institution",
                borderRadius: 30,
              ),
              SizedBox(height: 20,),
              CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.teachersHomeScreen);
                },
                title: "Teachers",
                borderRadius: 30,
              ),

            ]
          ),
        ),
      ),
    );
  }
}
