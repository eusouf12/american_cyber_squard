import 'package:get/get.dart';

class TeachersMaterialController extends GetxController {
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

}

