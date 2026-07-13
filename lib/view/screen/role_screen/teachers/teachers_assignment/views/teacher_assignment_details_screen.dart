import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_loader/custom_loader.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../../service/api_url.dart';
import '../controller/teacher_create_controller.dart';

class TeacherAssignmentDetailsScreen extends StatelessWidget {
  final String assignmentId;
  final String classLevel;

  const TeacherAssignmentDetailsScreen({
    super.key,
    required this.assignmentId,
    required this.classLevel,
  });

  Future<void> _openUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar("Error", "Could not open URL");
      }
    } catch (e) {
      Get.snackbar("Error", "Invalid link");
    }
  }

  @override
  Widget build(BuildContext context) {
    final TeacherAssignmentController controller =
        Get.find<TeacherAssignmentController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchSpecificAssignment(assignmentId);
      controller.assignmentSubmitedList(assignmentId);
    });

    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(
          titleName: "Assignment Details",
          leftIcon: true,
        ),
        body: Obx(() {
          final isLoading = controller.isSpecificAssignmentLoading.value;
          final assignmentData = controller.specificAssignmentData.value;

          if (isLoading) {
            return const Center(child: CustomLoader());
          }

          if (assignmentData == null) {
            return const Center(
              child: CustomText(text: "Failed to load assignment details"),
            );
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Main Details Card ---
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Badge row for Type & Class
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.layers_outlined, color: AppColors.primary, size: 14.sp),
                                  SizedBox(width: 4.w),
                                  Text(
                                    classLevel.isNotEmpty ? classLevel : "N/A",
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: Colors.blue.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.assignment_outlined, color: Colors.blue, size: 14.sp),
                                  SizedBox(width: 4.w),
                                  Text(
                                    assignmentData['assignmentType']?.toString() ?? "Homework",
                                    style: TextStyle(
                                      color: Colors.blue.shade700,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),

                        // Title
                        Text(
                          assignmentData['assignmentTitle']?.toString() ?? "N/A",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            height: 1.3,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 16.h),
                        const Divider(color: Color(0xFFF3F4F6)),
                        SizedBox(height: 12.h),

                        // Due Date & Time Section
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: Colors.red.withValues(alpha: 0.06),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Icon(Icons.calendar_month, color: Colors.red.shade600, size: 20.sp),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "Due Date & Time",
                                    fontSize: 11.sp,
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(height: 2.h),
                                  Builder(builder: (context) {
                                    final dueStr = assignmentData['assignmentDueDate']?.toString() ?? "";
                                    final dueDateTime = DateTime.tryParse(dueStr);
                                    final formattedDate = dueDateTime != null
                                        ? DateFormat('MMMM d, yyyy - hh:mm a').format(dueDateTime.toLocal())
                                        : "N/A";
                                    return Text(
                                      formattedDate,
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),

                        // Description Section
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: Colors.amber.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Icon(Icons.description_outlined, color: Colors.amber.shade700, size: 20.sp),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "Description",
                                    fontSize: 11.sp,
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(height: 6.h),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(12.w),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF9FAFB),
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(color: const Color(0xFFF3F4F6)),
                                    ),
                                    child: Text(
                                      assignmentData['description']?.toString() ?? "No description provided",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.grey.shade800,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),

                        // Attachments Section
                        Row(
                          children: [
                            Icon(Icons.attachment_outlined, color: Colors.grey.shade700, size: 18.sp),
                            SizedBox(width: 6.w),
                            Text(
                              "Attachments",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Builder(builder: (context) {
                          final List<dynamic> attachments =
                              assignmentData['attachmentFiles'] ?? [];
                          if (attachments.isEmpty) {
                            return Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF9FAFB),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: CustomText(
                                text: "No attachments provided",
                                fontSize: 12.sp,
                                color: Colors.grey.shade400,
                              ),
                            );
                          }
                          return Column(
                            children: attachments.map((url) {
                              final fullUrl = ApiUrl.imageUrl + url.toString();
                              final fileName =
                                  url.toString().split('/').last.split('-').last;

                              return Container(
                                margin: EdgeInsets.only(bottom: 8.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withValues(alpha: 0.02),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  onTap: () => _openUrl(fullUrl),
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(6.w),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary.withValues(alpha: 0.08),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(Icons.link_outlined,
                                              color: AppColors.primary, size: 16.sp),
                                        ),
                                        SizedBox(width: 12.w),
                                        Expanded(
                                          child: Text(
                                            fileName,
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Icon(Icons.arrow_forward_ios,
                                            color: AppColors.primary.withValues(alpha: 0.5), size: 12.sp),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // --- Section Title for Student Submissions ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 4.w,
                            height: 18.h,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "Student Submissions",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      Obx(() {
                        final count = controller.submittedList.length;
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            "$count Submitted",
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Submissions List
                  Obx(() {
                    if (controller.isSubmittedListLoading.value) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: CustomLoader(),
                        ),
                      );
                    }

                    if (controller.submittedList.isEmpty) {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 36.h, horizontal: 20.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: Colors.grey.shade100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.assignment_turned_in_outlined,
                                  size: 40.sp, color: Colors.grey.shade400),
                            ),
                            SizedBox(height: 12.h),
                            CustomText(
                              text: "No submissions yet",
                              fontSize: 13.sp,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.submittedList.length,
                      itemBuilder: (context, index) {
                        final submission = controller.submittedList[index];
                        final submittedFile = submission.uploadFiles?.isNotEmpty == true
                            ? submission.uploadFiles!.first
                            : null;
                        final subDateTime = submittedFile?.createdAt;
                        final formattedSubDate = subDateTime != null
                            ? DateFormat('MMM d, yyyy - hh:mm a')
                                .format(subDateTime.toLocal())
                            : "N/A";

                        final studentPhoto = submission.student?.photo;
                        final profileUrl = studentPhoto != null && studentPhoto.isNotEmpty
                            ? ApiUrl.imageUrl + studentPhoto
                            : null;

                        return Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            border: Border.all(color: Colors.grey.shade100),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 22.r,
                                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                                    backgroundImage: profileUrl != null ? NetworkImage(profileUrl) : null,
                                    child: profileUrl == null
                                        ? Icon(Icons.person, color: AppColors.primary, size: 22.sp)
                                        : null,
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          submission.student?.name ?? "Student",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 3.h),
                                        Row(
                                          children: [
                                            Icon(Icons.access_time, size: 12.sp, color: Colors.grey),
                                            SizedBox(width: 4.w),
                                            Text(
                                              "Submitted: $formattedSubDate",
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (submission.uploadFiles != null && submission.uploadFiles!.isNotEmpty) ...[
                                SizedBox(height: 14.h),
                                const Divider(height: 1, color: Color(0xFFF3F4F6)),
                                SizedBox(height: 12.h),
                                Text(
                                  "Submitted Attachments:",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Wrap(
                                  spacing: 8.w,
                                  runSpacing: 8.h,
                                  children: submission.uploadFiles!.map((file) {
                                    final fileUrl = file.fileUrl ?? "";
                                    final fullUrl = ApiUrl.imageUrl + fileUrl;
                                    final fileName = fileUrl.split('/').last.split('-').last;
                                    return Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () => _openUrl(fullUrl),
                                        borderRadius: BorderRadius.circular(30.r),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary.withValues(alpha: 0.05),
                                            borderRadius: BorderRadius.circular(30.r),
                                            border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.link_outlined, size: 14.sp, color: AppColors.primary),
                                              SizedBox(width: 6.w),
                                              Flexible(
                                                child: Text(
                                                  fileName,
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: AppColors.primary,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
