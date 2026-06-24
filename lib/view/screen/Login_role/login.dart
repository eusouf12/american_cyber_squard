// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/app_routes/app_routes.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../components/custom_button/custom_button.dart';
import '../../components/custom_loader/custom_loader.dart';
import '../../components/custom_text/custom_text.dart';
import '../../components/custom_text_field/custom_text_field.dart';
import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final LoginController _controller = Get.find<LoginController>();
  final List<String> _roles = ['TEACHER', 'STUDENT', 'NURSE', 'parent'];

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      _controller.loginUser();
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
                SizedBox(height: 40.h),
                
                // Welcome Section
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
                          Icons.lock_person_rounded,
                          size: 48.r,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      CustomText(
                        text: "Welcome Back",
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryTitleTextClr,
                      ),
                      SizedBox(height: 8.h),
                      CustomText(
                        text: "Login to access your dashboard",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.titleTextClr,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 48.h),

                // Email Field
                CustomText(
                  text: "Email Address",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  bottom: 8.h,
                ),
                CustomTextField(
                  textEditingController: _controller.emailController,
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
                SizedBox(height: 20.h),

                // Role Dropdown Field
                CustomText(
                  text: "Select Role",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  bottom: 8.h,
                ),
                Obx(() => DropdownButtonFormField<String>(
                  value: _controller.selectedRole.value.isEmpty ? null : _controller.selectedRole.value,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.titleTextClr,
                  ),
                  decoration: InputDecoration(
                    hintText: "Select your role",
                    hintStyle: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.titleTextClr,
                    ),
                    fillColor: AppColors.white,
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.person_outline_rounded,
                      color: AppColors.titleTextClr,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(color: AppColors.red, width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(color: AppColors.red, width: 1.5),
                    ),
                  ),
                  style: GoogleFonts.poppins(
                    color: AppColors.black_03,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  dropdownColor: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  items: _roles.map((role) {
                    // Display role in uppercase on screen
                    final displayText = role == 'parent' ? 'PARENT' : role;
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(
                        displayText,
                        style: GoogleFonts.poppins(
                          color: AppColors.black_03,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _controller.setRole(value!);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a role";
                    }
                    return null;
                  },
                )),
                SizedBox(height: 20.h),

                // Password Field
                CustomText(
                  text: "Password",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  bottom: 8.h,
                ),
                CustomTextField(
                  textEditingController: _controller.passwordController,
                  hintText: "Enter your password",
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  prefixIcon: const Icon(
                    Icons.lock_outlined,
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
                SizedBox(height: 12.h),

                // Forgot Password Button
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.forgotPasswordScreen);
                    },
                    child: CustomText(
                      text: "Forgot Password?",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),

                // Login Button
                Obx(() => _controller.loginLoading.value
                    ? const CustomLoader()
                    : CustomButton(
                        onTap: _handleLogin,
                        title: "Log In",
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
