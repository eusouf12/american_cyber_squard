import 'package:get/get.dart';

class TabControllerX extends GetxController {
  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  List<int> getAttendanceData() {
    // Example data (replace with actual data logic)
    return [8, 7, 8, 7, 8, 7, 8]; // Attendance values for Mon-Sun
  }

  // This method can return the percentage of attendance
  String getAttendancePercentage() {
    return "92%"; // Example data (you can replace with actual logic)
  }

}
