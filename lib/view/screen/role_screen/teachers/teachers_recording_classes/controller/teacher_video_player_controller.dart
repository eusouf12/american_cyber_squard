import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';

class TeacherVideoPlayerController extends GetxController {
  final String videoUrl;
  TeacherVideoPlayerController({required this.videoUrl});

  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      // Initialize video player from URL
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      await videoPlayerController.initialize();

      // Configure Chewie controller with professional controls
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: false,
        aspectRatio: videoPlayerController.value.aspectRatio,
        allowFullScreen: true,
        fullScreenByDefault: true,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: AppColors.primary,
          handleColor: AppColors.primary,
          bufferedColor: Colors.grey.shade400,
          backgroundColor: Colors.grey.shade700,
        ),
        placeholder: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 42,
                ),
                const SizedBox(height: 10),
                Text(
                  errorMessage.isNotEmpty ? errorMessage : "Could not load video",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        },
      );
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      hasError.value = true;
      debugPrint("VideoPlayerController error: $e");
    }
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    
    // Restore default orientation on back
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.onClose();
  }
}
