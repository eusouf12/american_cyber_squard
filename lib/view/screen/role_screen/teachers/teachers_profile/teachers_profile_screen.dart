import 'package:america_ayber_squad/view/components/custom_nav_bar/teacher_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../../../utils/app_const/app_const.dart';
import '../../../../../../../core/app_routes/app_routes.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_show_dialog/custom_show_dialog.dart';
import '../../../Login_role/login_controller.dart';

class TeachersProfileScreen extends StatelessWidget {
  TeachersProfileScreen({super.key});

  final loginController = Get.find<LoginController>();

  static const List<_ProfileMenuItem> _menuItems = [
    _ProfileMenuItem(
      title: 'Chat',
      subtitle: 'Messages & conversations',
      icon: Icons.chat_bubble_rounded,
      gradientColors: [Color(0xFF088F55), Color(0xFF10B981)],
    ),
    _ProfileMenuItem(
      title: 'Student',
      subtitle: 'Manage your students',
      icon: Icons.school_rounded,
      gradientColors: [Color(0xFF1D4ED8), Color(0xFF3B82F6)],
    ),
    _ProfileMenuItem(
      title: 'Schedule',
      subtitle: 'Class timetable & events',
      icon: Icons.calendar_month_rounded,
      gradientColors: [Color(0xFF7C3AED), Color(0xFFA78BFA)],
    ),
    _ProfileMenuItem(
      title: 'Materials',
      subtitle: 'Lessons & resources',
      icon: Icons.folder_open_rounded,
      gradientColors: [Color(0xFFD97706), Color(0xFFFBBF24)],
    ),
    _ProfileMenuItem(
      title: 'Support',
      subtitle: 'Help & contact us',
      icon: Icons.headset_mic_rounded,
      gradientColors: [Color(0xFF0891B2), Color(0xFF22D3EE)],
    ),
    _ProfileMenuItem(
      title: 'Edit Profile',
      subtitle: 'Update your information',
      icon: Icons.edit_rounded,
      gradientColors: [Color(0xFF059669), Color(0xFF34D399)],
    ),
    _ProfileMenuItem(
      title: 'Change Password',
      subtitle: 'Security settings',
      icon: Icons.lock_rounded,
      gradientColors: [Color(0xFF4B5563), Color(0xFF9CA3AF)],
    ),
  ];

  void _handleMenuTap(int index) {
    switch (index) {
      case 0:
        Get.toNamed(AppRoutes.chatListScreen);
      case 1:
        Get.toNamed(AppRoutes.teacherStudentScreen);
      case 2:
        Get.toNamed(AppRoutes.teacherScheduleScreen);
      case 3:
        Get.toNamed(AppRoutes.teachersMaterial);
      case 4:
        Get.toNamed(AppRoutes.contactUsScreen);
      case 5:
        Get.toNamed(AppRoutes.editScreen);
      case 6:
        Get.toNamed(AppRoutes.changePassScreen);
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.white,
        insetPadding: const EdgeInsets.all(8),
        contentPadding: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: CustomShowDialog(
            textColor: AppColors.black,
            title: 'Are You Sure',
            discription: 'Logout Your Account',
            showColumnButton: true,
            showCloseButton: true,
            rightOnTap: () => Get.back(),
            leftOnTap: () => Get.offAllNamed(AppRoutes.loginScreen),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FDF4),
      body: Stack(
        children: [
          // ── Decorative background blobs ──────────────────────────
          Positioned(
            top: -60,
            right: -40,
            child: _GlowCircle(
              size: 220,
              color: AppColors.primary.withValues(alpha: 0.18),
            ),
          ),
          Positioned(
            top: 120,
            left: -60,
            child: _GlowCircle(
              size: 160,
              color: AppColors.primary2.withValues(alpha: 0.10),
            ),
          ),
          Positioned(
            top: 260,
            right: 20,
            child: _GlowCircle(
              size: 80,
              color: AppColors.primary.withValues(alpha: 0.08),
            ),
          ),

          // ── Main content ─────────────────────────────────────────
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: _buildHeader(context),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _MenuTile(
                        item: _menuItems[index],
                        onTap: () => _handleMenuTap(index),
                      ),
                      childCount: _menuItems.length,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
                  sliver: SliverToBoxAdapter(
                    child: _buildLogoutButton(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const TeacherNavBar(currentIndex: 5),
    );
  }

  // ── Hero header ───────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        gradient: const LinearGradient(
          colors: [Color(0xFF088F55), Color(0xFF10B981)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.r),
        child: Stack(
          children: [
            Positioned(
              top: -30,
              right: -20,
              child: _GlowCircle(
                size: 130,
                color: Colors.white.withValues(alpha: 0.12),
              ),
            ),
            Positioned(
              bottom: -20,
              left: 30,
              child: _GlowCircle(
                size: 80,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 22.h),
              child: Row(
                children: [
                  // Avatar with ring
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.6),
                        width: 2.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Obx(() => CustomNetworkImage(
                      imageUrl: loginController.myProfileData.value?.photo ?? AppConstants.profileImage2,
                      boxShape: BoxShape.circle,
                      height: 72.h,
                      width: 72.w,
                    )),
                  ),
                  SizedBox(width: 16.w),

                  // Name, badge & stats
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                          loginController.myProfileData.value?.teacherName ?? 'Teacher',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        )),
                        SizedBox(height: 5.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.22),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            '✦  Teacher',
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            _StatBadge(label: 'Students', value: '124'),
                            SizedBox(width: 10.w),
                            _StatBadge(label: 'Classes', value: '12'),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Notification bell
                  Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.30),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Logout button ─────────────────────────────────────────────────────
  Widget _buildLogoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showLogoutDialog(context),
      child: Container(
        height: 58.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.r),
          color: const Color(0xFFFFEEEE),
          border: Border.all(
            color: const Color(0xFFFFCCCC),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 34.h,
              width: 34.w,
              decoration: BoxDecoration(
                color: const Color(0xFFFF5555).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.logout_rounded,
                color: const Color(0xFFE53935),
                size: 18.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFE53935),
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Stat badge ─────────────────────────────────────────────────────────
class _StatBadge extends StatelessWidget {
  final String label;
  final String value;

  const _StatBadge({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.75),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Menu tile ─────────────────────────────────────────────────────────
class _MenuTile extends StatelessWidget {
  final _ProfileMenuItem item;
  final VoidCallback onTap;

  const _MenuTile({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 68.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(width: 14.w),

              // Gradient icon box
              Container(
                height: 44.h,
                width: 44.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: item.gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(13.r),
                  boxShadow: [
                    BoxShadow(
                      color: item.gradientColors[0].withValues(alpha: 0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  item.icon,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 14.w),

              // Title & subtitle
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title.tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0E0E0E),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      item.subtitle,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ),

              // Chevron
              Container(
                height: 34.h,
                width: 34.w,
                margin: EdgeInsets.only(right: 14.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.20),
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.primary,
                  size: 13.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Data model ─────────────────────────────────────────────────────────
class _ProfileMenuItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradientColors;

  const _ProfileMenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradientColors,
  });
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