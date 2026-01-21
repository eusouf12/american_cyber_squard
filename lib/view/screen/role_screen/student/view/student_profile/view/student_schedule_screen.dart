import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../../components/custom_text/custom_text.dart';
import '../controller/student_shedule_controller.dart';
import '../widgets/custom_schedule_card.dart';
import '../widgets/custom_time _card.dart';

class StudentScheduleScreen extends StatelessWidget {
  const StudentScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // GetX Controller for day selection
    final StudentSheduleController dayController = Get.put(StudentSheduleController());

    return Scaffold(
      appBar: CustomRoyelAppbar(
        titleName: "Schedule",
        leftIcon: true,
      ),
      body: SingleChildScrollView(  // Make the body scrollable
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Title Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Weekly Timetable",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    Icon(Icons.videocam_outlined, color: Colors.green, size: 20),
                    CustomText(text: "Online", fontSize: 12.sp, color: Colors.grey, left: 5),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: Colors.grey, size: 20),
                    CustomText(text: "Offline", fontSize: 12.sp, color: Colors.grey, left: 5),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Time and Day Row
            Row(
              children: [
                CustomText(text: "Time", fontWeight: FontWeight.w600, fontSize: 14.sp),
                SizedBox(width: 120),
                CustomText(text: "Day", fontWeight: FontWeight.w600, fontSize: 14.sp),
                SizedBox(width: 10),

                // Dropdown for Day selection with different colors
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Obx(() {
                    return DropdownButton<String>(
                      value: dayController.selectedDay.value,
                      icon: Icon(Icons.arrow_drop_down),
                      style: TextStyle(fontSize: 14.sp, color: Colors.black),  // Text color for dropdown
                      onChanged: (String? newValue) {
                        dayController.selectedDay.value = newValue!;
                      },
                      items: dayController.days.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Schedule Cards
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTimeCard(time: "8:45 - 9:30"),
                SizedBox(width: 12),
                Expanded(
                  child: CustomScheduleCard(
                    status: ClassStatus.online,
                    subject: "English",
                    teacher: "Ms. Davis",
                  ),
                ),
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTimeCard(time: "8:45 - 9:30"),
                SizedBox(width: 12),
                Expanded(
                  child: CustomScheduleCard(
                    status: ClassStatus.free,
                    subject: "Free Period",
                  ),
                ),
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTimeCard(time: "8:45 - 9:30"),
                SizedBox(width: 12),
                Expanded(
                  child: CustomScheduleCard(
                    status: ClassStatus.breakTime,
                    subject: "Break",
                  ),
                ),
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTimeCard(time: "8:45 - 9:30"),
                SizedBox(width: 12),
                Expanded(
                  child: CustomScheduleCard(
                    status: ClassStatus.offline,
                    subject: "History",
                    teacher: "Mr. Wilson",
                    room: "Room 105",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
