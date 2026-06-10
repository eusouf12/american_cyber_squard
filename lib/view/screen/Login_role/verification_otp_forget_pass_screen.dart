import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../components/custom_button/custom_button.dart';
import '../../components/custom_loader/custom_loader.dart';
import '../../components/custom_text/custom_text.dart';
import '../../components/custom_text_field/custom_text_field.dart';
import 'login_controller.dart';

class VerificationOtpForgetPassScreen extends StatefulWidget {
  const VerificationOtpForgetPassScreen({super.key});

  @override
  State<VerificationOtpForgetPassScreen> createState() => _VerificationOtpForgetPassScreenState();
}

class _VerificationOtpForgetPassScreenState extends State<VerificationOtpForgetPassScreen> {
  final _formKey = GlobalKey<FormState>();
  final LoginController _controller = Get.find<LoginController>();

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _controller.verifyOtpForgetPass();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundClr,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                
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
                          Icons.mark_email_read_outlined,
                          size: 48.r,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      CustomText(
                        text: "Verify OTP",
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryTitleTextClr,
                      ),
                      SizedBox(height: 8.h),
                      CustomText(
                        text: "Enter the OTP sent to your email",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.titleTextClr,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 48.h),

                CustomText(
                  text: "OTP Code",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  bottom: 8.h,
                ),
                CustomTextField(
                  textEditingController: _controller.otpForgetPassController,
                  hintText: "Enter OTP code",
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(
                    Icons.security_outlined,
                    color: AppColors.titleTextClr,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "OTP cannot be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40.h),

                Obx(() => _controller.verifyOtpLoading.value
                    ? const CustomLoader()
                    : CustomButton(
                        onTap: _handleSubmit,
                        title: "Verify",
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
