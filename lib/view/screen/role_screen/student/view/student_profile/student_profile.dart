import 'package:america_ayber_squad/view/components/custom_nav_bar/student_nav_bar.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../widget/custom_profile_card.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        titleName: "Profile",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomNetworkImage(
                  imageUrl: AppConstants.profileImage,
                  height: 80,
                  width: 80,
                  boxShape: BoxShape.circle,
                  border: Border.all(color: Colors.amberAccent, width: 2),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CustomText(
                    text: "Debbendu Paul",
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(width: 16),
            CustomProfileCard(
              nameTitle: "Grade & Exams",
              onTap: () {},
            ),
            CustomProfileCard(
              nameTitle: "Schedule",
              onTap: () {},
            ),
            CustomProfileCard(
              nameTitle: "Support",
              onTap: () {},
            ),
            CustomProfileCard(
              nameTitle: "Materials",
              onTap: () {},
            ),
            CustomProfileCard(
              nameTitle: "Change Password",
              onTap: () {},
            ),
            CustomProfileCard(
              nameTitle: "Edit Profile",
              onTap: () {},
            ),

          ],
        ),
      ),
      bottomNavigationBar: StudentNavBar(currentIndex: 4),
    );
  }
}
