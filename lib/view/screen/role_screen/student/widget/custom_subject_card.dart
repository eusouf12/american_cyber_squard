import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';

class CustomSubjectCard extends StatelessWidget {
  const CustomSubjectCard({
    super.key,
    this.title,
    this.img,
    this.teachersName,
    this.teachersEmail,
    this.teachersPhoto,
    this.date,
    this.room,
    this.onTap,
  });

  final String? title;
  final String? img;
  final String? teachersName;
  final String? teachersEmail;
  final String? teachersPhoto;
  final String? date;
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
                color: Colors.black.withValues(alpha: 0.08),
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
                  imageUrl: img ??
                      "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEix0AOrvD4UK_p9a89fLG-99_RFUPWYYDh-qEGH0tNF7u8bgP0a4GdcLBeOrad69NvvbDNj1EELCL9keKngiGQtU018vqakfD6ifQ_6LUNmwv-ugqXhxhXWwbdK8jN8ZVgl0VED1jZfCaoV/s1600/empty.jpg",
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

                    const SizedBox(height: 10),

                    /// Teacher
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12.r,
                          backgroundImage:
                              teachersPhoto != null && teachersPhoto!.isNotEmpty
                                  ? NetworkImage(teachersPhoto!)
                                  : null,
                          child:
                              (teachersPhoto == null || teachersPhoto!.isEmpty)
                                  ? Icon(Icons.person,
                                      size: 14.sp, color: Colors.grey)
                                  : null,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: teachersName ?? "",
                                fontSize: 13.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                              if (teachersEmail != null &&
                                  teachersEmail!.isNotEmpty)
                                CustomText(
                                  text: teachersEmail!,
                                  fontSize: 11.sp,
                                  color: Colors.grey,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    /// Schedule
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.access_time,
                            size: 18, color: Colors.grey),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CustomText(
                            text: date ?? "Mon, Wed, Fri • 09:00 AM",
                            fontSize: 13.sp,
                            color: Colors.grey,
                            maxLines: 10,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    /// Footer
                    CustomText(
                      text: room ?? "Room 101",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
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
