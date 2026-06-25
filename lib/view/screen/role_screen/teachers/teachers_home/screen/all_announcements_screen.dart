import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:america_ayber_squad/view/components/custom_loader/custom_loader.dart';
import '../controller/teachers_controller.dart';
import '../widget/custom_announcement_card.dart';
import 'package:america_ayber_squad/helper/time_converter/time_converter.dart';

class AllAnnouncementsScreen extends StatelessWidget {
  AllAnnouncementsScreen({super.key});

  final TeachersController teachersController = Get.find<TeachersController>();

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: const CustomRoyelAppbar(
          titleName: "Announcements",
          leftIcon: true,
        ),
        body: Obx(() {
          if (teachersController.isAnnouncementLoading.value && teachersController.announcementList.isEmpty) {
            return const Center(
              child: CustomLoader(),
            );
          }
          if (teachersController.announcementList.isEmpty) {
            return Center(
              child: CustomText(
                text: "No announcements found",
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            );
          }
          return ListView.builder(
            controller: teachersController.announcementScrollController,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            itemCount: teachersController.announcementList.length + 1,
            itemBuilder: (context, index) {
              if (index == teachersController.announcementList.length) {
                return Obx(() {
                  if (teachersController.isMoreAnnouncementLoading.value) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: CustomLoader(),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                });
              }
              final announcement = teachersController.announcementList[index];
              return CustomAnnouncementCard(
                title: announcement.title ?? "No Title",
                content: announcement.description ?? "No Content",
                date: (() {
                  try {
                    if (announcement.createdAt != null && announcement.createdAt!.isNotEmpty) {
                      return DateConverter.timeFormetString(announcement.createdAt!);
                    }
                  } catch (_) {}
                  return announcement.createdAt ?? "N/A";
                })(),
                onTap: () {},
              );
            },
          );
        }),
      ),
    );
  }
}
