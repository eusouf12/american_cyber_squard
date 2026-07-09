import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:america_ayber_squad/view/components/custom_button/custom_button.dart';
import 'package:america_ayber_squad/view/components/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/teacher_create_controller.dart';
import '../../teachers_home/controller/teachers_controller.dart';

void showCreateAssignmentPopup(BuildContext context) {
  final TeacherAssignmentController controller =
      Get.find<TeacherAssignmentController>();
  final TeachersController teachersController =
      Get.find<TeachersController>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final RxString selectedType = "HomeWork".obs;
  final Rxn<DateTime> selectedDueDate = Rxn<DateTime>();
  final Rxn<TimeOfDay> selectedDueTime = Rxn<TimeOfDay>();

  // Reset controller states
  controller.pickedFiles.clear();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Create New Assignment",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close, size: 20.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Assignment Title
                  CustomText(text: "Assignment Title", fontSize: 14.sp, fontWeight: FontWeight.w600),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    textEditingController: titleController,
                    hintText: "e.g., Algebra Homework - Chapter 5",
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return "Please enter a title";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),

                  // Class & Type Row
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: "Class", fontSize: 14.sp, fontWeight: FontWeight.w600),
                            SizedBox(height: 8.h),
                            Obx(() {
                              final uniqueClasses = teachersController.allScheduleList
                                  .map((e) => e.classLevel)
                                  .where((c) => c != null && c.isNotEmpty)
                                  .map((c) => c!)
                                  .toSet()
                                  .toList();

                              final itemsList = uniqueClasses
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
                                  .toList();

                              final String? selectedClass = (controller.selectedClassLevel.value != null &&
                                      uniqueClasses.contains(controller.selectedClassLevel.value))
                                  ? controller.selectedClassLevel.value
                                  : null;

                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    dropdownColor: Colors.white,
                                    value: selectedClass,
                                    hint: Text(
                                      "Select Class",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                    isExpanded: true,
                                    icon: Icon(Icons.keyboard_arrow_down, size: 20.sp, color: Colors.grey),
                                    items: itemsList,
                                    onChanged: (String? val) {
                                      if (val != null) {
                                        controller.selectedClassLevel.value = val;
                                        final matchedSchedules = teachersController.allScheduleList
                                            .where((e) => e.classLevel == val)
                                            .toList();
                                        if (matchedSchedules.isNotEmpty) {
                                          controller.selectedClassId.value = matchedSchedules.first.id;
                                        }
                                      }
                                    },
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: "Type", fontSize: 14.sp, fontWeight: FontWeight.w600),
                            SizedBox(height: 8.h),
                            Obx(() => Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      dropdownColor: Colors.white,
                                      value: selectedType.value,
                                      isExpanded: true,
                                      icon: Icon(Icons.keyboard_arrow_down, size: 20.sp, color: Colors.grey),
                                      items: ["HomeWork", "Practice", "Project", "Quiz"]
                                          .map((String value) => DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value, style: TextStyle(fontSize: 14.sp)),
                                              ))
                                          .toList(),
                                      onChanged: (String? val) {
                                        if (val != null) {
                                          selectedType.value = val;
                                        }
                                      },
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Due Date & Time Row
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: "Due Date", fontSize: 14.sp, fontWeight: FontWeight.w600),
                            SizedBox(height: 8.h),
                            InkWell(
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now().subtract(const Duration(days: 1)),
                                  lastDate: DateTime(2100),
                                );
                                if (date != null) {
                                  selectedDueDate.value = date;
                                }
                              },
                              child: Obx(() => Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(color: Colors.grey.shade300),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: selectedDueDate.value == null
                                              ? "Select Date"
                                              : DateFormat('MM/dd/yyyy').format(selectedDueDate.value!),
                                          fontSize: 13.sp,
                                          color: selectedDueDate.value == null ? Colors.grey : Colors.black87,
                                        ),
                                        Icon(Icons.calendar_today_outlined, size: 16.sp, color: Colors.grey),
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: "Due Time", fontSize: 14.sp, fontWeight: FontWeight.w600),
                            SizedBox(height: 8.h),
                            InkWell(
                              onTap: () async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (time != null) {
                                  selectedDueTime.value = time;
                                }
                              },
                              child: Obx(() => Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(color: Colors.grey.shade300),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: selectedDueTime.value == null
                                              ? "Select Time"
                                              : selectedDueTime.value!.format(context),
                                          fontSize: 13.sp,
                                          color: selectedDueTime.value == null ? Colors.grey : Colors.black87,
                                        ),
                                        Icon(Icons.access_time, size: 16.sp, color: Colors.grey),
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Description
                  CustomText(text: "Description", fontSize: 14.sp, fontWeight: FontWeight.w600),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    textEditingController: descriptionController,
                    hintText: "Enter assignment description and instructions...",
                    maxLines: 4,
                  ),
                  SizedBox(height: 16.h),

                  // Attachments
                  CustomText(text: "Attachments (Optional)", fontSize: 14.sp, fontWeight: FontWeight.w600),
                  SizedBox(height: 8.h),
                  InkWell(
                    onTap: () => controller.pickFiles(),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: CustomText(text: "Choose Files", fontSize: 12.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Obx(() {
                              final count = controller.pickedFiles.length;
                              return CustomText(
                                text: count == 0 ? "No file chosen" : "$count files selected",
                                fontSize: 12.sp,
                                color: Colors.grey,
                                textAlign: TextAlign.start,
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // Display Picked Files List
                  Obx(() {
                    if (controller.pickedFiles.isEmpty) return const SizedBox.shrink();
                    return Container(
                      constraints: BoxConstraints(maxHeight: 120.h),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.all(8.w),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.pickedFiles.length,
                        itemBuilder: (context, idx) {
                          final file = controller.pickedFiles[idx];
                          final fileName = file.path.split('/').last.split('\\').last;
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CustomText(
                                    text: fileName,
                                    fontSize: 11.sp,
                                    color: Colors.black87,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => controller.removeFile(idx),
                                  child: Icon(Icons.cancel, color: Colors.red, size: 16.sp),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }),

                  SizedBox(height: 25.h),

                  // Action Buttons
                  Obx(() {
                    final loading = controller.isLoading.value;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: CustomButton(
                            onTap: loading ? null : () => Navigator.pop(context),
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
                                      if (selectedDueDate.value == null || selectedDueTime.value == null) {
                                        Get.snackbar("Error", "Please select both due date and time");
                                        return;
                                      }

                                      final date = selectedDueDate.value!;
                                      final time = selectedDueTime.value!;
                                      final combinedDateTime = DateTime(
                                        date.year,
                                        date.month,
                                        date.day,
                                        time.hour,
                                        time.minute,
                                      ).toUtc();

                                      final success = await controller.createAssignment(
                                        title: titleController.text,
                                        type: selectedType.value,
                                        description: descriptionController.text,
                                        dueDate: combinedDateTime.toIso8601String(),
                                      );

                                      if (success) {
                                        Navigator.pop(context);
                                      }
                                    }
                                  },
                            title: loading ? "Creating..." : "Create Assignment",
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