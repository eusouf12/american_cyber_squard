import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:america_ayber_squad/view/components/custom_button/custom_button.dart';
import 'package:america_ayber_squad/view/components/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:get/get.dart';

void showCreateAssignmentPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
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
                CustomText(text: "Assignment Title",fontSize: 14.sp, fontWeight: FontWeight.w600),
                SizedBox(height: 10.h),
                CustomTextField(
                    hintText: "e.g., Algebra Homework - Chapter 5",
                ),
                SizedBox(height: 10.h),

                // Class and Type Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: "Class",fontSize: 14.sp, fontWeight: FontWeight.w600),
                          _buildDropdownField(
                            hint: "Select class",
                            items: ["Grade 9-A", "Grade 10-A", "Grade 11-A", "Grade 11-B", "Grade 12-A"],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: "Type",fontSize: 14.sp, fontWeight: FontWeight.w600),
                          _buildDropdownField(
                            hint: "Select type",
                            items: ["Homework", "Practice", "Project", "Quiz Prep"],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Due Date
                CustomText(text: "Due Date",fontSize: 14.sp, fontWeight: FontWeight.w600),
                SizedBox(height: 10.h),
                CustomTextField(
                  hintText: "mm/dd/yyyy",
                ),
                SizedBox(height: 10.h),
                // Description
                CustomText(text: "Description",fontSize: 14.sp, fontWeight: FontWeight.w600),
                SizedBox(height: 10.h),
                CustomTextField(
                  hintText: "Enter assignment description and instructions...",
                  maxLines: 4,
                ),
                SizedBox(height: 10.h),

                // Attachments
                CustomText(text: "Attachments (Optional)",fontSize: 14.sp, fontWeight: FontWeight.w600),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
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
                      CustomText(text: "No file chosen", fontSize: 12.sp, color: Colors.grey),
                    ],
                  ),
                ),
                SizedBox(height: 25.h),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: CustomButton(onTap:(){
                        Get.back();
                      },
                        title:"Cancel",
                        fontSize: 12,
                        textColor: AppColors.black,
                        fillColor: AppColors.white,
                        borderColor: AppColors.primary,
                        isBorder: true,

                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: CustomButton(onTap:(){
                        Get.back();
                      },
                        title:"Create Assignment",
                        fontSize: 12,
                        textColor: AppColors.white,
                        fillColor: AppColors.primary,

                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}



Widget _buildDropdownField({required String hint, required List<String> items}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        hint: Text(hint, style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade400)),
        isExpanded: true,
        icon: Icon(Icons.keyboard_arrow_down, size: 20.sp, color: Colors.grey),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: TextStyle(fontSize: 14.sp)),
          );
        }).toList(),
        onChanged: (_) {},
      ),
    ),
  );
}