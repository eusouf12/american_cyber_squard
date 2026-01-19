import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';

class CustomSubjectCard extends StatelessWidget {
  const CustomSubjectCard({
    super.key,
    this.title,
    this.img,
    this.teachersName,
    this.date,
    this.onTap,
  });

  final String? title;
  final String? img;
  final String? teachersName;
  final String? date;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(bottom: 8),
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomNetworkImage(
                imageUrl: img ?? AppConstants.ntrition1,
                height: 300,
                width: MediaQuery.sizeOf(context).width,
                borderRadius: BorderRadius.circular(15),
              ),

              SizedBox(height: 10.h),

              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                child: CustomText(
                  text: title ?? "",
                  textAlign: TextAlign.start,
                  fontSize: 18.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.person, size: 18),
                    CustomText(
                      left: 10.w,
                      text: teachersName ?? "Dr. Sarah",
                      fontSize: 14.w,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),

              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.lock_clock, size: 18),
                    CustomText(
                      left: 10.w,
                      text: date ?? "Mon, Wed, Fri . 09:00 AM",
                      fontSize: 14.w,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
