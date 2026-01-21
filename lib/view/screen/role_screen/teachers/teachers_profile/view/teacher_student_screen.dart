import 'package:america_ayber_squad/view/components/custom_gradient/custom_gradient.dart';
import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../parents/widget/custom_parents_show_card.dart';
import '../controller/teacher_student_controller.dart';
import '../controller/teachers_material_controller.dart';
import '../widget/custom_teacher_exam_card.dart';
import '../widget/teacher_my_student_card.dart';

class TeacherStudentScreen extends StatelessWidget {
  TeacherStudentScreen({super.key});

  final teacherStudentController = Get.put(TeacherStudentController());

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: CustomRoyelAppbar(titleName: "My Students", leftIcon: true,),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                //Card View
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomParentsShowCard(
                        count: "Total Students",
                        label: "150",
                        icon: Icons.people,
                      ),
                      SizedBox(width: 12),
                      //Children
                      CustomParentsShowCard(
                        count: "Present Today",
                        label: "134",
                        icon: Icons.emoji_people_outlined,
                      ),
                      SizedBox(width: 12),
                      //Ave Attendance
                      CustomParentsShowCard(
                        count: "At Risk",
                        label: "5",
                        icon: Icons.error_outline,
                      ),
      
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                //Exam & Grades
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Students Directory
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: "Students Directory", fontSize: 14.sp, fontWeight: FontWeight.w600),
                            SizedBox(
                              width: 130,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Obx(() {
                                  return DropdownButton<String>(
                                    value: teacherStudentController.selectedClass.value,
                                    icon: Icon(Icons.arrow_drop_down),
                                    underline: SizedBox(),
                                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                                    onChanged: (String? newValue) {
                                      teacherStudentController.selectedClass.value = newValue!;
                                    },
                                    items: teacherStudentController.myClass.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return TeacherMyStudentCard(
                              phone: "+ 0123456789",
                              status: index== 0 || index == 4 ?"Present" :index== 1 ? "Late" : "Absent",
                              email: "example@gmail.com",
                              subject:index== 0 || index == 4 ?"Will" :index== 1 ? "Emma" : "Jone",
                              grade: "Grade 10-B",
                              onTapView: () {  },
                            );
                          },
                        ),
                      ],
                    ),
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