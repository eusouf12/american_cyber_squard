import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../components/custom_button/custom_button.dart' show CustomButton;
import '../../components/custom_loader/custom_loader.dart' show CustomLoader;
import '../../components/custom_text/custom_text.dart';
import '../../components/custom_text_field/custom_text_field.dart';
import 'login_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final LoginController _controller = Get.find<LoginController>();

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _controller.resetPassword();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundClr,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundClr,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.r),
                        decoration: const BoxDecoration(
                          color: AppColors.primary1,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.password_rounded,
                          size: 48.r,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      CustomText(
                        text: "Reset Password",
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryTitleTextClr,
                      ),
                      SizedBox(height: 8.h),
                      CustomText(
                        text: "Enter your new password below",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.titleTextClr,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 48.h),

                CustomText(
                  text: "New Password",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  bottom: 8.h,
                ),
                CustomTextField(
                  textEditingController: _controller.resetPasswordController,
                  hintText: "Enter new password",
                  isPassword: true,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.titleTextClr,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password cannot be empty";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters long";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),

                CustomText(
                  text: "Confirm New Password",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  bottom: 8.h,
                ),
                CustomTextField(
                  textEditingController: _controller.confirmResetPasswordController,
                  hintText: "Confirm new password",
                  isPassword: true,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.titleTextClr,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirm password cannot be empty";
                    }
                    if (value != _controller.resetPasswordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40.h),

                Obx(() => _controller.resetPasswordLoading.value
                    ? const CustomLoader()
                    : CustomButton(
                        onTap: _handleSubmit,
                        title: "Reset Password",
                        borderRadius: 16.r,
                        textColor: AppColors.white,
                      )),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
