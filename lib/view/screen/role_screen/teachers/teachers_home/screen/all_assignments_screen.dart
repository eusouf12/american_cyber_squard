import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:america_ayber_squad/view/components/custom_loader/custom_loader.dart';
import '../controller/teachers_controller.dart';
import '../widget/custom_homework_card.dart';
import 'package:america_ayber_squad/helper/time_converter/time_converter.dart';

class AllAssignmentsScreen extends StatefulWidget {
  const AllAssignmentsScreen({super.key});

  @override
  State<AllAssignmentsScreen> createState() => _AllAssignmentsScreenState();
}

class _AllAssignmentsScreenState extends State<AllAssignmentsScreen> {
  final TeachersController teachersController = Get.find<TeachersController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Load fresh assignments when entering this page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      teachersController.getAssignmentHomework();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
        teachersController.getAssignmentHomework(isLoadMore: true);
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
          titleName: "All Assignments",
          leftIcon: true,
        ),
        body: Obx(() {
          if (teachersController.isAssignmentLoading.value && teachersController.assignmentList.isEmpty) {
            return const Center(
              child: CustomLoader(),
            );
          }
          if (teachersController.assignmentList.isEmpty) {
            return Center(
              child: CustomText(
                text: "No assignments found",
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            );
          }
          return ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            itemCount: teachersController.assignmentList.length + 1,
            itemBuilder: (context, index) {
              if (index == teachersController.assignmentList.length) {
                return Obx(() {
                  if (teachersController.isMoreAssignmentLoading.value) {
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
              final assignment = teachersController.assignmentList[index];
              return CustomHomeworkCard(
                subject: assignment.assignmentTitle ?? "No Subject",
                chapter: assignment.assignmentType ?? "N/A",
                grade: assignment.classDistributions?.classLevel ?? "N/A",
                assessmentAvailable: assignment.assessmentAvailable,
                time: (() {
                  try {
                    if (assignment.assignmentDueDate != null && assignment.assignmentDueDate!.isNotEmpty) {
                      return DateConverter.timeFormetString(assignment.assignmentDueDate!);
                    }
                  } catch (_) {}
                  return assignment.assignmentDueDate ?? "N/A";
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
