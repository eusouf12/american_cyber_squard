import 'package:get/get.dart';

class StudentAttendanceController extends GetxController {
  var currentIndex = 0.obs;
  final List<String> tabNamelist = ["Weekly", "Monthly", "Calender"];

  void changeTab(int index){
    currentIndex.value = index;
  }


  final attendancePercent = 0.90.obs;
  final presentDays = 85.obs;
  final totalDays = 100.obs;

  double get progressValue => presentDays.value / totalDays.value;
}
