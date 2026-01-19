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
    this.subTitle,
    this.img,
    this.teachersName,
    this.date,
    this.progress,
    this.room,
    this.onTap,
  });

  final String? title;
  final String? subTitle;
  final String? img;
  final String? teachersName;
  final String? date;
  final double? progress;
  final String? room;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 Top Image
              ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
                child: CustomNetworkImage(
                  imageUrl: img ?? "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEix0AOrvD4UK_p9a89fLG-99_RFUPWYYDh-qEGH0tNF7u8bgP0a4GdcLBeOrad69NvvbDNj1EELCL9keKngiGQtU018vqakfD6ifQ_6LUNmwv-ugqXhxhXWwbdK8jN8ZVgl0VED1jZfCaoV/s1600/empty.jpg",
                  height: 150,
                  width: double.infinity,
                ),
              ),

              /// 🔹 Content
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title
                    CustomText(
                      text: title ?? "Advanced Mathematics",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                    CustomText(
                      top: 5,
                      text: subTitle ?? "MAT-101",
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.7),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 10),

                    /// Teacher
                    Row(
                      children: [
                        const Icon(Icons.person_outline,
                            size: 18, color: Colors.grey),
                        const SizedBox(width: 8),
                        CustomText(
                          text: teachersName ?? "Dr. Sarah Johnson",
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    /// Schedule
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 18, color: Colors.grey),
                        const SizedBox(width: 8),
                        CustomText(
                          text: date ?? "Mon, Wed, Fri • 09:00 AM",
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    /// Progress label
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          text: "Progress",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        CustomText(
                          text: "${((progress ?? 0.75) * 100).toInt()}%",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    /// Progress bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress ?? 0.75,
                        minHeight: 6,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.green,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    /// Footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: room ?? "Room 101",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        const Icon(Icons.more_vert,
                            color: Colors.grey),
                      ],
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

