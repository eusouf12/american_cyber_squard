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
import '../../../../../components/custom_text/custom_text.dart';
import '../../../../Login_role/login_controller.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();
    
    // Pre-populate data
    void populateData() {
      final profile = loginController.myProfileData.value;
      if (profile != null) {
        if (loginController.editNameController.text.isEmpty) {
          loginController.editNameController.text = profile.teacherName;
        }
        if (loginController.editAddressController.text.isEmpty) {
          loginController.editAddressController.text = profile.address;
        }
        if (loginController.editPhoneController.text.isEmpty) {
          loginController.editPhoneController.text = profile.phoneNumber;
        }
        if (loginController.editEmailController.text.isEmpty) {
          loginController.editEmailController.text = profile.email;
        }
      }
    }

    if (loginController.myProfileData.value == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await loginController.getMyProfile();
        populateData();
      });
    } else {
      populateData();
    }

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
                  _buildProfileImage(loginController),

                  SizedBox(height: 28.h),

                  // ── Form fields ───────────────────────────────────
                  const _FieldLabel(label: 'Full Name'),
                  SizedBox(height: 8.h),
                  _InputField(
                    hintText: 'Enter your full name',
                    icon: Icons.person_outline_rounded,
                    controller: loginController.editNameController,
                  ),

                  SizedBox(height: 18.h),

                  const _FieldLabel(label: 'Email Address'),
                  SizedBox(height: 8.h),
                  _InputField(
                    hintText: 'Enter your email',
                    icon: Icons.email_outlined,
                    controller: loginController.editEmailController,
                    keyboardType: TextInputType.emailAddress,
                    readOnly: true,
                  ),
                  SizedBox(height: 18.h),

                  const _FieldLabel(label: 'Address'),
                  SizedBox(height: 8.h),
                  _InputField(
                    hintText: 'Enter your address',
                    icon: Icons.location_on_outlined,
                    controller: loginController.editAddressController,
                  ),

                  SizedBox(height: 18.h),

                  const _FieldLabel(label: 'Phone Number'),
                  SizedBox(height: 8.h),
                  _InputField(
                    hintText: 'Enter your phone number',
                    icon: Icons.phone_outlined,
                    controller: loginController.editPhoneController,
                    keyboardType: TextInputType.phone,
                  ),

                  SizedBox(height: 36.h),

                  // ── Save button ───────────────────────────────────
                  _buildSaveButton(loginController),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Profile Image ─────────────────────────────────────────────────────
  Widget _buildProfileImage(LoginController loginController) {
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
              child: Obx(() {
                final localImage = loginController.profileImage.value;
                final networkImage = loginController.myProfileData.value?.photo ?? AppConstants.profileImage2;
                
                if (localImage != null) {
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: FileImage(localImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
                
                return CustomNetworkImage(
                  imageUrl: networkImage.isNotEmpty ? networkImage : AppConstants.profileImage,
                  height: 100.h,
                  width: 100.w,
                  boxShape: BoxShape.circle,
                );
              }),
            ),
          ),

          // Edit badge
          Positioned(
            bottom: 2,
            right: 2,
            child: GestureDetector(
              onTap: () {
                loginController.pickImage();
              },
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
          ),
        ],
      ),
    );
  }

  // ── Save button ───────────────────────────────────────────────────────
  Widget _buildSaveButton(LoginController loginController) {
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
      child: Obx(() => CustomButton(
        onTap: () {
          if (!loginController.updateProfileLoading.value) {
             loginController.updateProfile();
          }
        },
        title: loginController.updateProfileLoading.value ? 'Saving...' : 'Save Changes',
        fillColor: Colors.transparent,
        textColor: AppColors.white,
        fontSize: 16,
        borderRadius: 16,
        height: 56,
        fontWeight: FontWeight.w700,
      )),
    );
  }
}

// ── Input field with icon ──────────────────────────────────────────────
class _InputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool readOnly;

  const _InputField({
    required this.hintText,
    required this.icon,
    required this.controller,
    this.keyboardType,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFormCard(
      title: '',
      hintText: hintText,
      fillBorderRadius: 14,
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
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
        CustomText(
          text: label,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF0E0E0E),
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