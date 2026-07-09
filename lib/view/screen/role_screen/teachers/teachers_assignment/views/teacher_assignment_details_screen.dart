import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:america_ayber_squad/view/components/custom_button/custom_button.dart';
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

  @override
  Widget build(BuildContext context) {
    final TeacherAssignmentController controller =
        Get.find<TeacherAssignmentController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchSpecificAssignment(assignmentId);
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

          final displayClass = classLevel;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Assignment Title",
                      fontSize: 12.sp,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(height: 6.h),
                    CustomText(
                      text: assignmentData['assignmentTitle']?.toString() ?? "N/A",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 20.h),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Class",
                                fontSize: 12.sp,
                                color: Colors.grey.shade500,
                              ),
                              SizedBox(height: 6.h),
                              CustomText(
                                text: displayClass.isNotEmpty ? displayClass : "N/A",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Type",
                                fontSize: 12.sp,
                                color: Colors.grey.shade500,
                              ),
                              SizedBox(height: 6.h),
                              CustomText(
                                text: assignmentData['assignmentType']?.toString() ?? "N/A",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    CustomText(
                      text: "Due Date & Time",
                      fontSize: 12.sp,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(height: 6.h),
                    Builder(builder: (context) {
                      final dueStr = assignmentData['assignmentDueDate']?.toString() ?? "";
                      final dueDateTime = DateTime.tryParse(dueStr);
                      final formattedDate = dueDateTime != null
                          ? DateFormat('MMMM d, yyyy - hh:mm a').format(dueDateTime.toLocal())
                          : "N/A";
                      return CustomText(
                        text: formattedDate,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.start,
                      );
                    }),
                    SizedBox(height: 20.h),

                    CustomText(
                      text: "Description",
                      fontSize: 12.sp,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(height: 6.h),
                    CustomText(
                      text: assignmentData['description']?.toString() ?? "N/A",
                      fontSize: 13.sp,
                      color: Colors.black87,
                      textAlign: TextAlign.start,
                      maxLines: 100,
                    ),
                    SizedBox(height: 24.h),

                    CustomText(
                      text: "Attachments",
                      fontSize: 12.sp,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 12.h),
                    Builder(builder: (context) {
                      final List<dynamic> attachments =
                          assignmentData['attachmentFiles'] ?? [];
                      if (attachments.isEmpty) {
                        return CustomText(
                          text: "No attachments provided",
                          fontSize: 12.sp,
                          color: Colors.grey.shade400,
                        );
                      }
                      return Column(
                        children: attachments.map((url) {
                          final fullUrl = ApiUrl.imageUrl + url.toString();
                          final fileName =
                              url.toString().split('/').last.split('-').last;
                          final isImage =
                              url.toString().toLowerCase().endsWith('.jpg') ||
                                  url.toString().toLowerCase().endsWith('.jpeg') ||
                                  url.toString().toLowerCase().endsWith('.png') ||
                                  url.toString().toLowerCase().endsWith('.webp') ||
                                  url.toString().toLowerCase().endsWith('.gif');

                          if (isImage) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 12.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(8.r)),
                                    child: Image.network(
                                      fullUrl,
                                      height: 200.h,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                        height: 120.h,
                                        color: Colors.grey.shade100,
                                        child: const Icon(Icons.broken_image,
                                            color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.w),
                                    child: CustomText(
                                      text: fileName,
                                      fontSize: 11.sp,
                                      color: Colors.black54,
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return InkWell(
                            onTap: () async {
                              try {
                                final Uri uri = Uri.parse(fullUrl);
                                await launchUrl(uri,
                                    mode: LaunchMode.externalApplication);
                              } catch (e) {
                                Get.snackbar("Error", "Could not open attachment");
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 8.h),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.insert_drive_file,
                                      color: AppColors.primary, size: 18.sp),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: CustomText(
                                      text: fileName,
                                      fontSize: 12.sp,
                                      maxLines: 1,
                                      color: Colors.black87,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Icon(Icons.open_in_new,
                                      color: Colors.grey, size: 16.sp),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }),
                    SizedBox(height: 24.h),

                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        onTap: () => Get.back(),
                        title: "Back",
                        fillColor: AppColors.primary,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
