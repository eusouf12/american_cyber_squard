import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFillTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  //text colors
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  // bg colors
  final Color? backgroundColor;
  final Color? selectedTabColor;

  const CustomFillTabBar({
  super.key,
  required this.tabs,
  required this.selectedIndex,
  required this.onTabSelected,
   this.selectedTextColor,
    this.backgroundColor,
   this.unselectedTextColor,
   this.selectedTabColor,
});

@override
Widget build(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: backgroundColor ?? Colors.grey.withOpacity(0.15),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: List.generate(tabs.length, (index) {
        final bool isSelected = selectedIndex == index;

        return Expanded(
          child: GestureDetector(
            onTap: () => onTabSelected(index),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? selectedTabColor ?? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                tabs[index],
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500,
                  color: isSelected ? selectedTextColor : unselectedTextColor ?? Colors.grey,
                ),
              ),
            ),
          ),
        );
      }),
    ),
  );
}
}
