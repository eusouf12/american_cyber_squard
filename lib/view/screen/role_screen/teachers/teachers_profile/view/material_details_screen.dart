import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:america_ayber_squad/view/components/custom_loader/custom_loader.dart';
import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:america_ayber_squad/utils/ToastMsg/toast_message.dart';
import '../controller/teachers_material_controller.dart';
import '../model/metarial.dart';

class MaterialDetailsScreen extends StatelessWidget {
  final String materialId;
  final String? assignmentTitle;
  final String? classLevel;

  MaterialDetailsScreen({
    super.key,
    required this.materialId,
    this.assignmentTitle,
    this.classLevel,
  });

  final TeachersMaterialController controller = Get.find<TeachersMaterialController>();

  Widget _buildHeader(String title, String level, String type) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 8.h),
          CustomText(
            text: level,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: CustomText(
                  text: type.toUpperCase(),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Fetch detail on load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getSpecificMaterial(materialId);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomRoyelAppbar(
        titleName: "Material Details",
        leftIcon: true,
      ),
      body: Obx(() {
        if (controller.isSpecificLoading.value) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(assignmentTitle ?? "Loading...", classLevel ?? "...", "pdf"),
                SizedBox(height: 24.h),
                const Center(child: CustomLoader()),
              ],
            ),
          );
        }

        final MaterialItem? item = controller.specificMaterialData.value;
        if (item == null) {
          return Center(
            child: CustomText(
              text: "Details not found",
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(
                item.assignmentTitle ?? assignmentTitle ?? "No Title",
                item.classDistributions?.classLevel ?? classLevel ?? "No Class",
                item.materialType ?? "pdf",
              ),
              SizedBox(height: 24.h),

              // Description Section
              CustomText(
                text: "Description",
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              SizedBox(height: 8.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: CustomText(
                  text: item.description ?? "No description provided.",
                  fontSize: 14.sp,
                  color: Colors.black87,
                  textAlign: TextAlign.start,
                  maxLines: 100,
                ),
              ),
              SizedBox(height: 24.h),

              // External Link Section
              if (item.externalLink != null && item.externalLink!.isNotEmpty) ...[
                CustomText(
                  text: "External Link",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                SizedBox(height: 8.h),
                InkWell(
                  onTap: () async {
                    final Uri url = Uri.parse(item.externalLink!);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    } else {
                      showCustomSnackBar("Could not launch $url", isError: true);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.blue.shade100),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.link, color: Colors.blue),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: CustomText(
                            text: item.externalLink!,
                            fontSize: 14.sp,
                            color: Colors.blue.shade700,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
              ],

              // Material Files Section
              if (item.materialFiles != null && item.materialFiles!.isNotEmpty) ...[
                CustomText(
                  text: "Attached Files (${item.materialFiles!.length})",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                SizedBox(height: 8.h),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: item.materialFiles!.length,
                  itemBuilder: (context, idx) {
                    final fileUrl = item.materialFiles![idx];
                    final name = fileUrl.split('/').last.split('-').last;
                    return Card(
                      margin: EdgeInsets.only(bottom: 10.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      elevation: 0.5,
                      child: ListTile(
                        onTap: () async {
                          final Uri url = Uri.parse(fileUrl);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url, mode: LaunchMode.externalApplication);
                          } else {
                            showCustomSnackBar("Could not open file", isError: true);
                          }
                        },
                        leading: Icon(Icons.insert_drive_file, color: AppColors.primary),
                        title: CustomText(
                          text: name,
                          fontSize: 13.sp,
                          color: Colors.black87,
                          textAlign: TextAlign.start,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.download, color: AppColors.primary),
                          onPressed: () async {
                            final Uri url = Uri.parse(fileUrl);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url, mode: LaunchMode.externalApplication);
                            } else {
                              showCustomSnackBar("Could not download file", isError: true);
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        );
      }),
    );
  }
}
