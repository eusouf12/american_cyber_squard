import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_loader/custom_loader.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:america_ayber_squad/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:america_ayber_squad/service/api_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/teacher_student_controller.dart';

class TeacherStudentDetailsScreen extends StatelessWidget {
  final String studentId;
  final String studentName;

  const TeacherStudentDetailsScreen({
    super.key,
    required this.studentId,
    required this.studentName,
  });

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "N/A";
    try {
      final dateTime = DateTime.parse(dateStr).toLocal();
      return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
    } catch (_) {
      return dateStr;
    }
  }

  String getImageUrl(String? path) {
    if (path == null || path.isEmpty) return "";
    if (path.startsWith("http://") || path.startsWith("https://")) {
      return path;
    }
    String base = ApiUrl.imageUrl;
    if (base.endsWith("/") && path.startsWith("/")) {
      return base + path.substring(1);
    } else if (!base.endsWith("/") && !path.startsWith("/")) {
      return "$base/$path";
    }
    return base + path;
  }

  String stripHtmlIfNeeded(String? htmlString) {
    if (htmlString == null || htmlString.isEmpty) return "N/A";
    return htmlString.replaceAll(RegExp(r'<[^>]*>'), '').trim();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TeacherStudentController>();

    return CustomGradient(
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: CustomRoyelAppbar(
          titleName: "Student Details",
          leftIcon: true,
        ),
        body: Obx(() {
          if (controller.isDetailsLoading.value) {
            return const Center(child: CustomLoader());
          }

          final details = controller.studentDetails.value;
          if (details == null) {
            return Center(
              child: CustomText(
                text: "No details found.",
                fontSize: 16.sp,
                color: Colors.grey,
              ),
            );
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      details.photo != null && details.photo!.isNotEmpty
                          ? CustomNetworkImage(
                              imageUrl: getImageUrl(details.photo),
                              height: 80.r,
                              width: 80.r,
                              borderRadius: BorderRadius.circular(40.r),
                            )
                          : CircleAvatar(
                              radius: 40.r,
                              backgroundColor:
                                  AppColors.primary.withValues(alpha: 0.1),
                              child: Icon(
                                Icons.person,
                                size: 45.sp,
                                color: AppColors.primary,
                              ),
                            ),
                      SizedBox(height: 12.h),
                      CustomText(
                        text: studentName,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        text: "ID: ${details.studentId ?? 'N/A'}",
                        fontSize: 13.sp,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 8.h),
                      if (details.classDistributions != null &&
                          details.classDistributions!.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: CustomText(
                            text: details.classDistributions!
                                .map((e) => e.classLevel ?? "")
                                .join(", "),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                // Contact & Guardian Information
                _buildSectionHeader("Contact & Guardian"),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      _buildInfoRow(
                          Icons.email_outlined, "Email", details.email),
                      const Divider(),
                      _buildInfoRow(Icons.person_pin_circle_outlined,
                          "Guardian Name", details.guardianName),
                      const Divider(),
                      _buildInfoRow(Icons.phone_android_outlined,
                          "Guardian Phone", details.guardianPhone),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                // Health Records
                _buildSectionHeader("Health Records"),
                SizedBox(height: 8.h),
                if (details.healthRecords == null ||
                    details.healthRecords!.isEmpty)
                  _buildEmptyState("No health records found")
                else
                  ...details.healthRecords!.map((record) => Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 18.r,
                                  backgroundColor: Colors.redAccent.withValues(alpha: 0.1),
                                  child: Icon(Icons.bloodtype,
                                      color: Colors.redAccent, size: 20.sp),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: "Blood Type: ${record.bloodType ?? 'N/A'}",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(height: 4.h),
                                      CustomText(
                                        text: formatDate(record.createdAt),
                                        fontSize: 11.sp,
                                        color: Colors.grey.shade500,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Divider(),
                            ),
                            _buildDetailsRow(
                                "Emergency Contact", record.emergencyContact),
                            SizedBox(height: 8.h),
                            _buildDetailsRow("Notes / Summary :",
                                stripHtmlIfNeeded(record.tipTapEditor)),
                          ],
                        ),
                      )),
                SizedBox(height: 20.h),

                // Exam Grades
                _buildSectionHeader("Exam Grades"),
                SizedBox(height: 8.h),
                if (details.examGrades == null || details.examGrades!.isEmpty)
                  _buildEmptyState("No exam grades found")
                else
                  ...details.examGrades!.map((grade) => Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 18.r,
                                  backgroundColor: Colors.amber.withValues(alpha: 0.1),
                                  child: Icon(Icons.grade,
                                      color: Colors.amber.shade700, size: 20.sp),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: "Score: ${grade.marks ?? 0} / ${grade.totalMarks ?? 0}",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(height: 4.h),
                                      CustomText(
                                        text: formatDate(grade.createdAt),
                                        fontSize: 11.sp,
                                        color: Colors.grey.shade500,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Divider(),
                            ),
                            _buildDetailsRow(
                                "Instructions : ", grade.instructions,),
                          ],
                        ),
                      )),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return CustomText(
      text: title,
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: Colors.grey.shade600),
          SizedBox(width: 12.w),
          CustomText(
            text: "$label:",
            fontSize: 13.sp,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(width: 5.w),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: CustomText(
                text: value ?? "N/A",
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                textAlign: TextAlign.start,
                maxLines: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsRow(String label, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          fontSize: 12.sp,
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 4.h),
        CustomText(
          text: value ?? "N/A",
          fontSize: 13.sp,
          color: Colors.black87,
          maxLines: 10,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Center(
        child: CustomText(
          text: message,
          fontSize: 13.sp,
          color: Colors.grey,
        ),
      ),
    );
  }
}
