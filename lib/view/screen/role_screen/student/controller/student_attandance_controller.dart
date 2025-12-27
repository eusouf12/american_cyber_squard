import 'package:get/get.dart';

class StudentAttendanceController extends GetxController {
  RxInt currentIndex = 0.obs;
  final List<String> tabNamelist = ["Weekly", "Monthly", "Calender"];


  final attendancePercent = 0.90.obs;
  final presentDays = 85.obs;
  final totalDays = 100.obs;

  double get progressValue => presentDays.value / totalDays.value;
}
