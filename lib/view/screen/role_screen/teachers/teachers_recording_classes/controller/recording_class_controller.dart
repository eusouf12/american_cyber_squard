import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:america_ayber_squad/helper/shared_prefe/shared_prefe.dart';
import 'package:america_ayber_squad/service/api_client.dart';
import 'package:america_ayber_squad/service/api_url.dart';
import 'package:america_ayber_squad/utils/ToastMsg/toast_message.dart';
import 'package:america_ayber_squad/utils/app_const/app_const.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/record_class.dart';

class RecordingClassController extends GetxController {
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _checkTokenAndLoadData();
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100) {
      getClassRecording(isLoadMore: true);
    }
  }

  RxList<ClassRecordingModel> recordingList = <ClassRecordingModel>[].obs;
  RxBool isRecordingLoading = false.obs;
  RxBool isMoreRecordingLoading = false.obs;
  Rx<Status> rxRecordingStatus = Status.loading.obs;
  var recordingPage = 1.obs;
  var hasMoreRecordings = true.obs;

  Future<void> _checkTokenAndLoadData() async {
    String token = await SharePrefsHelper.getString(AppConstants.bearerToken);
    if (token.isNotEmpty) {
      getClassRecording();
    }
  }

  Future<void> getClassRecording({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (isMoreRecordingLoading.value || !hasMoreRecordings.value) return;
      isMoreRecordingLoading.value = true;
      recordingPage.value++;
    } else {
      isRecordingLoading.value = true;
      rxRecordingStatus.value = Status.loading;
      recordingPage.value = 1;
      hasMoreRecordings.value = true;
    }

    try {
      final response = await ApiClient.getData(ApiUrl.getClassRecording(page: recordingPage.value));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);
        final ClassRecordingResponse model = ClassRecordingResponse.fromJson(jsonResponse);

        if (model.data != null && model.data!.data != null) {
          if (isLoadMore) {
            recordingList.addAll(model.data!.data!);
          } else {
            recordingList.value = model.data!.data!;
          }

          if (model.data!.data!.isEmpty ||
              (model.data!.meta != null && model.data!.meta!.totalPage != null && recordingPage.value >= model.data!.meta!.totalPage!)) {
            hasMoreRecordings.value = false;
          }
        } else {
          hasMoreRecordings.value = false;
        }

        rxRecordingStatus.value = Status.completed;
      } else {
        rxRecordingStatus.value = Status.error;
        final Map<String, dynamic> errorResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body ?? {});
        showCustomSnackBar(
          errorResponse['message']?.toString() ?? 'Failed to load recordings',
          isError: true,
        );
      }
    } catch (e) {
      rxRecordingStatus.value = Status.error;
      debugPrint('getClassRecording Error: $e');
      showCustomSnackBar('Error: ${e.toString()}', isError: true);
    } finally {
      if (isLoadMore) {
        isMoreRecordingLoading.value = false;
      } else {
        isRecordingLoading.value = false;
      }
    }
  }

  Future<void> launchVideoUrl(String? urlString) async {
    // For now, always use the static Zoom recording link provided for testing.
    //  if (urlToLaunch.isEmpty || 
    //     !urlToLaunch.startsWith("http") || 
    //     urlToLaunch.contains("youtube.com") || 
    //     urlToLaunch.contains("zoom.us/j/")) {
    //   urlToLaunch = "https://fiverrzoom.zoom.us/rec/play/85WewhA7-2aF7-EbMT08KddU6zFLfBOTo76KO5qFf5VMp72CeWsjmBbCEjBqIoP5FmL0ll9_RByHjrN9.5lQ_7ZqFa_Fw-Yi6";
    // }
    // Later, you can change this back to: String urlToLaunch = urlString ?? "";
    const String urlToLaunch = "https://fiverrzoom.zoom.us/rec/play/85WewhA7-2aF7-EbMT08KddU6zFLfBOTo76KO5qFf5VMp72CeWsjmBbCEjBqIoP5FmL0ll9_RByHjrN9.5lQ_7ZqFa_Fw-Yi6";

    try {
      final Uri uri = Uri.parse(urlToLaunch);
      final bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        showCustomSnackBar("Could not open link: $urlToLaunch", isError: true);
      }
    } catch (e) {
      debugPrint("Error launching url: $e");
      showCustomSnackBar("Failed to launch browser", isError: true);
    }
  }
}
