import 'package:america_ayber_squad/utils/app_const/app_const.dart';
import 'package:america_ayber_squad/view/components/custom_loader/custom_loader.dart';
import 'package:america_ayber_squad/helper/time_converter/time_converter.dart';
import 'package:america_ayber_squad/view/components/custom_nav_bar/teacher_nav_bar.dart';
import 'package:america_ayber_squad/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:america_ayber_squad/view/screen/role_screen/teachers/teachers_home/widget/custom_homework_card.dart';
import 'package:america_ayber_squad/view/screen/role_screen/teachers/teachers_home/widget/custom_quick_card.dart';
import 'package:america_ayber_squad/view/screen/role_screen/teachers/teachers_home/widget/custom_today_schedule_card.dart';
import 'package:america_ayber_squad/view/screen/role_screen/teachers/teachers_home/widget/custom_announcement_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../controller/teachers_controller.dart';
import '../../../../Login_role/login_controller.dart';
import 'package:intl/intl.dart';

class TeachersHomeScreen extends StatelessWidget {
  TeachersHomeScreen({super.key});

  final LoginController loginController = Get.find<LoginController>();
  final TeachersController teachersController = Get.find<TeachersController>();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> gridItems = [
      {
        'title': 'Mark Attendance',
        'icon': Icons.assignment_turned_in_outlined,
        'route': AppRoutes.teachersAttendanceScreen,
      },
      {
        'title': 'New Assignment',
        'icon': Icons.add,
        'route': AppRoutes.teachersAssignmentScreen,
      },
      {
        'title': 'Grade Papers',
        'icon': Icons.description_outlined,
        'route': AppRoutes.teacherExamGradeScreen,
      },
      {
        'title': 'Schedule Class',
        'icon': Icons.calendar_today_outlined,
        'route': AppRoutes.teacherScheduleScreen,
      },
    ];

    return CustomGradient(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // =============== Profile info ===================
                  Obx(() {
                    final profile = loginController.myProfileData.value;
                    final imageUrl =
                        (profile?.photo != null && profile!.photo!.isNotEmpty)
                            ? profile.photo!
                            : AppConstants.profileImage;

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
                  // ── Notification bell ─────────────────────────────
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_none,
                          size: 28,
                          color: Colors.black,
                        ),
                      ),
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            '2',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //======== today schedule =========
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(() {
                              final nowStr = DateFormat('yyyy-MM-dd')
                                  .format(DateTime.now());
                              final selStr = DateFormat('yyyy-MM-dd').format( teachersController.selectedDate.value);
                              final title = nowStr == selStr
                                  ? "Today's Schedule"
                                  : "${DateFormat('EEEE').format(teachersController.selectedDate.value)}'s Schedule";
                              return CustomText(
                                  text: title,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600);
                            }),
                            const Spacer(),
                            // === calender icon===
                            GestureDetector(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate:teachersController.selectedDate.value,
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2030),
                                );
                                if (pickedDate != null) {teachersController.changeSelectedDate(pickedDate);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.primary1,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.calendar_today, size: 18,color: AppColors.primary,),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Obx(() {
                          if (teachersController.isScheduleLoading.value) {
                            return const Center(
                              child: Padding( padding: EdgeInsets.symmetric(vertical: 20),
                                child: CustomLoader(),
                              ),
                            );
                          }
                          if (teachersController .filteredScheduleList.isEmpty) {
                            return Padding(padding: const EdgeInsets.symmetric(vertical: 20),child: Center(child: CustomText(text: "No schedule for this day", fontSize: 14.sp,color: Colors.grey,
                              ),
                              ),
                            );
                          }
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: teachersController.filteredScheduleList.length,
                              itemBuilder: (context, index) {
                                final routine = teachersController.filteredScheduleList[index];
                                return GestureDetector(
                                  onTap: (){
                                    Get.toNamed(AppRoutes.detailsScheduleScreen, arguments: routine);
                                  },
                                  child: CustomTodayScheduleCard(
                                    name: routine.assignableSubject ?? "No Subject",
                                    subject: routine.classLevel ?? "No Class",
                                    time: routine.time ?? "N/A",
                                  ),
                                );
                              });
                        }),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //===== quick actions
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            text: "Quick Actions",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                        SizedBox(height: 20),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 1.2,
                          ),
                          itemCount: gridItems.length,
                          itemBuilder: (context, index) {
                            return CustomQuickCard(
                              title: gridItems[index]['title'],
                              icon: gridItems[index]['icon'],
                              onTap: () {
                                Get.toNamed(gridItems[index]['route']);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                //====== assignment and homework
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                                text: "Assignment & HomeWork",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600),
                            Spacer(),
                            GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.allAssignmentsScreen);
                                },
                                child: CustomText(
                                  text: "View All",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                )),
                          ],
                        ),
                        SizedBox(height: 20),
                        Obx(() {
                          if (teachersController.isAssignmentLoading.value) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: CustomLoader(),
                              ),
                            );
                          }
                          if (teachersController.assignmentList.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                child: CustomText(
                                  text: "No assignments found",
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          }
                          final itemsToShow = teachersController.assignmentList.take(3).toList();
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: itemsToShow.length,
                              itemBuilder: (context, index) {
                                final assignment = itemsToShow[index];
                                return CustomHomeworkCard(
                                  subject: assignment.assignmentTitle ?? "No Subject",
                                  chapter: assignment.assignmentType ?? "N/A",
                                  grade: assignment.classDistributions?.classLevel ?? "N/A",
                                  assessmentAvailable:assignment.assessmentAvailable,
                                  time: (() {
                                    try {
                                      if (assignment.assignmentDueDate != null && assignment.assignmentDueDate!.isNotEmpty) {
                                        return DateConverter.timeFormetString(assignment.assignmentDueDate!);
                                      }
                                    } catch (_) {}
                                    return assignment.assignmentDueDate ?? "N/A";
                                  })(),
                                  onTap: () {},
                                );
                              });
                        }),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //====== announcements
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                                text: "Announcements",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600),
                            Spacer(),
                            GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.allAnnouncementsScreen);
                                },
                                child: CustomText(
                                  text: "View All",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                )),
                          ],
                        ),
                        SizedBox(height: 20),
                        Obx(() {
                          if (teachersController.isAnnouncementLoading.value) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: CustomLoader(),
                              ),
                            );
                          }
                          if (teachersController.announcementList.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                child: CustomText(
                                  text: "No announcements found",
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          }
                          final itemsToShow = teachersController.announcementList.take(2).toList();
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: itemsToShow.length,
                              itemBuilder: (context, index) {
                                final announcement = itemsToShow[index];
                                return CustomAnnouncementCard(
                                  title: announcement.title ?? "No Title",
                                  content: announcement.description ?? "No Content",
                                  date: (() {
                                    try {
                                      if (announcement.createdAt != null && announcement.createdAt!.isNotEmpty) {
                                        return DateConverter.timeFormetString(announcement.createdAt!);
                                      }
                                    } catch (_) {}
                                    return announcement.createdAt ?? "N/A";
                                  })(),
                                  onTap: () {},
                                );
                              });
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: TeacherNavBar(currentIndex: 0)),
    );
  }
}
