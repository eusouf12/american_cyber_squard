import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_schedule_card.dart';
import '../widgets/custom_time _card.dart';

class StudentScheduleScreen extends StatelessWidget {
  const StudentScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        titleName: "Schedule",
        leftIcon: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            //title
             Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title
            CustomText(text: "Weekly Timetable",fontSize: 16.sp,fontWeight: FontWeight.w600,color: Colors.black,),
            Row(
              children: [
                Icon(Icons.videocam_outlined,color: Colors.green,size: 20,),
                CustomText(text: "Online",fontSize: 12.sp,color: Colors.grey,left: 5,),
              ],
            ),
            Row(
              children: [
                Icon(Icons.location_on_outlined,color: Colors.grey,size: 20,),
                CustomText(text: "Offline",fontSize: 12.sp,color: Colors.grey,left: 5,),
              ],
            ),
          ],
        ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTimeCard(
                  time: "8:45 - 9:30",
                ),
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
            //
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTimeCard(
                  time: "8:45 - 9:30",
                ),
                SizedBox(width: 12),
                Expanded(
                  child: CustomScheduleCard(
                    status: ClassStatus.free,
                    subject: "Free Period",
                  ),
                ),
              ],
            ),
            //
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTimeCard(
                  time: "8:45 - 9:30",
                ),
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
                CustomTimeCard(
                  time: "8:45 - 9:30",
                ),
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
