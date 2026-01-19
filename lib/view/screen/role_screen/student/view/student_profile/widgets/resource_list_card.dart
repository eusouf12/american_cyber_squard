import 'package:flutter/material.dart';
import '../model/resource_list_model.dart';

class ResourceCard extends StatelessWidget {
  final ResourceModel item;

  const ResourceCard({super.key, required this.item});

  /// 🔹 type → icon mapper
  IconData _getIconByType(String type) {
    switch (type.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'video':
        return Icons.play_circle_fill;
      case 'audio':
        return Icons.audiotrack;
      case 'file':
        return Icons.insert_drive_file;
      case 'link':
        return Icons.link;
      case 'zip':
        return Icons.folder_zip;
      case 'sheet':
        return Icons.grid_on;
      case 'picture':
        return Icons.image;
      default:
        return item.icon;
    }
  }

  /// 🔹 type → color mapper
  Color _getColorByType(String type) {
    switch (type.toLowerCase()) {
      case 'pdf':
        return Colors.redAccent;
      case 'video':
        return Colors.deepPurple;
      case 'audio':
        return Colors.orange;
      case 'file':
        return Colors.blueGrey;
      case 'link':
        return Colors.blue;
      case 'zip':
        return Colors.brown;
      case 'sheet':
        return Colors.green;
      case 'picture':
        return Colors.pink;
      default:
        return item.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    final IconData iconData = _getIconByType(item.type);
    final Color iconColor = _getColorByType(item.type);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ✅ Left icon (type based)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
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
                  item.fileName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3436),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.size,
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
                        item.subject,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      item.date,
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

          IconButton(
            onPressed: () {
              print("Downloading ${item.fileName}");
            },
            icon: const Icon(Icons.download_for_offline_outlined),
            color: const Color(0xFF2ECC71),
            iconSize: 28,
          ),
        ],
      ),
    );
  }
}
