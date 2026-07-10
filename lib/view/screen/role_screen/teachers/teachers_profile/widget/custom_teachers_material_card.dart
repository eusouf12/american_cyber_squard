import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:america_ayber_squad/view/components/custom_button/custom_button.dart';
import '../model/metarial.dart';
import '../controller/teachers_material_controller.dart';
import '../view/material_details_screen.dart';
import '../view/edit_material_screen.dart';

class CustomTeachersMaterialCard extends StatelessWidget {
  final MaterialItem item;

  CustomTeachersMaterialCard({super.key, required this.item});

  final TeachersMaterialController controller = Get.find<TeachersMaterialController>();

  /// 🔹 type → icon mapper
  IconData _getIconByType(String? type) {
    switch (type?.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'video':
        return Icons.play_circle_fill;
      case 'audio':
        return Icons.audiotrack;
      case 'doc':
      case 'file':
        return Icons.insert_drive_file;
      case 'link':
        return Icons.link;
      default:
        return Icons.bookmark_outline;
    }
  }

  /// 🔹 type → color mapper
  Color _getColorByType(String? type) {
    switch (type?.toLowerCase()) {
      case 'pdf':
        return Colors.redAccent;
      case 'video':
        return Colors.deepPurple;
      case 'audio':
        return Colors.orange;
      case 'doc':
      case 'file':
        return Colors.blueGrey;
      case 'link':
        return Colors.blue;
      default:
        return Colors.teal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final IconData iconData = _getIconByType(item.materialType);
    final Color iconColor = _getColorByType(item.materialType);

    final String filesCount = item.materialFiles != null && item.materialFiles!.isNotEmpty
        ? "${item.materialFiles!.length} files attached"
        : "No files";

    final String dateString = item.createdAt != null
        ? DateFormat('MM/dd/yyyy').format(item.createdAt!)
        : "N/A";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Left icon (type based)
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  iconData,
                  color: iconColor,
                  size: 28,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.assignmentTitle ?? "No Title",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3436),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      filesCount,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item.classDistributions?.classLevel ?? "N/A",
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          dateString,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onTap: () {
                    Get.to(() => MaterialDetailsScreen(
                          materialId: item.id ?? "",
                          assignmentTitle: item.assignmentTitle,
                          classLevel: item.classDistributions?.classLevel,
                        ));
                  },
                  title: "View Details",
                  fontSize: 9.sp,
                  height: 30.h,
                  width: 90.w,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: CustomButton(
                  onTap: () {
                    Get.to(() => EditMaterialScreen(material: item));
                  },
                  title: "Edit",
                  fontSize: 9.sp,
                  height: 30.h,
                  width: 90.w,
                  fillColor: Colors.grey.withValues(alpha: 0.4),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: CustomButton(
                  onTap: () {
                    Get.dialog(
                      AlertDialog(
                        title: const Text("Delete Material"),
                        content: const Text("Are you sure you want to delete this class material?"),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back();
                              controller.deleteMaterial(item.id ?? "");
                            },
                            child: const Text("Delete", style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                  title: "Delete",
                  fontSize: 9.sp,
                  height: 30.h,
                  width: 90.w,
                  fillColor: Colors.red.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
