import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_loader/custom_loader.dart';
import 'package:america_ayber_squad/helper/time_converter/time_converter.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_nav_bar/teacher_nav_bar.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../../../components/custom_text_field/custom_text_field.dart';
import '../controller/recording_class_controller.dart';
import '../widget/custom_teacher_record_card.dart';

class TeachersRecordingClasses extends StatelessWidget {
  const TeachersRecordingClasses({super.key});

  @override
  Widget build(BuildContext context) {
    final RecordingClassController recordingClassController =
        Get.find<RecordingClassController>();
    return CustomGradient(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const CustomTextField(
              fillColor: AppColors.white,
              fieldBorderColor: AppColors.greyLight,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              hintText: "Search Your Recorded class",
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          toolbarHeight: 60,
        ),
        body: SingleChildScrollView(
          controller: recordingClassController.scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add,
                                color: AppColors.white, size: 20),
                            const SizedBox(width: 5),
                            CustomText(
                              text: "Upload Recording",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Obx(() {
                      if (recordingClassController.isRecordingLoading.value &&
                          recordingClassController.recordingList.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: CustomLoader(),
                          ),
                        );
                      }
                      if (recordingClassController.recordingList.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Center(
                            child: CustomText(
                              text: "No recordings found",
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            recordingClassController.recordingList.length + 1,
                        itemBuilder: (context, index) {
                          if (index ==
                              recordingClassController.recordingList.length) {
                            return Obx(() {
                              if (recordingClassController
                                  .isMoreRecordingLoading.value) {
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
                          final recording =
                              recordingClassController.recordingList[index];
                          return CustomTeacherRecordCard(
                            subject: recording
                                    .classDistribution?.assignableSubject ??
                                "No Subject",
                            grade: recording.classDistribution?.classLevel ??
                                "N/A",
                            time: recording.classDistribution?.time ?? "N/A",
                            date: (() {
                              try {
                                if (recording.createdAt != null &&
                                    recording.createdAt!.isNotEmpty) {
                                  return DateConverter.timeFormetString(
                                      recording.createdAt!);
                                }
                              } catch (_) {}
                              return recording.createdAt ?? "N/A";
                            })(),
                            status: "Available",
                            onTapView: () {
                              recordingClassController.launchVideoUrl(recording.recordingUrl);
                            },
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: const TeacherNavBar(currentIndex: 4),
      ),
    );
  }
}
