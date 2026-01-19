import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../../utils/app_const/app_const.dart';
import '../../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../../components/custom_text/custom_text.dart';

class CustomMessageList extends StatelessWidget {
  const CustomMessageList({
    super.key,
    this.icon1,
    this.icon2,
    this.img,
    this.title,
    this.subtitle,
    this.time,
  });

  final String? img;
  final String? title;
  final String? subtitle;
  final String? time;
  final Icon? icon1;
  final Icon? icon2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: .8),
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left part: image + text
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomNetworkImage(
                        imageUrl: img ?? AppConstants.profileImage,
                        height: 50.h,
                        width: 50.w,
                        boxShape: BoxShape.circle,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: title ?? " ",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 4),
                            CustomText(
                              text: subtitle ?? " ",
                              fontSize: 14,
                              color: AppColors.black_02,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Right part: time + icon
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomText(
                      text: time ?? '',
                      fontSize: 14,
                    ),
                    icon1 ?? SizedBox(),
                  ],
                ),
              ],
            )

        ),
      ),
    );
  }
}