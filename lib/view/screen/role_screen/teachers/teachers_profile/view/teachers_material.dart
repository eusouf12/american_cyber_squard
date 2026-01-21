import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../model/teachers_resource_model.dart';
import '../widget/custom_teachers_material_card.dart';

class TeachersMaterial extends StatelessWidget {
  const TeachersMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TeachersResourceModel> resources = [
      TeachersResourceModel(
        fileName: "Mathematics Formula Sheet",
        size: "1.2 MB",
        subject: "Mathematics",
        type: "PDF",
        date: "Dec 01, 2024",
        icon: Icons.description_outlined,
        color: Colors.green,
      ),
      TeachersResourceModel(
        fileName: "Physics Lecture: Newton's Laws",
        size: "450 MB",
        subject: "Physics",
        type: "Video",
        date: "Nov 28, 2024",
        icon: Icons.videocam_outlined,
        color: Colors.teal,
      ),
      TeachersResourceModel(
        fileName: "Chemistry Lab Safety Guidelines",
        size: "800 KB",
        subject: "Chemistry",
        type: "PDF",
        date: "Sep 15, 2024",
        icon: Icons.description_outlined,
        color: Colors.green,
      ),
      TeachersResourceModel(
        fileName: "Shakespeare's Works Archive",
        size: "N/A",
        subject: "English",
        type: "Link",
        date: "Oct 10, 2024",
        icon: Icons.link,
        color: Colors.blue,
      ),
      TeachersResourceModel(
        fileName: "Programming Basics 101",
        size: "15 MB",
        subject: "Computer Science",
        type: "ZIP",
        date: "Nov 05, 2024",
        icon: Icons.folder_open_outlined,
        color: Colors.orange,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomRoyelAppbar(
        titleName: "Learning Materials",
        leftIcon: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            //Card View

            //Course material
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(text: "Course Materials", fontSize: 16, fontWeight: FontWeight.w600),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.add, size: 18, color: Colors.white,),
                              CustomText(text: "Add New Materials", fontSize: 12, left: 5, color: Colors.white, fontWeight: FontWeight.w500),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                    SizedBox(height: 10,),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                        final item = resources[index];
                        return CustomTeachersMaterialCard(item: item);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}