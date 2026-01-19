import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../service/api_url.dart';
import '../../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../../utils/app_const/app_const.dart';
import '../../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../../components/custom_text/custom_text.dart';
import '../../../../../../components/custom_text_field/custom_text_field.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  // final args = Get.arguments as List;
  // late final String userId = args[0];
  // late final String userName = args[1];
  // late final String userPhoto = args[2];
  // late final String conversationId = args[3];
  // late final String myId = args[4];

  // late final MessageController controller;

  // final MessageController controller = Get.put(MessageController());
  // final ScrollController _scrollController = ScrollController();
  // final MessageController controller = Get.find<MessageController>();

  // double _previousScrollOffset = 0;
  // int _previousMessageCount = 0;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   controller.currentExistingUserId = userId;
  //   controller.receiverId = userId;
  //   controller.currentConversionId = conversationId;
  //   controller.currentUserId = myId;
  //
  //
  //   // Load initial messages
  //   controller.getSingleChatList(conversionId: conversationId, receiveId: userId);
  //   controller.listenToSocket();
  //
  //   // Pagination listener67
  //   _scrollController.addListener(() {
  //     if (_scrollController.position.pixels <= 100 && !controller.isSingleLoadingMore.value && controller.hasTextMoreMessages.value) {
  //       _previousScrollOffset = _scrollController.offset;
  //       _previousMessageCount = controller.conversationSingleList.length;
  //       controller.loadMoreSingleMessages();
  //     }
  //   });
  //   socketInitAgain();
  // }


  // void socketInitAgain()async{
  //   String id = await SharePrefsHelper.getString(AppConstants.userId);
  //   SocketApi.init(ApiUrl.socketUrl, id);
  //   debugPrint('=========== Socket connected ===========$id');
  //
  // }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {

    // debugPrint("conversationId: $conversationId");
    // debugPrint("receiver id: $userId");
    // debugPrint("sender id: $myId");
    return
      // Obx(() =>
      CustomGradient(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _buildAppBar(),
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(child: _buildMessageList()),
                  _buildMessageInput(),
                ],
              ),

            ],
          ),
        ),
      );
    // );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.black),
        onPressed: () => Get.back(),
      ),
      title: Row(
        children: [
          CustomNetworkImage(
            imageUrl: AppConstants.profileImage,   //'${ApiUrl.baseUrl}/$userPhoto',
            height: 40.h,
            width: 40.w,
            boxShape: BoxShape.circle,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "userName",
                  fontSize: 14.w,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const CustomText(
                  text: 'Active now',
                  fontSize: 10,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    // if (controller.isLoadingSingleChat.value) {
    //   return const Center(child: CustomLoader());
    // }

    // return Obx(() {
    // if (controller.conversationSingleList.isEmpty) {
    //   return  Center(
    //     child: Text(
    //       'noMessagesYet'.tr,
    //       textAlign: TextAlign.center,
    //       style: TextStyle(color: Colors.grey),
    //     ),
    //   );
    // }

    return RefreshIndicator(
      onRefresh: () async {
        // await controller.refreshSingleMessages();
      },
      child: ListView.builder(
        // controller: _scrollController,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
        // itemCount: controller.conversationSingleList.length +(controller.isSingleLoadingMore.value ? 1 : 0),
        itemCount: 5,
        itemBuilder: (context, index) {
          // Loader at top while loading more
          // if (index == 0 && controller.isSingleLoadingMore.value) {
          //   return const Center(
          //     child: Padding(
          //       padding: EdgeInsets.all(16.0),
          //       child: CustomLoader(),
          //     ),
          //   );
          // }
          //
          // final messageIndex = controller.isSingleLoadingMore.value ? index - 1 : index;
          // final message = controller.conversationSingleList[messageIndex];
          // final isMe = message.msgByUserId.id == controller.currentExistingUserId;
          return CustomInboxMessage2(
            key:ValueKey(5), //ValueKey(message.id),
            isMe: index==1 ? true : false,//isMe,
            message: index==1 ? "hi" : "What Are You Doing ?", //message.text,
            // type: message.imageUrl!.isNotEmpty ? 'image' : 'text',
            type: "text",
            img:AppConstants.profileImage,  //'${ApiUrl.baseUrl}/${message.msgByUserId.photo}',
            // messageTime: DateConverter.formatTimeAgo(message.createdAt.toString()),
            // imageUrls: message.imageUrl,
            // isSeen: message.seen,
          );
        },
      ),
    );
    // });
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: EdgeInsets.only(
          bottom: 30.h, left: 10.w, right: 15.w, top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // if (controller.selectedImages.isNotEmpty)
          SizedBox(
            height: 100.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,//controller.selectedImages.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 2),
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(10),
                    //     child: Image.file(
                    //       controller.selectedImages[index],
                    //       height: 100.h,
                    //       width: 100.w,
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          // controller.selectedImages.removeAt(index);
                          // controller.update();
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary,
                          ),
                          child:
                          Icon(Icons.close, color: Colors.white, size: 20.w),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.attach_file, color: AppColors.black), onPressed: () {  },
                // onPressed: () async {
                //   await controller.pickImagesFromGallery();
                //   controller.update();
                // },
              ),
              Expanded(
                child: CustomTextField(
                  inputTextStyle: const TextStyle(color: AppColors.black),
                  cursorColor: AppColors.white,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send, color: AppColors.primary),
                    onPressed: () {
                      // if (controller.messageController2.value.text.isNotEmpty &&
                      //     controller.selectedImages.isEmpty) {
                      //   controller.SingleSendMessage();
                      // } else if (controller.selectedImages.isNotEmpty) {
                      //   controller.uploadFileAndSendMessage(eventId: conversationId);
                      // }
                    },
                  ),
                  textEditingController:TextEditingController(),
                  // textEditingController: controller.messageController2.value,
                  hintText: 'typeAMessage'.tr,
                  hintStyle:  TextStyle(color: AppColors.black),
                  fieldBorderColor: AppColors.primary.withOpacity(.3),
                  fillColor: AppColors.white,

                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//============================ MESSAGE BUBBLE ============================
class CustomInboxMessage2 extends StatelessWidget {
  final bool isMe;
  final String message;
  final String? messageTime;
  final String type;
  final List<String>? imageUrls;
  final String? img;
  final bool isSeen;

  const CustomInboxMessage2({
    super.key,
    required this.isMe,
    required this.message,
    this.messageTime,
    required this.type,
    this.imageUrls,
    this.img,
    this.isSeen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          mainAxisAlignment:
          !isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (isMe) _buildAvatar(),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  _buildMessageContent(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 17,
      backgroundColor: Colors.transparent,
      child: CustomNetworkImage(
        boxShape: BoxShape.circle,
        imageUrl: img ?? AppConstants.profileImage,
        height: 40,
        width: 40,
      ),
    );
  }

  //  UNIFIED MESSAGE CONTENT (Text + Images)
  Widget _buildMessageContent(BuildContext context) {
    final hasImages = imageUrls != null && imageUrls!.isNotEmpty;
    final hasText = message.isNotEmpty;

    return Container(
      constraints:
      BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
      decoration: BoxDecoration(
        color: isMe ? Colors.white : Colors.amber.shade50,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(12),
          topRight: const Radius.circular(12),
          bottomLeft: isMe ? const Radius.circular(12) : Radius.zero,
          bottomRight: isMe ? Radius.zero : const Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  IMAGES
          if (hasImages) _buildImagesSection(),

          //  TEXT
          if (hasText)
            Padding(
              padding: EdgeInsets.only(
                left: 12,
                right: 12,
                top: hasImages ? 8 : 12,
                bottom: 8,
              ),
              child: Text(
                message,
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ),

          // TIME & SEEN STATUS
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  messageTime ?? '',
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
                if (!isMe) ...[
                  const SizedBox(width: 4),
                  // Icon(
                  //   isSeen ? Icons.done_all : Icons.done,
                  //   size: 16,
                  //   color: isSeen ? Colors.blue : Colors.grey,
                  // ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // BUILD IMAGES SECTION
  Widget _buildImagesSection() {
    if (imageUrls == null || imageUrls!.isEmpty) {
      return const SizedBox.shrink();
    }

    // Single image
    if (imageUrls!.length == 1) {
      return Column(
        children: imageUrls!.map((img) {
          bool isLocal = img.startsWith('/') || img.contains('tmp');
          String fullImgPath = isLocal ? img : '${ApiUrl.baseUrl}/$img';
          return Padding(
            padding: const EdgeInsets.all(4),
            child: GestureDetector(
              onTap: () {
                Get.to(() => FullScreenImageView(
                    imageUrl: fullImgPath,
                    isLocal: isLocal
                ));
              },
              child: Hero(
                tag: fullImgPath,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: isLocal
                      ?Image.file(
                    File(img),
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ) : CustomNetworkImage(
                    imageUrl: '${ApiUrl.baseUrl}/${imageUrls!.first}',
                    height: 200,
                    width: 200,
                  ),

                ),
              ),
            ),
          );
        }).toList(),
      );
    }

    // Multiple images
    return Container(
      padding: const EdgeInsets.all(4),
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageUrls!.length,
        itemBuilder: (context, index) {
          bool isLocal = img!.startsWith('/') || img!.contains('tmp');
          String? fullImgPath = isLocal ? img : '${ApiUrl.baseUrl}/$img';
          return GestureDetector(
            onTap: () {
              Get.to(() => FullScreenImageView(
                  imageUrl: fullImgPath!,
                  isLocal: isLocal
              ));
            },
            child: Container(
              margin: const EdgeInsets.only(right: 4),
              child: Hero(
                // tag: imageUrls![index],
                tag: fullImgPath! + index.toString(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CustomNetworkImage(
                    imageUrl: '${ApiUrl.baseUrl}/${imageUrls![index]}',
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}



class FullScreenImageView extends StatelessWidget {
  final String imageUrl;
  final bool isLocal;

  const FullScreenImageView({
    super.key,
    required this.imageUrl,
    required this.isLocal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Hero(
          tag: imageUrl,
          child: InteractiveViewer(
            panEnabled: true,
            minScale: 0.5,
            maxScale: 4.0,
            child: isLocal
                ? Image.file(
              File(imageUrl),
              fit: BoxFit.contain,
            )
                : Image.network(
              imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.error, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}