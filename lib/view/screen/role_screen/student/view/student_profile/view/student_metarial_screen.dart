import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/student_profile_controller.dart';
import '../model/resource_list_model.dart';
import '../widgets/resource_list_card.dart';

class StudentMetarialScreen extends StatelessWidget {
  const StudentMetarialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentProfileController controller = Get.find<StudentProfileController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomRoyelAppbar(
        titleName: "Learning Materials",
        leftIcon: true,
      ),
      body: Obx(() {
        if (controller.isMaterialLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.materialFiles.isEmpty) {
          return const Center(
            child: Text("No learning materials found."),
          );
        }

        return ListView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          itemCount: controller.materialFiles.length,
          itemBuilder: (context, index) {
            final ResourceModel item = controller.materialFiles[index];
            return ResourceCard(item: item);
          },
        );
      }),
    );
  }
}
