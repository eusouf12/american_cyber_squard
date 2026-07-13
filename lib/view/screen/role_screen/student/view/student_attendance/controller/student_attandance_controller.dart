import 'dart:convert';
import 'package:get/get.dart';
import 'package:america_ayber_squad/service/api_client.dart';
import 'package:america_ayber_squad/service/api_url.dart';
import 'package:america_ayber_squad/utils/app_const/app_const.dart';
import 'package:america_ayber_squad/view/screen/role_screen/student/view/student_attendance/model/attendence_history.dart';

class StudentAttendanceController extends GetxController {
  var currentIndex = 0.obs;
  final List<String> tabNamelist = ["Weekly", "Monthly", "Calender"];

  void changeTab(int index){
    currentIndex.value = index;
  }

  RxBool isHistoryLoading = true.obs;
  Rx<Status> rxHistoryStatus = Status.loading.obs;

  Rxn<AttendanceStatistics> statistics = Rxn<AttendanceStatistics>();
  RxList<AttendanceHistoryList> historyList = <AttendanceHistoryList>[].obs;

  @override
  void onInit() {
    super.onInit();
    getStudentAttendanceHistory();
  }

  Future<void> getStudentAttendanceHistory() async {
    isHistoryLoading.value = true;
    rxHistoryStatus.value = Status.loading;

    try {
      final response = await ApiClient.getData(ApiUrl.attendencehistory);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);

        final historyResponse = StudentAttendanceHistoryResponse.fromJson(jsonResponse);
        
        if (historyResponse.success == true && historyResponse.data != null) {
          statistics.value = historyResponse.data?.statistics;
          if (historyResponse.data?.data != null) {
            historyList.value = historyResponse.data!.data!;
          } else {
            historyList.clear();
          }
          rxHistoryStatus.value = Status.completed;
        } else {
          rxHistoryStatus.value = Status.error;
        }
      } else {
        rxHistoryStatus.value = Status.error;
      }
    } catch (e) {
      rxHistoryStatus.value = Status.error;
    } finally {
      isHistoryLoading.value = false;
    }
  }
}
