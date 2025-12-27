import 'package:flutter/material.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_text/custom_text.dart';

class CustomAttendanceTabbar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final Color selectedColor;
  final Color? textColor;
  final bool? isTextColorActive;
  final bool? isPadding;

  const CustomAttendanceTabbar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.selectedColor,
    this.textColor,
    this.isTextColorActive = false,
    this.isPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // 🔹 Outer Container added
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.grey_03, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(tabs.length, (index) {
          return GestureDetector(
            onTap: () => onTabSelected(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: selectedIndex == index ? selectedColor : AppColors.white,
              ),
              child: CustomText(
                text: tabs[index],
                color: selectedIndex == index ? AppColors.white : AppColors.black_80,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }),
      ),
    );
  }
}
