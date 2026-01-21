import 'package:america_ayber_squad/utils/app_colors/app_colors.dart';
import 'package:america_ayber_squad/view/components/custom_button/custom_button.dart';
import 'package:america_ayber_squad/view/components/custom_dropdown/custom_royel_dropdown.dart';
import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:america_ayber_squad/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../components/custom_from_card/custom_from_card.dart';
import '../widget/custom_recent_report.dart';

class SchoolNurseIncidentReporting extends StatelessWidget {
  const SchoolNurseIncidentReporting({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(
          titleName: "Incident Reporting",
          leftIcon: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          text: "New Incident Report",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText(
                          text:
                              "Please fill out all details accurately for official records",
                          textAlign: TextAlign.start,
                          maxLines: 5,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                      SizedBox(
                        height: 10,
                      ),
                      CustomFormCard(
                        title: 'Date & Time',
                        hintText: "mm/dd/yyyy",
                        controller: TextEditingController(),
                        fieldBorderColor: Colors.grey,
                        fillBorderRadius: 8,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomRoyelDropdown(
                        title: "Location",
                        hintText: "Select Location",
                        isBorder: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomFormCard(
                        title: 'Student Involves',
                        hintText: "Search and add student",
                        controller: TextEditingController(),
                        fieldBorderColor: Colors.grey,
                        fillBorderRadius: 8,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomRoyelDropdown(
                        title: "Location",
                        hintText: "Select Location",
                        isBorder: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomFormCard(
                        title: 'Injury Details & Treatment',
                        hintText: "Search and add student",
                        controller: TextEditingController(),
                        fieldBorderColor: Colors.grey,
                        fillBorderRadius: 8,
                        maxLine: 5,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomFormCard(
                        title: 'Witnesses',
                        hintText: "Name of staff or student witness",
                        controller: TextEditingController(),
                        fieldBorderColor: Colors.grey,
                        fillBorderRadius: 8,
                        maxLine: 3,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              onTap: () {},
                              title: "Cancel",
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              fillColor: AppColors.white,
                              textColor: Colors.black,
                              isBorder: true,
                              borderWidth: 1,
                              borderColor: AppColors.black,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: CustomButton(
                              onTap: () {},
                              title: "Submit",
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),


                // Container(
                //   padding: EdgeInsets.all(16.w),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(12),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.black.withOpacity(0.1),
                //         blurRadius: 2,
                //         offset: const Offset(0, 2),
                //       ),
                //     ],
                //   ),
                //   child: Column(
                //     children: [
                //       Align(
                //         alignment: Alignment.topLeft,
                //         child: CustomText(
                //           textAlign: TextAlign.start,
                //           text: "uploadCoverImage",
                //           fontSize: 16.w,
                //           fontWeight: FontWeight.w500,
                //           bottom: 8.h,
                //         ),
                //       ),
                //     GestureDetector(
                //       onTap: () {},
                //       child: Container(
                //         height: 120,
                //         width: double.infinity,
                //         decoration: BoxDecoration(
                //           color: Colors.transparent,
                //           border: Border.all(color: Color(0xff96C9B8)),
                //           borderRadius: BorderRadius.circular(15),
                //         ),
                //         child: Column(
                //           children: [
                //             ClipRRect(
                //               borderRadius:
                //               BorderRadius.circular(15),
                //               child: Image.file(
                //                 fit: BoxFit.cover,
                //                 width: double.infinity,
                //                 height: 120,
                //               ),
                //             ),
                //             Column(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 Icon(Icons.upload_file,
                //                     size: 50,
                //                     color: Color(0xff96C9B8)
                //                 ),
                //                 SizedBox(height: 10.h),
                //                 CustomText(
                //                   text: 'Upload A Photo',
                //                   fontWeight: FontWeight.w400,
                //                   fontSize: 16,
                //                   color: AppColors.primary,
                //                 ),
                //               ],
                //             ),
                //           ],
                //         ),
                //       ),
                //       ),
                //     ],
                //   ),
                // ),



          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Recent Reports",
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10,),
                CustomRecentReport(
                  title: "Playground Fall",
                  studentName: "James Wilson",
                  grade: "Gr 6",
                  date: "Yesterday",
                )
              ],
            ),
          ),



            ],
            ),
          ),
        ),
      ),
    );
  }
}
