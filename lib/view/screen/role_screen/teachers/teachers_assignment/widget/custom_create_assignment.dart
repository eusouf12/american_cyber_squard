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
import 'package:america_ayber_squad/view/components/custom_loader/custom_loader.dart';
import 'package:america_ayber_squad/service/api_url.dart';
import 'package:url_launcher/url_launcher.dart';

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

void showAssignmentDetailsPopup(BuildContext context, String assignmentId) async {
  final TeacherAssignmentController controller = Get.find<TeacherAssignmentController>();
  
  Get.dialog(
    const Center(
      child: CustomLoader(),
    ),
    barrierDismissible: false,
  );
  
  final data = await controller.fetchSpecificAssignment(assignmentId);
  Get.back(); // Close loading dialog
  
  if (data == null) return;
  
  final title = data['assignmentTitle']?.toString() ?? "N/A";
  final type = data['assignmentType']?.toString() ?? "N/A";
  final description = data['description']?.toString() ?? "N/A";
  final classLevel = data['classLevel']?.toString() ?? "N/A";
  final dueStr = data['assignmentDueDate']?.toString() ?? "";
  final dueDateTime = DateTime.tryParse(dueStr);
  final formattedDate = dueDateTime != null 
      ? DateFormat('MMMM d, yyyy - hh:mm a').format(dueDateTime.toLocal())
      : "N/A";
      
  final List<dynamic> attachments = data['attachmentFiles'] ?? [];

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Container(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomText(
                        text: "Assignment Details",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, size: 20.sp, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                
                CustomText(text: "Title", fontSize: 12.sp, color: Colors.grey),
                SizedBox(height: 4.h),
                CustomText(text: title, fontSize: 15.sp, fontWeight: FontWeight.bold, textAlign: TextAlign.start),
                SizedBox(height: 16.h),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: "Class", fontSize: 12.sp, color: Colors.grey),
                          SizedBox(height: 4.h),
                          CustomText(text: classLevel, fontSize: 14.sp, fontWeight: FontWeight.w600, textAlign: TextAlign.start),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: "Type", fontSize: 12.sp, color: Colors.grey),
                          SizedBox(height: 4.h),
                          CustomText(text: type, fontSize: 14.sp, fontWeight: FontWeight.w600, textAlign: TextAlign.start),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                CustomText(text: "Due Date & Time", fontSize: 12.sp, color: Colors.grey),
                SizedBox(height: 4.h),
                CustomText(text: formattedDate, fontSize: 14.sp, fontWeight: FontWeight.w600, textAlign: TextAlign.start),
                SizedBox(height: 16.h),

                CustomText(text: "Description", fontSize: 12.sp, color: Colors.grey),
                SizedBox(height: 4.h),
                CustomText(text: description, fontSize: 13.sp, color: Colors.black87, textAlign: TextAlign.start, maxLines: 10),
                SizedBox(height: 16.h),

                CustomText(text: "Attachments", fontSize: 12.sp, color: Colors.grey),
                SizedBox(height: 8.h),
                if (attachments.isEmpty)
                  CustomText(text: "No attachments provided", fontSize: 12.sp, color: Colors.grey.shade500)
                else
                  Column(
                    children: attachments.map((url) {
                      final fullUrl = ApiUrl.imageUrl + url.toString();
                      final fileName = url.toString().split('/').last.split('-').last;
                      final isImage = url.toString().toLowerCase().endsWith('.jpg') ||
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
                                borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
                                child: Image.network(
                                  fullUrl,
                                  height: 150.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    height: 100.h,
                                    color: Colors.grey.shade100,
                                    child: const Icon(Icons.broken_image, color: Colors.grey),
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
                            await launchUrl(uri, mode: LaunchMode.externalApplication);
                          } catch (e) {
                            Get.snackbar("Error", "Could not open attachment");
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.insert_drive_file, color: AppColors.primary, size: 18.sp),
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
                              Icon(Icons.open_in_new, color: Colors.grey, size: 16.sp),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                SizedBox(height: 20.h),
                
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    onTap: () => Navigator.pop(context),
                    title: "Close",
                    fillColor: AppColors.primary,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showEditAssignmentPopup(BuildContext context, Map<String, dynamic> assignmentData) {
  final TeacherAssignmentController controller =
      Get.find<TeacherAssignmentController>();

  // Keep the existing classLevel & classDistributionId so the update API
  // still sends the correct values (user can't change them here anymore).
  final String? rawClassLevel = assignmentData['classLevel']?.toString()
      ?? assignmentData['classDistributions']?['classLevel']?.toString();

  final String? rawClassId = assignmentData['classDistributionId']?.toString()
      ?? assignmentData['classDistributions']?['id']?.toString();


  final titleController = TextEditingController(
      text: assignmentData['assignmentTitle']?.toString() ?? "");
  final descriptionController = TextEditingController(
      text: assignmentData['description']?.toString() ?? "");
  final formKey = GlobalKey<FormState>();

  final RxString selectedType =
      (assignmentData['assignmentType']?.toString() ?? "HomeWork").obs;

  final dueStr = assignmentData['assignmentDueDate']?.toString() ?? "";
  final initialDueDate = DateTime.tryParse(dueStr);
  final Rxn<DateTime> selectedDueDate = Rxn<DateTime>(initialDueDate);
  final Rxn<TimeOfDay> selectedDueTime = Rxn<TimeOfDay>(
      initialDueDate != null
          ? TimeOfDay.fromDateTime(initialDueDate.toLocal())
          : null);

  // Reset picked files
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
                        text: "Edit Assignment",
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

                  // Type
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
                            icon: Icon(Icons.keyboard_arrow_down,
                                size: 20.sp, color: Colors.grey),
                            items: ["HomeWork", "Practice", "Project", "Quiz"]
                                .map((String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: TextStyle(fontSize: 14.sp)),
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
                                  initialDate:
                                      selectedDueDate.value ?? DateTime.now(),
                                  firstDate: DateTime.now()
                                      .subtract(const Duration(days: 30)),
                                  lastDate: DateTime(2100),
                                );
                                if (date != null) {
                                  selectedDueDate.value = date;
                                }
                              },
                              child: Obx(() => Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 12.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.r),
                                      border:
                                          Border.all(color: Colors.grey.shade300),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: selectedDueDate.value == null
                                              ? "Select Date"
                                              : DateFormat('MM/dd/yyyy')
                                                  .format(selectedDueDate.value!),
                                          fontSize: 13.sp,
                                          color: selectedDueDate.value == null
                                              ? Colors.grey
                                              : Colors.black87,
                                        ),
                                        Icon(Icons.calendar_today_outlined,
                                            size: 16.sp, color: Colors.grey),
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
                                  initialTime:
                                      selectedDueTime.value ?? TimeOfDay.now(),
                                );
                                if (time != null) {
                                  selectedDueTime.value = time;
                                }
                              },
                              child: Obx(() => Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 12.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.r),
                                      border:
                                          Border.all(color: Colors.grey.shade300),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: selectedDueTime.value == null
                                              ? "Select Time"
                                              : selectedDueTime.value!
                                                  .format(context),
                                          fontSize: 13.sp,
                                          color: selectedDueTime.value == null
                                              ? Colors.grey
                                              : Colors.black87,
                                        ),
                                        Icon(Icons.access_time,
                                            size: 16.sp, color: Colors.grey),
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

                  // Current Attachments List
                  Builder(builder: (context) {
                    final List<dynamic> currentFiles =
                        assignmentData['attachmentFiles'] ?? [];
                    if (currentFiles.isEmpty) return const SizedBox.shrink();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            text: "Current Attachments",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                        SizedBox(height: 8.h),
                        Container(
                          constraints: BoxConstraints(maxHeight: 120.h),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          padding: EdgeInsets.all(8.w),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: currentFiles.length,
                            itemBuilder: (context, idx) {
                              final url = currentFiles[idx].toString();
                              final fileName =
                                  url.split('/').last.split('-').last;
                              return Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: 4.h),
                                child: Row(
                                  children: [
                                    Icon(Icons.insert_drive_file,
                                        color: AppColors.primary,
                                        size: 16.sp),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: CustomText(
                                        text: fileName,
                                        fontSize: 11.sp,
                                        color: Colors.black87,
                                        maxLines: 1,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    );
                  }),

                  // New Attachments
                  CustomText(
                      text: "New Attachments (Optional)",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                  SizedBox(height: 8.h),
                  InkWell(
                    onTap: () => controller.pickFiles(),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: CustomText(
                                text: "Choose Files",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Obx(() {
                              final count = controller.pickedFiles.length;
                              return CustomText(
                                text: count == 0
                                    ? "No new file chosen"
                                    : "$count files selected",
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

                  // Picked Files List
                  Obx(() {
                    if (controller.pickedFiles.isEmpty) {
                      return const SizedBox.shrink();
                    }
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
                          final fileName =
                              file.path.split('/').last.split('\\').last;
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
                                  child: Icon(Icons.cancel,
                                      color: Colors.red, size: 16.sp),
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
                                      if (selectedDueDate.value == null ||
                                          selectedDueTime.value == null) {
                                        Get.snackbar("Error",
                                            "Please select both due date and time");
                                        return;
                                      }

                                      // Sync the original class values to
                                      // controller before update call
                                      controller.selectedClassLevel.value =
                                          rawClassLevel;
                                      controller.selectedClassId.value =
                                          rawClassId;

                                      final date = selectedDueDate.value!;
                                      final time = selectedDueTime.value!;
                                      final combinedDateTime = DateTime(
                                        date.year,
                                        date.month,
                                        date.day,
                                        time.hour,
                                        time.minute,
                                      ).toUtc();

                                      final success =
                                          await controller.updateAssignment(
                                        assignmentId:
                                            assignmentData['id']?.toString() ??
                                                "",
                                        title: titleController.text,
                                        type: selectedType.value,
                                        description: descriptionController.text,
                                        dueDate:
                                            combinedDateTime.toIso8601String(),
                                      );

                                      if (success) {
                                        Navigator.pop(context);
                                      }
                                    }
                                  },
                            title: loading ? "Updating..." : "Update Assignment",
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
