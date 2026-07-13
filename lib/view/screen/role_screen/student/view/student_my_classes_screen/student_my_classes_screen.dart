import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../service/api_url.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../components/custom_nav_bar/student_nav_bar.dart';
import '../../../../../components/custom_text_field/custom_text_field.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../parents/widget/custom_welcome_card.dart';
import '../../widget/custom_subject_card.dart';
import '../student_profile/controller/student_profile_controller.dart';
import '../student_profile/model/student_schedule_model.dart';

class StudentMyClassesScreen extends StatelessWidget {
  const StudentMyClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentProfileController controller = Get.isRegistered<StudentProfileController>()
        ? Get.find<StudentProfileController>()
        : Get.put(StudentProfileController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.allScheduleList.isEmpty) {
        controller.getStudentSchedule();
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomTextField(
            fillColor: AppColors.white,
            fieldBorderColor: AppColors.greyLight,
            prefixIcon: Icon(
              Icons.search,
              color: AppColors.greyLight,
            ),
            hintText: "Search",
            hintStyle: TextStyle(color: AppColors.greyLight),
            onChanged: (val) {
              controller.getStudentSchedule(subject: val);
            },
          ),
        ),
        toolbarHeight: 120,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Obx(() {
              final count = controller.allScheduleList.length;
              return CustomPrimaryCard(
                title: "My Classes",
                description: "Access your course material and details",
                isInbox: true,
                icon: Icons.assignment,
                inboxTitle: "$count Active Course${count != 1 ? 's' : ''}",
              );
            }),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Obx(() {
                if (controller.isScheduleLoading.value) {
                  return const Center(child: CustomLoader());
                }

                if (controller.allScheduleList.isEmpty) {
                  return const Center(
                    child: CustomText(
                      text: "No classes found",
                      color: Colors.grey,
                    ),
                  );
                }

                // Group classDistributions by assignableSubject + roomNumber + teacher
                final Map<String, List<ClassDistribution>> groupedClasses = {};
                for (var classItem in controller.allScheduleList) {
                  final key = "${classItem.assignableSubject ?? 'N/A'}_${classItem.roomNumber ?? 'N/A'}_${classItem.teacher?.id ?? 'N/A'}";
                  groupedClasses.putIfAbsent(key, () => []).add(classItem);
                }

                final groupedList = groupedClasses.values.toList();

                return ListView.builder(
                  padding: EdgeInsets.only(top: 20.h),
                  itemCount: groupedList.length,
                  itemBuilder: (context, index) {
                    final classGroup = groupedList[index];
                    final firstItem = classGroup.first;
                    
                    // Format multiple Days & Times
                    final schedules = classGroup.map((item) {
                      final d = item.day ?? "";
                      final t = item.time ?? "";
                      return (d.isNotEmpty && t.isNotEmpty) ? "$d • $t" : (d.isNotEmpty ? d : t);
                    }).where((s) => s.isNotEmpty).join("\n");

                    final teacherPhoto = firstItem.teacher?.photo;
                    final profileUrl = teacherPhoto != null && teacherPhoto.isNotEmpty
                        ? (teacherPhoto.startsWith("http") ? teacherPhoto : ApiUrl.imageUrl + teacherPhoto)
                        : null;

                    return CustomSubjectCard(
                      title: firstItem.assignableSubject ?? "N/A",
                      teachersName: firstItem.teacher?.teacherName ?? "N/A",
                      teachersEmail: firstItem.teacher?.email ?? "",
                      teachersPhoto: profileUrl,
                      date: schedules.isNotEmpty ? schedules : "N/A",
                      room: firstItem.roomNumber != null ? "Room ${firstItem.roomNumber}" : "N/A",
                      img: "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?q=80&w=600&auto=format&fit=crop", // static placeholder picture
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: StudentNavBar(currentIndex: 4),
    );
  }
}
