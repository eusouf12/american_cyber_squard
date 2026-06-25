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

class AllAnnouncementsScreen extends StatefulWidget {
  const AllAnnouncementsScreen({super.key});

  @override
  State<AllAnnouncementsScreen> createState() => _AllAnnouncementsScreenState();
}

class _AllAnnouncementsScreenState extends State<AllAnnouncementsScreen> {
  final TeachersController teachersController = Get.find<TeachersController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Load fresh announcements when entering this page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      teachersController.getAnnouncement();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
        teachersController.getAnnouncement(isLoadMore: true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
            controller: _scrollController,
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
