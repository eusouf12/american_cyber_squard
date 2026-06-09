import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../../utils/app_const/app_const.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../components/custom_from_card/custom_from_card.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: 'Edit Profile',
          color: AppColors.black,
        ),
        body: Stack(
          children: [
            // ── Background decorative blobs ──────────────────────────
            Positioned(
              top: -40,
              right: -40,
              child: _GlowCircle(size: 180, color: AppColors.primary.withValues(alpha: 0.14)),
            ),
            Positioned(
              top: 160,
              left: -50,
              child: _GlowCircle(size: 130, color: AppColors.primary2.withValues(alpha: 0.09)),
            ),
            Positioned(
              bottom: 100,
              right: -20,
              child: _GlowCircle(size: 90, color: AppColors.primary.withValues(alpha: 0.07)),
            ),

            // ── Main content ─────────────────────────────────────────
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),

                  // ── Avatar section ────────────────────────────────
                  _buildAvatarSection(),

                  SizedBox(height: 28.h),

                  // ── Form fields ───────────────────────────────────
                  const _FieldLabel(label: 'Full Name'),
                  SizedBox(height: 8.h),
                  _InputField(
                    hintText: 'Debbendu Paul',
                    icon: Icons.person_outline_rounded,
                    controller: TextEditingController(),
                  ),

                  SizedBox(height: 18.h),

                  const _FieldLabel(label: 'Email Address'),
                  SizedBox(height: 8.h),
                  _InputField(
                    hintText: 'Enter your email',
                    icon: Icons.email_outlined,
                    controller: TextEditingController(),
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: 18.h),

                  const _FieldLabel(label: 'Date of Birth'),
                  SizedBox(height: 8.h),
                  _InputField(
                    hintText: '28-11-1997',
                    icon: Icons.cake_outlined,
                    controller: TextEditingController(),
                  ),

                  SizedBox(height: 18.h),

                  const _FieldLabel(label: 'Country'),
                  SizedBox(height: 8.h),
                  _InputField(
                    hintText: 'United States',
                    icon: Icons.flag_outlined,
                    controller: TextEditingController(),
                  ),

                  SizedBox(height: 18.h),

                  const _FieldLabel(label: 'Phone Number'),
                  SizedBox(height: 8.h),
                  _InputField(
                    hintText: '+1 234 567 890',
                    icon: Icons.phone_outlined,
                    controller: TextEditingController(),
                    keyboardType: TextInputType.phone,
                  ),

                  SizedBox(height: 36.h),

                  // ── Save button ───────────────────────────────────
                  _buildSaveButton(),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Avatar with edit overlay ──────────────────────────────────────────
  Widget _buildAvatarSection() {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Glow ring
          Container(
            height: 110.h,
            width: 110.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF088F55), Color(0xFF10B981)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.30),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.all(3),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(3),
              child: CustomNetworkImage(
                imageUrl: AppConstants.profileImage,
                height: 100.h,
                width: 100.w,
                boxShape: BoxShape.circle,
              ),
            ),
          ),

          // Edit badge
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              height: 32.h,
              width: 32.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF088F55), Color(0xFF10B981)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(Icons.camera_alt_rounded, size: 14.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ── Save button ───────────────────────────────────────────────────────
  Widget _buildSaveButton() {
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
        onTap: () => Get.back(),
        title: 'Save Changes',
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

// ── Input field with icon ──────────────────────────────────────────────
class _InputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const _InputField({
    required this.hintText,
    required this.icon,
    required this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFormCard(
      title: '',
      hintText: hintText,
      fillBorderRadius: 14,
      controller: controller,
      keyboardType: keyboardType,
      fieldBorderColor: const Color(0xFFD1FAE5),
      prefixIcon: Padding(
        padding: EdgeInsets.all(12.w),
        child: Icon(icon, color: AppColors.primary, size: 20.sp),
      ),
    );
  }
}

// ── Field label with green accent bar ─────────────────────────────────
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
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}