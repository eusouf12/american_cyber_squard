import 'package:america_ayber_squad/view/components/custom_loader/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../teachers_home/controller/teachers_controller.dart';
import '../../../student/view/student_profile/widgets/custom_schedule_card.dart';
import '../../../student/view/student_profile/widgets/custom_time_card.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../controller/teacher_student_controller.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_text_field/custom_text_field.dart';

class TeacherScheduleScreen extends StatelessWidget {
  const TeacherScheduleScreen({super.key});

  static const List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  Widget build(BuildContext context) {
    final TeachersController controller = Get.find<TeachersController>();

    // Local reactive selected day
    final RxString selectedDay = 'Sunday'.obs;

    // Load latest schedule data on screen entry
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getTeacherSchedule();
    });

    return Scaffold(
      appBar: CustomRoyelAppbar(
        titleName: "Schedule",
        leftIcon: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header Row ────────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Weekly Timetable",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    Icon(Icons.videocam_outlined,
                        color: Colors.green, size: 20),
                    CustomText(
                        text: "Online",
                        fontSize: 12.sp,
                        color: Colors.grey,
                        left: 5),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        color: Colors.grey, size: 20),
                    CustomText(
                        text: "Offline",
                        fontSize: 12.sp,
                        color: Colors.grey,
                        left: 5),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // ── Day Filter Row ─────────────────────────────────────────────
            Row(
              children: [
                CustomText(
                    text: "Time",
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp),
                const Spacer(),
                CustomText(
                    text: "Day:", fontWeight: FontWeight.w600, fontSize: 14.sp),
                SizedBox(width: 12.w),
                Obx(() => Container(
                      width: 130.w,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedDay.value,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down),
                          style:
                              TextStyle(fontSize: 14.sp, color: Colors.black),
                          onChanged: (String? val) {
                            if (val != null) selectedDay.value = val;
                          },
                          items: _days
                              .map<DropdownMenuItem<String>>(
                                (d) => DropdownMenuItem<String>(
                                  value: d,
                                  child: Text(d,
                                      style: const TextStyle(
                                          color: Colors.black)),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(height: 20.h),

            // ── Schedule List ──────────────────────────────────────────────
            Obx(() {
              if (controller.isScheduleLoading.value) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: CustomLoader(),
                  ),
                );
              }

              final allItems = controller.allScheduleList;

              // Filter by selected day
              final filtered = selectedDay.value == 'All'
                  ? allItems
                  : allItems
                      .where((e) =>
                          e.day?.trim().toLowerCase() ==
                          selectedDay.value.trim().toLowerCase())
                      .toList();

              debugPrint(
                  "DEBUG SCHEDULE SCREEN: allItems.length = ${allItems.length}, filtered.length = ${filtered.length}");
              for (var i = 0; i < filtered.length; i++) {
                debugPrint(
                    "DEBUG ITEM $i: ${filtered[i].assignableSubject} on ${filtered[i].day} at ${filtered[i].time}");
              }

              if (filtered.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Column(
                      children: [
                        Icon(Icons.calendar_today_outlined,
                            size: 48.sp, color: Colors.grey.shade300),
                        SizedBox(height: 12.h),
                        CustomText(
                          text: "No schedule found",
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final item = filtered[index];

                  final bool isOnline = item.isOnline == true;
                  final String timeText = item.time ?? "N/A";
                  final String subjectText =
                      item.assignableSubject ?? "Subject";
                  final String classLevelText = item.classLevel ?? "";
                  final String roomText = item.roomNumber ?? "";
                  final String dayText = item.day ?? "";

                  final ClassStatus cardStatus =
                      isOnline ? ClassStatus.online : ClassStatus.offline;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Day label (show when showing "All")
                      if (selectedDay.value == 'All' && dayText.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(bottom: 6.h),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: CustomText(
                              text: dayText,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTimeCard(time: timeText),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: GestureDetector(
                              onTap: isOnline
                                  ? () {
                                      final classDistId =
                                          item.classDistributionId ??
                                              item.classDistribution?.id ??
                                              item.id ??
                                              "";
                                      showPostOnlineClassPopup(
                                          context, classDistId);
                                    }
                                  : null,
                              child: CustomScheduleCard(
                                status: cardStatus,
                                subject: subjectText,
                                teacher: classLevelText.isNotEmpty
                                    ? classLevelText
                                    : null,
                                room: isOnline ? null : roomText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

void showPostOnlineClassPopup(
    BuildContext context, String classDistributionId) {
  final TeacherStudentController controller =
      Get.find<TeacherStudentController>();
  final TextEditingController linkController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Container(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Zoom Link",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon:
                            Icon(Icons.close, size: 20.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CustomText(
                    text: "Enter Zoom Meeting Link",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    textEditingController: linkController,
                    hintText: "https://zoom.us/j/...",
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return "Please enter Zoom meeting link";
                      }
                      if (!val.trim().startsWith("http://") &&
                          !val.trim().startsWith("https://")) {
                        return "Please enter a valid URL starting with http:// or https://";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.h),
                  Obx(() {
                    final loading = controller.isOnlineClassLoading.value;
                    return Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onTap:
                                loading ? null : () => Navigator.pop(context),
                            title: "Cancel",
                            fontSize: 12.sp,
                            textColor: AppColors.black,
                            fillColor: AppColors.white,
                            borderColor: AppColors.primary,
                            isBorder: true,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: CustomButton(
                            onTap: loading
                                ? null
                                : () async {
                                    if (formKey.currentState!.validate()) {
                                      final success =
                                          await controller.postOnlineClass(
                                        classDistributionId:
                                            classDistributionId,
                                        link: linkController.text.trim(),
                                      );
                                      if (success) {
                                        Navigator.pop(context);
                                      }
                                    }
                                  },
                            title: loading ? "Posting..." : "Post Link",
                            fontSize: 12.sp,
                            textColor: AppColors.white,
                            fillColor: AppColors.primary,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
