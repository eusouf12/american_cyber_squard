import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:america_ayber_squad/utils/app_const/app_const.dart';
import 'package:america_ayber_squad/view/components/custom_loader/custom_loader.dart';
import 'package:america_ayber_squad/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../components/custom_nav_bar/student_nav_bar.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../Login_role/login_controller.dart';
import '../../widget/custom_all_info_card.dart';
import '../../widget/custom_attenddance.dart';
import '../../widget/custom_shedule_item.dart';
import '../student_profile/controller/student_profile_controller.dart';

class StudentHomeScreen extends StatelessWidget {
  StudentHomeScreen({super.key});

  final LoginController loginController = Get.find<LoginController>();
  final StudentProfileController studentProfileController =
      Get.find<StudentProfileController>();

  @override
  Widget build(BuildContext context) {
    if (loginController.myProfileData.value == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        loginController.getMyProfile();
      });
    }

    return Container(
      color: Colors.white,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  final profile = loginController.myProfileData.value;
                  final imageUrl =
                      (profile?.photo != null && profile!.photo!.isNotEmpty)
                          ? profile.photo!
                          : AppConstants.profileImage2;

                  return Row(
                    children: [
                      ClipOval(
                        child: CustomNetworkImage(
                          imageUrl: imageUrl,
                          height: 45,
                          width: 45,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: profile?.teacherName ?? '',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          CustomText(
                            text: profile?.branchName ?? '',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                        ],
                      ),
                    ],
                  );
                }),
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_none,
                        size: 28,
                      ),
                    ),
                    Positioned(
                      right: 12,
                      top: 12,
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Summary Cards (Classes & GPA)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomAllInfoCard(
                        title: "Attendance",
                        subtitle: "Overall attendance rate",
                        count: "92%",
                        icon: Icons.check_circle_outline,
                        textColor: Colors.grey[800]!,
                      ),
                      const SizedBox(width: 8),
                      CustomAllInfoCard(
                        title: "Pending Assignments",
                        subtitle: "Assignments due soon",
                        count: "3",
                        icon: Icons.assignment_late_outlined,
                        textColor: Colors.grey[800]!,
                      ),
                      const SizedBox(width: 8),
                      CustomAllInfoCard(
                        title: "Upcoming Exams",
                        subtitle: "Exams scheduled soon",
                        count: "2",
                        icon: Icons.school_outlined,
                        textColor: Colors.grey[800]!,
                      ),
                      const SizedBox(width: 8),
                      CustomAllInfoCard(
                        title: "Grades Received",
                        subtitle: "Recent grades received",
                        count: "4",
                        icon: Icons.grade_outlined,
                        textColor: AppColors.white,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // Today's Schedule
                _buildSectionTitle("Today's Schedule", "View Week", onTap: () {
                  Get.toNamed(AppRoutes.studentScheduleScreen);
                }),
                const SizedBox(height: 15),

                Obx(() {
                  if (studentProfileController.isScheduleLoading.value) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: CustomLoader(),
                      ),
                    );
                  }

                  // Get current day name in local timezone, e.g. "Sunday"
                  final String todayDay =
                      DateFormat('EEEE').format(DateTime.now());

                  final allItems = studentProfileController.allScheduleList;

                  // Filter by today's day (case-insensitive)
                  final todayItems = allItems
                      .where((e) =>
                          e.day?.trim().toLowerCase() ==
                          todayDay.trim().toLowerCase())
                      .toList();

                  if (todayItems.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Column(
                          children: [
                            Icon(Icons.calendar_today_outlined,
                                size: 36.sp, color: Colors.grey.shade300),
                            SizedBox(height: 8.h),
                            CustomText(
                              text: "No classes scheduled for today",
                              fontSize: 13.sp,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: todayItems.map((item) {
                      final bool isOnline = item.isOnline == true;
                      final String subjectText =
                          item.assignableSubject ?? "Subject";
                      final String teacherText =
                          item.teacher?.teacherName ?? "N/A";
                      final String roomText = item.roomNumber ?? "N/A";
                      final String timeText = item.time ?? "N/A";

                      return CustomScheduleItem(
                        subject: subjectText,
                        details: "Room $roomText • $teacherText",
                        time: timeText,
                        color: isOnline ? Colors.green : Colors.deepPurple,
                        status: isOnline ? "Online" : "Offline",
                        isActive: isOnline,
                        onTap: () {},
                      );
                    }).toList(),
                  );
                }),

                const SizedBox(height: 20),

                // Upcoming Assignments (Example)
                _buildSectionTitle("Upcoming Assignments", "View All"),
                const SizedBox(height: 15),
                CustomAssignmentCard(
                  title: "Math Homework",
                  dueText: "Due Tomorrow",
                  bgColor: Colors.purple.shade50,
                  chapterDetails: "Chapter 5: Quadratic Equations",
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
          bottomNavigationBar: StudentNavBar(currentIndex: 0)),
    );
  }

  Widget _buildSectionTitle(String title, String actionText,
      {VoidCallback? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        if (actionText.isNotEmpty)
          TextButton(
            onPressed: onTap,
            child: Text(actionText,
                style: const TextStyle(color: AppColors.primary)),
          )
      ],
    );
  }
}
