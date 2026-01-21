import 'package:america_ayber_squad/view/components/custom_button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../utils/app_colors/app_colors.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';

class CustomScheduleScriningCard extends StatelessWidget {
  final String? screeningName;
  final String? grade;
  final String? date;
  final String? status;
  final VoidCallback? onTap;

  const CustomScheduleScriningCard({
    super.key,
    this.screeningName,
    this.grade,
    this.status,
    this.onTap,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.greyLight.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.09),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Student info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: screeningName ?? "",
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: grade ?? "",
                    fontSize: 12.sp,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: status == "Upcoming"
                          ? Colors.blue.withOpacity(0.2)
                          : Colors.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        CustomText(
                          text: status ?? "",
                          color: status == "Upcoming"
                              ? Color(0xFF2563EB)
                              : AppColors.red,
                          fontSize: 12.sp,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              CustomText(
                text: "Date : ${date ?? ""}",
                fontSize: 12.sp,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomButton(
            onTap: () {
              // Trigger the modal for View Details
              showDetailsDialog(context);
            },
            title: "View Details",
            fontSize: 9.sp,
            height: 30.h,
            width: 90.w,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
  void showDetailsDialog(BuildContext context) {
    showDialog

      (

      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: "Health Record Details",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  textAlign: TextAlign.start,
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: screeningName ?? 'N/A',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            Spacer(),
                            Container(
                              padding:
                              EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: status == "Upcoming" ? Colors.blue.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  CustomText(
                                    text: status ?? "",
                                    color: status == "Upcoming" ? Color(0xFF2563EB) : AppColors.red,
                                    fontSize: 12.sp,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                SizedBox(height: 10),
                CustomText(
                  text: "Date : ${date ?? 'Albuterol Inhaler'}",
                  fontSize: 14,
                  color: Colors.black,
                ),

              ],
            ),
          ),
        );
      },

    );
  }

}
