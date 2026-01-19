import 'package:america_ayber_squad/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../components/custom_button/custom_button.dart';
import '../../../../../../components/custom_from_card/custom_from_card.dart';
import '../../../../../../components/custom_text/custom_text.dart';
import '../controller/support_controller.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final ContactUsController controller = ContactUsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:CustomRoyelAppbar(
        titleName: "Support",
        leftIcon: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Card(
            color: AppColors.white,
            elevation: 0.1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  CustomText(
                    text: "Send us a message",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.left,
                    bottom: 20.h,
                  ),

                  /// Name
                  CustomFormCard(
                    title: "Name",
                    hintText: "Your name",
                    controller: controller.nameController,
                    validator: (v) =>
                    v == null || v.isEmpty ? "Name is required" : null,
                  ),

                  /// Email
                  CustomFormCard(
                    title: "Email",
                    hintText: "your.email@example.com",
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) =>
                    v == null || !v.contains("@")
                        ? "Enter valid email"
                        : null,
                  ),

                  /// Subject
                  CustomFormCard(
                    title: "Subject",
                    hintText: "What is this regarding?",
                    controller: controller.subjectController,
                  ),

                  /// Message
                  CustomFormCard(
                    title: "Message",
                    hintText:
                    "Please describe your issue or question in detail...",
                    controller: controller.messageController,
                    maxLine: 5,
                    isMultiLine: true,
                    fillBorderRadius: 16,
                  ),

                  SizedBox(height: 10.h),

                  /// Button
                  CustomButton(
                    title: "Send Message",
                    fillColor: AppColors.primary,
                    fontSize: 14.sp,
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}