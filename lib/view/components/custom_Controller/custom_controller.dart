import 'package:get/get.dart';

class CustomController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxList<String> cetagoryList = [
    "Health issue",
    "Relative Resaption",
    "Break",
    "Weekend",
  ].obs;

  // RxList<String> specializationList = [
  //   "Cardiology",
  //   "Neurology",
  //   "Urology"
  // ].obs;
}