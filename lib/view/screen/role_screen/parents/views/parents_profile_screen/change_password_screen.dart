import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_from_card/custom_from_card.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';

class ChangePassScreen extends StatelessWidget {
  const ChangePassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: 'Change Password'.tr,
          color: AppColors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            children: [
              CustomFormCard(
                title: 'Current Password',
                hintText: '******',
                isPassword: true,
                fillBorderRadius: 12,
                controller: TextEditingController(),
              ),
              CustomFormCard(
                title: 'New Password',
                hintText: '******',
                isPassword: true,
                fillBorderRadius: 12,
                controller: TextEditingController(),
              ),
              CustomFormCard(
                title: 'Confirm Password',
                hintText: '******',
                isPassword: true,
                fillBorderRadius: 12,
                controller: TextEditingController(),
              ),
              SizedBox(height: 80,),
              CustomButton(
                onTap: () {},
                title: 'Update Password',
                fillColor: AppColors.primary,
                textColor: AppColors.white,
                fontSize: 16,
                borderRadius: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}