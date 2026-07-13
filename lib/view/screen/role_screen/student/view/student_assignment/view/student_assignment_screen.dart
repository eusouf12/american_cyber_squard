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
import 'student_assignment_details_screen.dart';

class StudentAssignmentScreen extends StatelessWidget {
  const StudentAssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentHomeController controller = Get.find<StudentHomeController>();

    // Reload assignments on entry
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initData();
    });

    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () => controller.initData(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),

                  // --- Subject Dropdown Block ---
                  Obx(() {
                    if (controller.studentSubjectsList.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 16.h),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Colors.grey.shade100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Select Subject",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF374151),
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                dropdownColor: Colors.white,
                                value: controller.selectedSubject.value,
                                hint: Text(
                                  "Select Subject",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                isExpanded: true,
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.grey.shade400,
                                ),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black87,
                                ),
                                onChanged: (String? val) {
                                  if (val != null) {
                                    controller.selectedSubject.value = val;
                                    controller.getStudentAssignments();
                                  }
                                },
                                items: controller.studentSubjectsList
                                    .map<DropdownMenuItem<String>>(
                                      (String value) => DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  
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
                            count: "Overdue",
                            label: "${controller.overdueCount.value}",
                            icon: Icons.error_outline,
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
                          onViewDetails: () {
                            Get.to(() => StudentAssignmentDetailsScreen(
                                  assignment: ass,
                                  subject: subject,
                                ));
                          },
                          onSubmit: () {
                            showSubmitAssignmentPopup(context, ass, controller);
                          },
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

  void showSubmitAssignmentPopup(BuildContext context, StudentClassAssignment assignment, StudentHomeController controller) {
    controller.submissionFiles.clear();

    Get.bottomSheet(
      Obx(() {
        final files = controller.submissionFiles;
        final isSubmitting = controller.isSubmitting.value;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Submit Assignment",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            assignment.assignmentTitle ?? "",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey.shade500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                CustomText(
                  text: "Upload Attachment",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                  bottom: 8.h,
                ),

                // File Picker Box
                InkWell(
                  onTap: isSubmitting ? null : () => controller.pickSubmissionFiles(),
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.03),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.25),
                        style: BorderStyle.solid,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          size: 36.sp,
                          color: AppColors.primary,
                        ),
                        SizedBox(height: 8.h),
                        CustomText(
                          text: "Select picture, PDF, or any file",
                          fontSize: 12.sp,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // List of picked files
                if (files.isNotEmpty) ...[
                  CustomText(
                    text: "Selected Files (${files.length})",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                    bottom: 8.h,
                  ),
                  Container(
                    constraints: BoxConstraints(maxHeight: 120.h),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        final file = files[index];
                        final name = file.path.split('/').last;
                        return Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.insert_drive_file_outlined,
                                  color: AppColors.primary, size: 18.sp),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  name,
                                  style: TextStyle(fontSize: 12.sp),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                                onPressed: isSubmitting ? null : () => controller.removeSubmissionFile(index),
                                icon: const Icon(Icons.delete_outline, color: Colors.red),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isSubmitting
                        ? null
                        : () async {
                            final success = await controller.submitAssignment(assignment.id!);
                            if (success) {
                              Get.back();
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: isSubmitting
                        ? SizedBox(
                            height: 20.h,
                            width: 20.h,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            "Submit Assignment",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      isScrollControlled: true,
      barrierColor: Colors.black.withValues(alpha: 0.4),
    );
  }
}
