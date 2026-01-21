import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_icons/app_icons.dart';
import '../../screen/role_screen/school_nurse/view/immunization/view/school_nurse_immunization_screen.dart';
import '../../screen/role_screen/school_nurse/view/school_nurse_communication/view/school_nurse_communication_screen.dart';
import '../../screen/role_screen/school_nurse/view/school_nurse_health/view/school_nurse_health_screen.dart';
import '../../screen/role_screen/school_nurse/view/school_nurse_home/view/school_nurse_home_screen.dart';
import '../../screen/role_screen/school_nurse/view/school_nurse_profile/view/school_nurse_profile_screen.dart';


class SchoolNurseNavBar extends StatefulWidget {
  final int currentIndex;

  const SchoolNurseNavBar({required this.currentIndex, super.key});

  @override
  State<SchoolNurseNavBar> createState() => _UserNavBarState();
}

class _UserNavBarState extends State<SchoolNurseNavBar> {
  late int bottomNavIndex;

  final List<String> icons = [
    AppIcons.home,
    AppIcons.attendance,
    AppIcons.assignments,
    AppIcons.assignments,
    AppIcons.attendance,

  ];

  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
          border: Border.all(color: AppColors.grey_03, width: .2),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey,
          //     spreadRadius: 1,
          //     blurRadius: 0,
          //     offset: const Offset(3, 0),
          //   ),
          // ],
        ),
        height: 80.h,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            icons.length,
                (index) => InkWell(
              onTap: () => onTap(index),
              borderRadius: BorderRadius.circular(20.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 13.h),
                  Container(
                    height: 47.62.h,
                    width: 47.62.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20.r),
                      gradient: index == bottomNavIndex
                          ? const LinearGradient(
                        colors: [
                          AppColors.primary,
                          Color(0xFFC8E6C9),
                        ],
                        begin: Alignment.centerRight,
                        end: Alignment.bottomRight,
                      )
                          : null,
                      color: index == bottomNavIndex ? null : Colors.transparent,
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      icons[index],
                      height: 25.h,
                      width: 25.w,
                      colorFilter: ColorFilter.mode(
                        index == bottomNavIndex ? Colors.black : const Color(0xFFD2D2D2),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTap(int index) {
    if (index != bottomNavIndex) {
      setState(() {
        bottomNavIndex = index;
      });

      switch (index) {
        case 0:
          Get.offAll(() => SchoolNurseHomeScreen());
          break;
        case 1:
          Get.offAll(() => SchoolNurseHealthScreen());
          break;
        case 2:
          Get.offAll(() => SchoolNurseImmunizationScreen());
          break;
        case 3:
          Get.offAll(() => SchoolNurseCommunicationScreen());
          break;
        case 4:
          Get.to(() => SchoolNurseProfileScreen());
          break;
      }
    }
  }
}
