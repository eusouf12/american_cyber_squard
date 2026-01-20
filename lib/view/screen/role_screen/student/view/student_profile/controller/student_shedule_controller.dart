import 'package:get/get.dart';

class StudentSheduleController extends GetxController {
  // Observable for the selected day
  var selectedDay = "Saturday".obs;

  // List of days
  List<String> days = [
    "Saturday",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday"
  ];
}
