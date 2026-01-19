import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../../utils/app_const/app_const.dart';
import '../../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../../components/custom_text_field/custom_text_field.dart';
import '../widget/custom_message_list.dart';
import 'inbox_screen.dart';

class ChatListScreen extends StatefulWidget {

  ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {

  // final MessageController controller = Get.put(MessageController());
  final TextEditingController searchController = TextEditingController();

  final RxString searchText = ''.obs;

  final ScrollController scrollController = ScrollController();
  String? role;
  String? myIDLogin;


  @override
  Widget build(BuildContext context) {
    // Trigger pagination setup once (safe for stateless)
    // if (!scrollController.hasListeners) {
    //   _setupPagination();
    //   controller.getOneToOneConversationList();
    // }

    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(leftIcon: true, titleName: "message".tr),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Search Field ---
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomTextField(
                  hintText: "search".tr,
                  fillColor: Colors.transparent,
                  hintStyle: TextStyle(color: AppColors.black_80),
                  textEditingController: searchController,
                  fieldBorderColor: Colors.grey,
                  inputTextStyle: const TextStyle(color: Colors.black),
                  onChanged: (value) => searchText.value = value.toLowerCase(),
                ),
              ),
              SizedBox(height: 20,),

              // --- Conversation List ---
              Expanded(
                // child: Obx(() {
                // if (controller.isLoading.value && controller.oneToOneConversation.isEmpty) {
                //   return const Center(child: CustomLoader());
                // }

                // final filteredConversations = controller.oneToOneConversation.where((conversation) {
                //   final participant = conversation.participants.firstWhere(
                //         (p) => p.id != controller.currentUserId,
                //     orElse: () => conversation.participants.first,
                //   );
                //   return participant.name
                //       .toLowerCase()
                //       .contains(searchText.value);
                // }).toList();

                // if (filteredConversations.isEmpty) {
                //   return  Center(child: Text("noConversationsFound".tr));
                // }

                  child:  ListView.separated(
                    controller: scrollController,
                    padding: EdgeInsets.zero,
                    // itemCount: filteredConversations.length + 1,
                    itemCount: 5,
                    separatorBuilder: (_, __) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      if (index < 5) {
                        // if (index < filteredConversations.length) {
                        // final conversation = filteredConversations[index];
                        // final participant = conversation.participants.firstWhere(
                        //       (p) => p.id != controller.currentUserId,
                        //   orElse: () => conversation.participants.first,
                        // );

                        return GestureDetector(
                          onTap: () async{
                            Get.to(InboxScreen());
                            // debugPrint("✅======================${myIDLogin} ==========: ${conversation.id}");
                            // Get.to(
                            //       () => InboxScreen(),
                            //   arguments: [
                            //     participant.id,
                            //     participant.name,
                            //     participant.photo,
                            //     conversation.id,
                            //     myIDLogin,
                            //
                            //   ],
                            // );
                          },
                          child: CustomMessageList(
                            title: "Rohan"   ,// participant.name,
                            subtitle: "How Are You ?" , //conversation.lastMessage?.text,
                            time: "12",    //formatMessageTime(conversation.updatedAt),
                            img:AppConstants.profileImage, //'${ApiUrl.baseUrl}/${participant.photo}',
                          ),
                        );
                      }
                      // else {
                      //   return Obx(() => controller.isMoreLoading.value
                      //       ? const Padding(padding: EdgeInsets.all(20.0),
                      //     child: Center(child: CustomLoader()),
                      //   )
                      //       : const SizedBox.shrink());
                      // }
                    },
                  )
                // }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Time formatting ---
String formatMessageTime(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inSeconds < 60) {
    return "Just now";
  } else if (difference.inMinutes < 60) {
    return "${difference.inMinutes} min ago";
  } else if (difference.inHours < 24 && dateTime.day == now.day) {
    return "${difference.inHours}h ago";
  } else if (difference.inDays == 1 ||
      (difference.inHours < 48 && dateTime.day != now.day)) {
    return "Yesterday";
  } else if (dateTime.year == now.year) {
    return "${dateTime.day} ${_monthShort(dateTime.month)}";
  } else {
    return "${dateTime.day} ${_monthShort(dateTime.month)}, ${dateTime.year}";
  }
}

String _monthShort(int month) {
  const months = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  ];
  return months[month - 1];
}

