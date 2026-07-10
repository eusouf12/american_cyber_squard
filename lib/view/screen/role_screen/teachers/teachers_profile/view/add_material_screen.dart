import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:america_ayber_squad/view/components/custom_button/custom_button.dart';
import 'package:america_ayber_squad/view/components/custom_from_card/custom_from_card.dart';
import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import '../controller/teachers_material_controller.dart';
import '../../teachers_home/controller/teachers_controller.dart';
import '../../teachers_home/model/teacher_schedule.dart';

class AddMaterialScreen extends StatelessWidget {
  AddMaterialScreen({super.key});

  final TeachersMaterialController controller = Get.find<TeachersMaterialController>();
  final TeachersController teachersController = Get.find<TeachersController>();
  final _formKey = GlobalKey<FormState>();

  final descriptionController = TextEditingController();
  final linkController = TextEditingController();
  final metarialNameController = TextEditingController();
  final RxString selectedType = "pdf".obs;

  @override
  Widget build(BuildContext context) {
    // Sync classDistributionId from parent selected state
    final RxString localClassId = (controller.selectedClassId.value ?? "").obs;
    final RxString localClassLevel = (controller.selectedClassLevel.value ?? "").obs;

    // Reset picked files on entry
    controller.pickedFiles.clear();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomRoyelAppbar(
        titleName: "Add New Materials",
        leftIcon: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Class Selection Dropdown
              CustomText(
                text: "Class",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF374151),
              ),
              SizedBox(height: 8.h),
              Obx(() {
                final schedules = teachersController.allScheduleList
                    .where((e) => e.classLevel != null && e.classLevel!.isNotEmpty)
                    .toList();

                // If local selected id is empty and schedules is not empty, default to first
                if (localClassId.value.isEmpty && schedules.isNotEmpty) {
                  final firstSchedule = schedules.first;
                  localClassId.value = firstSchedule.id ?? firstSchedule.classDistributionId ?? "";
                  localClassLevel.value = firstSchedule.classLevel ?? "";
                }

                final String? selectedValId = (localClassId.value.isNotEmpty &&
                        schedules.any((e) => (e.id ?? e.classDistributionId ?? "") == localClassId.value))
                    ? localClassId.value
                    : null;

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: Colors.white,
                      value: selectedValId,
                      hint: Text(
                        "Select Class",
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
                      ),
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade400),
                      style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                      onChanged: (String? val) {
                        if (val != null) {
                          localClassId.value = val;
                          final matched = schedules.firstWhere((e) => (e.id ?? e.classDistributionId ?? "") == val);
                          localClassLevel.value = matched.classLevel ?? "";
                        }
                      },
                      items: schedules.map<DropdownMenuItem<String>>((RoutineModel routine) {
                        final id = routine.id ?? routine.classDistributionId ?? "";
                        final classText = "${routine.classLevel ?? ''} - ${routine.assignableSubject ?? ''}";
                        return DropdownMenuItem<String>(
                          value: id,
                          child: Text(classText),
                        );
                      }).toList(),
                    ),
                  ),
                );
              }),
              SizedBox(height: 16.h),
               // Material Name
              CustomFormCard(
                title: "Material Name",
                hintText: "Enter material name...",
                controller: metarialNameController,
                maxLine: 4,
                isMultiLine: true,
                fillBorderRadius: 10,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return "Material Name is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.h),

              // Material Type
              CustomText(
                text: "Material Type",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF374151),
              ),
              SizedBox(height: 8.h),
              Obx(() => Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor: Colors.white,
                        value: selectedType.value,
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade400),
                        style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                        onChanged: (String? val) {
                          if (val != null) selectedType.value = val;
                        },
                        items: ["pdf", "doc", "video", "link"].map<DropdownMenuItem<String>>((String val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val.toUpperCase()),
                          );
                        }).toList(),
                      ),
                    ),
                  )),
              SizedBox(height: 16.h),

              // Description
              CustomFormCard(
                title: "Description",
                hintText: "Enter material description...",
                controller: descriptionController,
                maxLine: 4,
                isMultiLine: true,
                fillBorderRadius: 10,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return "Description is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.h),

              // External Link
              CustomFormCard(
                title: "External Link (Optional)",
                hintText: "https://example.com/resource",
                controller: linkController,
              ),
              SizedBox(height: 16.h),

              // Attachments chooser
              CustomText(
                text: "Upload Files (Optional)",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF374151),
              ),
              SizedBox(height: 8.h),
              InkWell(
                onTap: () => controller.pickFiles(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: CustomText(
                          text: "Choose Files",
                          fontSize: 12.sp,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Obx(() {
                          final count = controller.pickedFiles.length;
                          return CustomText(
                            text: count == 0 ? "No file selected" : "$count files selected",
                            fontSize: 13.sp,
                            color: Colors.grey.shade600,
                            textAlign: TextAlign.start,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // Display Picked Files
              Obx(() {
                if (controller.pickedFiles.isEmpty) return const SizedBox.shrink();
                return Container(
                  constraints: BoxConstraints(maxHeight: 180.h),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  padding: EdgeInsets.all(10.w),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.pickedFiles.length,
                    itemBuilder: (context, idx) {
                      final File file = controller.pickedFiles[idx];
                      final name = file.path.split('/').last.split('\\').last;
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: Row(
                          children: [
                            Icon(Icons.insert_drive_file_outlined, color: AppColors.primary, size: 16.sp),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: CustomText(
                                text: name,
                                fontSize: 12.sp,
                                color: Colors.black87,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            IconButton(
                              onPressed: () => controller.removeFile(idx),
                              icon: Icon(Icons.cancel, color: Colors.red.shade400, size: 18.sp),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),
              SizedBox(height: 30.h),

              // Submit Button
              Obx(() {
                final loading = controller.isLoading.value;
                return CustomButton(
                  title: loading ? "Saving..." : "Save Material",
                  fillColor: AppColors.primary,
                  onTap: loading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            if (localClassId.value.isEmpty) {
                              Get.snackbar("Error", "Please select a valid class");
                              return;
                            }
                            final success = await controller.createMaterial(
                              assignmenttitle: metarialNameController.text,
                              classDistributionId: localClassId.value,
                              materialType: selectedType.value,
                              description: descriptionController.text,
                              externalLink: linkController.text,
                            );
                            if (success) {
                              Get.back();
                            }
                          }
                        },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
