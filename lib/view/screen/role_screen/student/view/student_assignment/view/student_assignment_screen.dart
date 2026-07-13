import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:america_ayber_squad/view/components/custom_loader/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:america_ayber_squad/view/components/custom_nav_bar/student_nav_bar.dart';
import 'package:america_ayber_squad/view/screen/role_screen/student/widget/custom_assignment_status.dart';
import 'package:america_ayber_squad/view/screen/role_screen/student/controller/student_home_controller.dart';
import '../model/student_assignment_model.dart';
import 'package:america_ayber_squad/view/screen/role_screen/teachers/teachers_attendance/widgets/custom_teachers_attendance_card.dart';

class StudentAssignmentScreen extends StatelessWidget {
  const StudentAssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentHomeController controller = Get.find<StudentHomeController>();

    // Reload assignments on entry
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getStudentAssignments();
    });

    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () => controller.getStudentAssignments(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  
                  // Summary cards styled like teachers attendance cards
                  Obx(() {
                    return Row(
                      children: [
                        Expanded(
                          child: CustomTeachersAttendanceCard(
                            count: "Completed",
                            label: "${controller.completedCount.value}",
                            icon: Icons.check_circle_outline,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CustomTeachersAttendanceCard(
                            count: "Pending",
                            label: "${controller.dueCount.value}",
                            icon: Icons.assignment_late_outlined,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CustomTeachersAttendanceCard(
                            count: "In Progress",
                            label: "${controller.pendingCount.value}",
                            icon: Icons.pending_actions,
                          ),
                        ),
                      ],
                    );
                  }),
                  
                  const SizedBox(height: 25),
                  
                  // Section Header and "Due Today" warning badge
                  Obx(() {
                    final dueToday = controller.dueTodayCount;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Assignments",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                        if (dueToday > 0)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(color: Colors.red.shade200),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.warning_amber_rounded, color: Colors.red, size: 14.sp),
                                SizedBox(width: 4.w),
                                CustomText(
                                  text: "$dueToday Due Today",
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  }),
                  
                  const SizedBox(height: 15),

                  // Assignment list
                  Obx(() {
                    if (controller.isAssignmentLoading.value) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(40),
                          child: CustomLoader(),
                        ),
                      );
                    }

                    // Collect all assignments
                    final List<Map<String, dynamic>> allItems = [];
                    for (var dist in controller.assignmentsList) {
                      final subject = dist.assignableSubject ?? "N/A";
                      if (dist.classAssignments != null) {
                        for (var ass in dist.classAssignments!) {
                          allItems.add({
                            "subject": subject,
                            "assignment": ass,
                          });
                        }
                      }
                    }

                    if (allItems.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: CustomText(
                            text: "No assignments found",
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: allItems.length,
                      itemBuilder: (context, index) {
                        final item = allItems[index];
                        final String subject = item["subject"];
                        final StudentClassAssignment ass = item["assignment"];

                        final title = ass.assignmentTitle ?? "N/A";
                        final bool isSubmitted = ass.isSubmitted ?? false;
                        final bool isOver = ass.assessmentAvailable ?? false;

                        // Calculate tag text, status text, and colors
                        String tagText = "Pending";
                        Color tagBg = Colors.orange.shade50;
                        Color tagTextClr = Colors.orange.shade800;
                        
                        String statusText = "Pending";
                        Color statusBg = Colors.orange.shade50;
                        Color statusTextClr = Colors.orange.shade800;
                        
                        bool showSubmitButton = false;
                        bool isCompletedIcon = false;
                        String dateLabel = "Due: ";

                        // Format due date
                        final dueStr = ass.assignmentDueDate != null
                            ? DateFormat('MMM d, yyyy').format(ass.assignmentDueDate!.toLocal())
                            : "N/A";

                        if (isSubmitted) {
                          // Student submitted it!
                          tagText = "Submitted";
                          tagBg = Colors.green.shade50;
                          tagTextClr = Colors.green;
                          isCompletedIcon = true;
                          showSubmitButton = false;

                          if (isOver) {
                            // Submitted and date over
                            statusText = "Submitted";
                            statusBg = Colors.green.shade50;
                            statusTextClr = Colors.green;
                            dateLabel = "Completed: ";
                          } else {
                            // Submitted but time remaining (In Progress)
                            statusText = "In Progress";
                            statusBg = Colors.blue.shade50;
                            statusTextClr = Colors.blue;
                            dateLabel = "Submitted: ";
                          }
                        } else {
                          // Not submitted!
                          if (isOver) {
                            // Not submitted & date is over
                            tagText = "Overdue";
                            tagBg = Colors.red.shade50;
                            tagTextClr = Colors.red;
                            
                            statusText = "Not Submitted";
                            statusBg = Colors.red.shade50;
                            statusTextClr = Colors.red;
                            
                            showSubmitButton = false;
                            dateLabel = "Overdue: ";
                          } else {
                            // Not submitted & still has time
                            statusText = "Pending";
                            statusBg = Colors.orange.shade50;
                            statusTextClr = Colors.orange.shade800;
                            
                            showSubmitButton = true;
                            dateLabel = "Due: ";

                            if (ass.assignmentDueDate != null) {
                              final now = DateTime.now();
                              final diff = ass.assignmentDueDate!.difference(now).inDays;
                              if (diff == 0) {
                                tagText = "Due Today";
                                tagBg = Colors.red.shade50;
                                tagTextClr = Colors.red;
                              } else if (diff < 0) {
                                tagText = "Overdue";
                                tagBg = Colors.red.shade50;
                                tagTextClr = Colors.red;
                                showSubmitButton = false;
                              } else {
                                tagText = "Due in $diff day${diff > 1 ? 's' : ''}";
                                tagBg = Colors.blue.shade50;
                                tagTextClr = Colors.blue;
                              }
                            } else {
                              tagText = "Pending";
                              tagBg = Colors.orange.shade50;
                              tagTextClr = Colors.orange.shade800;
                            }
                          }
                        }

                        return CustomAssignmentCard(
                          title: title,
                          subject: subject,
                          tagText: tagText,
                          tagColor: tagBg,
                          tagTextColor: tagTextClr,
                          isCheckIcon: isCompletedIcon,
                          dateLabel: dateLabel,
                          dateValue: dueStr,
                          status: statusText,
                          statusColor: statusBg,
                          statusTextColor: statusTextClr,
                          showSubmitButton: showSubmitButton,
                          onViewDetails: () {},
                          onSubmit: () {},
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: StudentNavBar(currentIndex: 2),
      ),
    );
  }
}
