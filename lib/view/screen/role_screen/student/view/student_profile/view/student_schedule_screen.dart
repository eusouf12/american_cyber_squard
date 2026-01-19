import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_schedule_card.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // First Card: Free Period
                Expanded(
                  child: CustomScheduleCard(
                    title: "Free Period",
                    breakTime: true,
                    offline: false,
                    online: false,
                    cardColor: Colors.yellow,
                  ),
                ),
                SizedBox(width: 16), // Spacing between cards
                // Second Card: History
                Expanded(
                  child: CustomScheduleCard(
                    title: "History",
                    subtitle: "Mr. Wilson",
                    cardColor: Colors.red,
                    buttonText: "Join Zoom",
                    onPressed: () {},
                    online: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // Space between rows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Third Card: English
                Expanded(
                  child: CustomScheduleCard(
                    title: "English",
                    subtitle: "Ms. Davis",
                    cardColor: Colors.green,
                    buttonText: "Join Zoom",
                    onPressed: () {},
                    online: true,
                  ),
                ),
                SizedBox(width: 16), // Spacing between cards
                // Fourth Card: Science
                Expanded(
                  child: CustomScheduleCard(
                    title: "Science",
                    subtitle: "Mr. Adams",
                    cardColor: Colors.blue,
                    buttonText: "Room 204",
                    onPressed: () {},
                    offline: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // Space between rows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Fifth Card: Math
                Expanded(
                  child: CustomScheduleCard(
                    title: "Math",
                    subtitle: "Ms. Lee",
                    cardColor: Colors.purple,
                    buttonText: "Room 105",
                    onPressed: () {},
                    offline: true,
                  ),
                ),
                SizedBox(width: 16), // Spacing between cards
                // Sixth Card: Art
                Expanded(
                  child: CustomScheduleCard(
                    title: "Art",
                    subtitle: "Mr. Black",
                    cardColor: Colors.orange,
                    buttonText: "Join Zoom",
                    onPressed: () {},
                    online: true,
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
