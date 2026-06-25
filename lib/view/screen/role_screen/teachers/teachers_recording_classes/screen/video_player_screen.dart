import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:america_ayber_squad/view/components/custom_loader/custom_loader.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import '../controller/teacher_video_player_controller.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments ?? {};
    final String videoUrl = args['videoUrl'] ?? '';
    final String title = args['title'] ?? 'Recorded Class';

    // Dynamically insert the controller scoped to this specific URL
    final TeacherVideoPlayerController controller = Get.put(
      TeacherVideoPlayerController(videoUrl: videoUrl),
      tag: videoUrl,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CustomLoader(),
          );
        }

        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                const CustomText(
                  text: "Failed to play video. Please try again.",
                  color: Colors.white,
                  fontSize: 14,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                  ),
                  onPressed: () => controller.initializePlayer(),
                  child: const Text("Retry", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        }

        if (controller.chewieController != null) {
          return SafeArea(
            child: Center(
              child: Chewie(
                controller: controller.chewieController!,
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      }),
    );
  }
}
