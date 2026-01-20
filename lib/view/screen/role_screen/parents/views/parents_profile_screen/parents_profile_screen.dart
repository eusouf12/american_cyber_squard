import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_nav_bar/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../../utils/app_const/app_const.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_show_dialog/custom_show_dialog.dart';
import '../../../../../components/custom_text/custom_text.dart';

class ParentsProfileScreen extends StatelessWidget {
  const ParentsProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          child: Padding(
            padding: const EdgeInsets.only(left: 24,right: 24, top: 30),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomNetworkImage(
                          imageUrl: AppConstants.girlsPhoto,
                          boxShape: BoxShape.circle,
                          height: 80.h,
                          width: 80.w,
                        ),
                        SizedBox(width: 15),
                        Column(
                          children: [
                            CustomText(
                              text: 'Dabatosh Paul',
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.black,
                            ),
                            CustomText(
                              text: '(Parents Profile)',
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    CustomFieldCard(
                      titleKey: 'Chat',
                      onTap: () => Get.toNamed(AppRoutes.chatListScreen),
                    ),
                    SizedBox(height: 15),
                    CustomFieldCard(
                      titleKey: 'Edit Profile',
                      onTap: () => Get.toNamed(AppRoutes.editScreen),
                    ),
                    SizedBox(height: 15),
                    CustomFieldCard(
                      titleKey: 'Change Password',
                      onTap: () => Get.toNamed(AppRoutes.changePassScreen),
                    ),

                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            backgroundColor: AppColors.white,
                            insetPadding: EdgeInsets.all(8),
                            contentPadding: EdgeInsets.all(8),
                            content: SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              child: CustomShowDialog(
                                textColor: AppColors.black,
                                title: 'Are You Sure',
                                discription: 'Logout Your Account',
                                showColumnButton: true,
                                showCloseButton: true,
                                rightOnTap: () => Get.back(),
                                leftOnTap: () => Get.offAllNamed(AppRoutes.demo),
                              ),
                            ),
                          ),
                        );
                      },
                      child: CustomFieldCard(
                        titleKey: 'Logout',
                        color: AppColors.red,
                        showArrow: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Navbar(currentIndex: 4),
      ),
    );
  }

  Widget CustomFieldCard({
    required String titleKey,
    VoidCallback? onTap,
    Color? color,
    bool showArrow = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primary.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CustomText(
                text: titleKey.tr,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: color ?? AppColors.black,
              ),
              Spacer(),
              if (showArrow)
                Container(
                  height: 45,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primary,
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: AppColors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}