import 'package:get/get.dart';

class TeacherCreateController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
  //progress bar
  final RxInt progress = 0.obs;
}