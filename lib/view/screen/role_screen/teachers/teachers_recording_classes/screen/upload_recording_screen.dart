import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:america_ayber_squad/view/components/custom_button/custom_button.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:america_ayber_squad/view/components/custom_text_field/custom_text_field.dart';
import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_loader/custom_loader.dart';
import '../controller/recording_class_controller.dart';
import '../model/teacher_class_distribution.dart';

class UploadRecordingScreen extends StatelessWidget {
  const UploadRecordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RecordingClassController controller = Get.find<RecordingClassController>();

    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: "Upload Recording",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dropdown Label
                  CustomText(
                    text: "Select Subject",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    bottom: 8.h,
                    color: AppColors.black_03,
                  ),
                  Obx(() {
                    if (controller.isDistributionLoading.value) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: CustomLoader(),
                        ),
                      );
                    }
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Colors.grey.shade300, width: 1),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<TeacherClassDistribution>(
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          hint: Text(
                            "Choose a subject",
                            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade400),
                          ),
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.grey),
                          value: controller.selectedDistribution.value,
                          items: controller.classDistributionList.map((item) {
                            return DropdownMenuItem<TeacherClassDistribution>(
                              value: item,
                              child: Text(
                                "${item.assignableSubject ?? "No Subject"} (${item.classLevel ?? ""})",
                                style: TextStyle(fontSize: 14.sp, color: AppColors.black_03),
                              ),
                            );
                          }).toList(),
                          onChanged: (TeacherClassDistribution? newValue) {
                            if (newValue != null) {
                              controller.selectedDistribution.value = newValue;
                            }
                          },
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 20.h),

                  // Input: Recording URL (Editable)
                  CustomText(
                    text: "Recording URL",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    bottom: 8.h,
                    color: AppColors.black_03,
                  ),
                  CustomTextField(
                    textEditingController: controller.recordingUrlController,
                    hintText: "Enter Zoom / YouTube URL",
                    fillColor: Colors.white,
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Obx(() {
              return controller.isUploading.value
                  ? const SizedBox(
                      height: 54,
                      child: Center(child: CustomLoader()),
                    )
                  : CustomButton(
                      onTap: () {
                        controller.uploadClassRecording();
                      },
                      title: "Upload Link",
                      fillColor: AppColors.primary,
                      textColor: AppColors.white,
                    );
            }),
          ),
        ),
      ),
    );
  }
}
