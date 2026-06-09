import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: 'Change Password'.tr,
          color: AppColors.black,
        ),
        body: Stack(
          children: [
            // ── Background decorative blobs ──────────────────────────
            Positioned(
              top: -60,
              right: -40,
              child: _GlowCircle(
                size: 200,
                color: AppColors.primary.withValues(alpha: 0.15),
              ),
            ),
            Positioned(
              top: 140,
              left: -50,
              child: _GlowCircle(
                size: 140,
                color: AppColors.primary2.withValues(alpha: 0.10),
              ),
            ),
            Positioned(
              bottom: 120,
              right: -30,
              child: _GlowCircle(
                size: 100,
                color: AppColors.primary.withValues(alpha: 0.07),
              ),
            ),

            // ── Main scrollable content ───────────────────────────────
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),

                  // ── Lock icon hero ──────────────────────────────────
                  _buildIconHero(),

                  SizedBox(height: 32.h),

                  // ── Form fields ─────────────────────────────────────
                  const _FieldLabel(label: 'Current Password'),
                  SizedBox(height: 8.h),
                  _PasswordField(
                    hintText: 'Enter current password',
                    controller: TextEditingController(),
                  ),

                  SizedBox(height: 20.h),

                  const _FieldLabel(label: 'New Password'),
                  SizedBox(height: 8.h),
                  _PasswordField(
                    hintText: 'Enter new password',
                    controller: TextEditingController(),
                  ),

                  SizedBox(height: 20.h),

                  const _FieldLabel(label: 'Confirm Password'),
                  SizedBox(height: 8.h),
                  _PasswordField(
                    hintText: 'Re-enter new password',
                    controller: TextEditingController(),
                  ),

                  SizedBox(height: 12.h),

                  // ── Password tip ────────────────────────────────────
                  _buildPasswordTip(),

                  SizedBox(height: 36.h),

                  // ── Submit button ───────────────────────────────────
                  _buildSubmitButton(),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Lock icon hero card ───────────────────────────────────────────────
  Widget _buildIconHero() {
    return Center(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 28.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF088F55), Color(0xFF10B981)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.30),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: -20,
              right: -20,
              child: _GlowCircle(
                size: 100,
                color: Colors.white.withValues(alpha: 0.10),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 62.h,
                  width: 62.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.35),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    Icons.lock_reset_rounded,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Reset Your Password',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Create a strong & secure password',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Password strength tip ─────────────────────────────────────────────
  Widget _buildPasswordTip() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: AppColors.primary,
            size: 18.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'Use 8+ characters with letters, numbers & symbols.',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Submit button ─────────────────────────────────────────────────────
  Widget _buildSubmitButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: const LinearGradient(
          colors: [Color(0xFF088F55), Color(0xFF10B981)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.38),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: CustomButton(
        onTap: () {},
        title: 'Update Password',
        fillColor: Colors.transparent,
        textColor: AppColors.white,
        fontSize: 16,
        borderRadius: 16,
        height: 56,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

// ── Custom password field card ─────────────────────────────────────────
class _PasswordField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const _PasswordField({
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFormCard(
      title: '',
      hintText: hintText,
      isPassword: true,
      fillBorderRadius: 14,
      controller: controller,
      fieldBorderColor: const Color(0xFFD1FAE5),
      prefixIcon: Padding(
        padding: EdgeInsets.all(12.w),
        child: Icon(
          Icons.lock_outline_rounded,
          color: AppColors.primary,
          size: 20.sp,
        ),
      ),
    );
  }
}

// ── Field label ───────────────────────────────────────────────────────
class _FieldLabel extends StatelessWidget {
  final String label;

  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 16.h,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0E0E0E),
          ),
        ),
      ],
    );
  }
}

// ── Decorative glow circle ─────────────────────────────────────────────
class _GlowCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowCircle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}