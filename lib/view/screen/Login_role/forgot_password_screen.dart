import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../components/custom_button/custom_button.dart' show CustomButton;
import '../../components/custom_loader/custom_loader.dart';
import '../../components/custom_text/custom_text.dart';
import '../../components/custom_text_field/custom_text_field.dart';
import 'login_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final LoginController loginController = Get.find<LoginController>();

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      loginController.forgotPassword();
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
                          Icons.lock_reset_rounded,
                          size: 48.r,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      CustomText(
                        text: "Forgot Password",
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryTitleTextClr,
                      ),
                      SizedBox(height: 8.h),
                      CustomText(
                        text: "Enter your email address to receive an OTP",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.titleTextClr,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 48.h),

                CustomText(
                  text: "Email Address",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  bottom: 8.h,
                ),
                CustomTextField(
                  textEditingController: loginController.forgotPasswordEmailController,
                  hintText: "Enter your email",
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: AppColors.titleTextClr,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email cannot be empty";
                    }
                    if (!GetUtils.isEmail(value)) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40.h),

                Obx(() => loginController.forgotPasswordLoading.value
                    ? const CustomLoader()
                    : CustomButton(
                        onTap: _handleSubmit,
                        title: "Send OTP",
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
