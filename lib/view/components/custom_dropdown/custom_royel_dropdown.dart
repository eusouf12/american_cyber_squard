import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors/app_colors.dart';
import '../custom_Controller/custom_controller.dart';
import '../custom_text/custom_text.dart';

class CustomRoyelDropdown extends StatelessWidget {
  final double height;
  final double? width;
  final Color? fillColor;
  final Color textColor;
  final String title;
  final String hintText;
  final double marginVertical;
  final double marginHorizontal;
  final bool isBorder;
  final double? fontSize;
  final double? borderWidth;
  final double? borderRadius;


  CustomRoyelDropdown({
    this.height = 55,
    this.width = double.maxFinite,
    this.title = '',
    this.hintText = '',
    this.marginVertical = 0,
    this.marginHorizontal = 0,
    this.fillColor = AppColors.white,
    this.textColor = AppColors.black,
    this.isBorder = false,
    this.fontSize,
    this.borderWidth,
    this.borderRadius,
    super.key});
  final CustomController customController = Get.find<CustomController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            fontSize: 14.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 8.h),
          Container(
            alignment: Alignment.center,
            height: height,
            width: width,
            padding: EdgeInsets.only(left: 10.w),
            decoration: BoxDecoration(
              border: isBorder
                  ? Border.all(color: textColor, width: borderWidth ?? .2)
                  : null,
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              color: fillColor,
            ),
            child: DropdownButton<String>(
              padding: EdgeInsets.only(right: 20),
              hint: CustomText(
                  text: hintText,
                  fontSize: fontSize ?? 12.sp,
                  color: Colors.grey.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                  right: 15.w,
              ),
              borderRadius: BorderRadius.circular(10),
              elevation: 2,
              dropdownColor: AppColors.white,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.grey_03,
              ),
              iconSize: 25,
              underline: const SizedBox(),
              isExpanded: true, // This makes the dropdown full-width
              style:  GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 12.w,
              ),
             // value: customController.cetagoryList.value,
              onChanged: (String? newValue) {
                //customController.currentCetagory.value = newValue!;
              },
              items: customController.cetagoryList.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: CustomText(
                    text: item,
                    color: AppColors.black,
                    fontSize: 15.w,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      );
    });
  }
}
