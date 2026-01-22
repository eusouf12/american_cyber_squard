import 'package:america_ayber_squad/view/screen/role_screen/student/view/student_attendance/student_attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_icons/app_icons.dart';
import '../../screen/role_screen/student/view/student_assignment/student_assignment_screen.dart';
import '../../screen/role_screen/student/view/student_home/student_home_screen.dart';
import '../../screen/role_screen/student/view/student_my_classes_screen/student_my_classes_screen.dart';
import '../../screen/role_screen/student/view/student_profile/view/student_profile.dart';


class StudentNavBar extends StatefulWidget {
  final int currentIndex;

  const StudentNavBar({required this.currentIndex, super.key});

  @override
  State<StudentNavBar> createState() => _UserNavBarState();
}

class _UserNavBarState extends State<StudentNavBar> {
  late int bottomNavIndex;

  final List<String> icons = [
    AppIcons.home,
    AppIcons.myClass,
    AppIcons.assignments,
    AppIcons.student,
    AppIcons.profile,

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
          Get.offAll(() => StudentHomeScreen());
          break;
        case 1:
          Get.offAll(() => StudentAttendanceScreen());
          break;
        case 2:
          Get.offAll(() => StudentAssignmentScreen());
          break;
        case 3:
          Get.offAll(() => StudentMyClassesScreen());
          break;
        case 4:
          Get.to(() => StudentProfile());
          break;
      }
    }
  }
}













//
//
// class RoleBasedScreen extends StatelessWidget {
//   final Widget child;
//   final int navIndex;
//   // final String role; // propertyOwner, provider, guest
//   final PreferredSizeWidget? appBar;
//
//   const RoleBasedScreen({
//     required this.child,
//     required this.navIndex,
//     // required this.role,
//     this.appBar,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final authController = Get.find<AuthController>();
//     // final String currentRole = authController.selectedRole.value;
//     return WillPopScope(
//       onWillPop: () async {
//         if (navIndex != 0) {
//           _navigateToHome(authController.selectedRole.value);
//           return false;
//         }
//         return true;
//       },
//       child: Scaffold(
//         appBar: appBar,
//         body: child,
//         bottomNavigationBar: NavBar(currentIndex: navIndex),
//       ),
//     );
//   }
//
//   void _navigateToHome(String role) {
//     print("Navigating Back based on Role: $role");
//     switch (role) {
//       case 'propertyOwner':
//         Get.offAll(() => PropertyOwnerHomeScreen());
//         break;
//       case 'serviceProvider':
//         Get.offAll(() => ServiceProviderHomeScreen());
//         break;
//       case 'guest':
//         Get.offAll(() => GuestHomeScreen());
//         break;
//       default:
//         Get.offAll(() => PropertyOwnerHomeScreen());
//     }
//   }
// }
