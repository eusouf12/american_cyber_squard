import 'package:america_ayber_squad/view/components/custom_button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../utils/app_colors/app_colors.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';

class CustomHealthCheckingCard extends StatelessWidget {
  final String? name;
  final String? grade;
  final String? vaccineName;
  final String? condition;
  final String? lastCheckupDate;
  final String? currentMedications;
  final List<String>? allergies;
  final String? status;
  final VoidCallback? onTap;

  const CustomHealthCheckingCard({
    super.key,
    this.name,
    this.grade,
    this.vaccineName,
    this.condition,
    this.allergies,
    this.status,
    this.onTap,
    this.lastCheckupDate,
    this.currentMedications,
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
                text: name ?? "",
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
              Row(
                children: [
                  CustomText(
                    text: "Vaccine Name : " ?? "-",
                    fontSize: 12.sp,
                    color: Colors.black,
                  ),
                  CustomText(
                    text: "${vaccineName}" ?? "",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ],
              ),
              CustomText(
                text: "Due Date : ${lastCheckupDate ?? ""}",
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
          Row(
            children: [
              Expanded(
                child: CustomButton(
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
              ),
              SizedBox(width: 5,),
              Expanded(
                child: CustomButton(
                  onTap: () {},
                  title: "Edit",
                  fontSize: 9.sp,
                  height: 30.h,
                  width: 90.w,
                  fillColor: Colors.grey.withOpacity(0.4),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 5,),
              Expanded(
                child: CustomButton(
                  onTap: () {},
                  title: "Delete",
                  fontSize: 9.sp,
                  height: 30.h,
                  width: 90.w,
                  fillColor: Colors.red.withOpacity(0.8),
                  fontWeight: FontWeight.w400,
                ),
              ),

            ],
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
                              text: name ?? 'N/A',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // This ensures space between the containers
                  children: [
                    // Blood Type Container
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            CustomText(
                              text: "Vaccine Name",
                              fontSize: 10.sp,
                              color: Colors.black.withOpacity(0.7),
                            ),
                            CustomText(
                              text: vaccineName ?? "",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),

                    // Last Checkup Container
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            CustomText(
                              text: "Last Checkup",
                              fontSize: 10.sp,
                              color: Colors.black.withOpacity(0.7),
                            ),
                            CustomText(
                              text: lastCheckupDate ?? "Jan 01, 2026",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CustomText(
                  text: "Medical Condition: ${condition ?? 'N/A'}",
                  fontSize: 14,
                  color: Colors.black,
                ),
                CustomText(
                  text:
                  "Allergies: ${allergies?.join(', ') ?? 'N/A'}",
                  fontSize: 14,
                  color: Colors.black,
                ),
                CustomText(
                  text: "Current Medications: ${currentMedications ?? 'Albuterol Inhaler'}",
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
