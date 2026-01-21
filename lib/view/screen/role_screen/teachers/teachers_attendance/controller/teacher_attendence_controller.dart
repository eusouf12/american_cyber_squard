import 'package:get/get.dart';

class TeacherAttendanceController extends GetxController {
  RxBool isOpen = false.obs;

  RxString selectedClass = "Mathematics - Grade 10-A".obs;

  final List<String> classList = [
    "Mathematics - Grade 10-A",
    "English - Grade 9-B",
    "Physics - Grade 10-C",
    "Chemistry - Grade 8-A",
  ];

  void toggle() {
    isOpen.value = !isOpen.value;
  }

  void selectClass(String value) {
    selectedClass.value = value;
    isOpen.value = false;
  }

  //attendance sheet
  var studentStatus = <String, String>{}.obs;
  void setStatus(String studentId, String status) {
    studentStatus[studentId] = status;
  }

  /// Button labels
  final List<String> statusList = ["Present", "Absent", "Late"];

  /// -1 = nothing selected
  RxInt selectedIndex = (-1).obs;

  void selectStatus(int index) {
    selectedIndex.value = index;
  }

  bool get isPresent => selectedIndex.value == 0;
  bool get isAbsent => selectedIndex.value == 1;
  bool get isLate => selectedIndex.value == 2;
}

