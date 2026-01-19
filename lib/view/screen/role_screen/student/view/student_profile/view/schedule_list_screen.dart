import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';

import '../model/resource_list_model.dart';
import '../widgets/resource_list_card.dart';
class ResourceListScreen extends StatelessWidget {


  const ResourceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ResourceModel> resources = [
      ResourceModel(
        fileName: "Mathematics Formula Sheet",
        size: "1.2 MB",
        subject: "Mathematics",
        type: "PDF",
        date: "Dec 01, 2024",
        icon: Icons.description_outlined,
        color: Colors.green,
      ),
      ResourceModel(
        fileName: "Physics Lecture: Newton's Laws",
        size: "450 MB",
        subject: "Physics",
        type: "Video",
        date: "Nov 28, 2024",
        icon: Icons.videocam_outlined,
        color: Colors.teal,
      ),
      ResourceModel(
        fileName: "Chemistry Lab Safety Guidelines",
        size: "800 KB",
        subject: "Chemistry",
        type: "PDF",
        date: "Sep 15, 2024",
        icon: Icons.description_outlined,
        color: Colors.green,
      ),
      ResourceModel(
        fileName: "Shakespeare's Works Archive",
        size: "N/A",
        subject: "English",
        type: "Link",
        date: "Oct 10, 2024",
        icon: Icons.link,
        color: Colors.blue,
      ),
      ResourceModel(
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
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(vertical:20, horizontal: 20 ),
        itemCount: resources.length,
        itemBuilder: (context, index) {
          final item = resources[index];
          return ResourceCard(item: item);
        },
      ),
    );
  }
}