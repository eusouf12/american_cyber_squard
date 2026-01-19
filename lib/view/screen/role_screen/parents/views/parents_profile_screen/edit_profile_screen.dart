import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../utils/app_const/app_const.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_from_card/custom_from_card.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      color1: Color(0xFF0C7A43),

      child: Scaffold(
        appBar: CustomRoyelAppbar(leftIcon: true, titleName: 'Edit Profile', color: AppColors.white,),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Stack(
                  children: [
                    Center(
                      child: Container(
                        height: 120.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: CustomNetworkImage(
                            imageUrl: AppConstants.profileImage,
                            height: 70.h,
                            width: 70.w,
                            boxShape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 110.w,
                      bottom: 10.w,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.edit, size: 15, color: AppColors.white,),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                // Form Fields
                CustomFormCard(
                  title: 'Name',
                  hintText: 'Debbendu Paul',
                  titleColor: AppColors.black,
                  controller: TextEditingController(),
                ),
                CustomFormCard(
                  title: 'Email',
                  hintText: 'Enter your email',
                  titleColor: AppColors.black,
                  controller: TextEditingController(),
                ),
                CustomFormCard(
                  title: 'Date Of Birth',
                  hintText: '28-11-1997',
                  titleColor: AppColors.black,
                  controller: TextEditingController(),
                ),
                CustomFormCard(
                  title: 'Country',
                  hintText: 'United State',
                  titleColor: AppColors.black,
                  controller: TextEditingController(),
                ),
                CustomFormCard(
                  title: 'Phone Number',
                  hintText: '+123456789',
                  titleColor: AppColors.black,
                  controller: TextEditingController(),
                ),

                SizedBox(height: 20),
                CustomButton(
                  onTap: (){
                    Get.back();
                  },
                  title: 'Save',
                  textColor: AppColors.white,
                  borderRadius: 50,
                  fillColor: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}