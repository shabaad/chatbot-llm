import 'dart:io';

import 'package:chatbot_llm/common_utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../common_utils/common_dialogs.dart';
import '../../../common_utils/common_methods.dart';
import '../../../common_utils/constants.dart';
import '../../../routeInfo/route_name.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_style.dart';
import '../controller/chat_controller.dart';

class ChatView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChatViewState();
  }
}

class ChatViewState extends State<ChatView> {
  final controller = Get.put(ChatController());

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
              'Chatbot LLM',
              style: AppTextStyle.white18bold,
            ),
        actions: [
          _popupItems(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => controller.isHistoryLoading.isTrue
                    ? Center(
                        child: LoadingAnimationWidget.inkDrop(
                            color: Colors.grey, size: 30))
                    : 
                    controller.messages.isEmpty ? 
                    Center(child: commonThemeText16w700('Sent a message to start conversation', context),):
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        reverse: true, // Display messages from bottom to top
                        itemCount: controller.messages.length +
                            (controller.isBotTyping.value
                                ? 1
                                : 0), // Add one item if bot is typing
                        itemBuilder: (context, index) {
                          if (controller.isBotTyping.value && index == 0) {
                            // Show typing indicator at the bottom
                            return _buildTypingIndicator();
                          } else {
                            final reversedIndex = index -
                                (controller.isBotTyping.value
                                    ? 1
                                    : 0); // Adjust index for typing indicator
                            final message = controller.messages.reversed
                                .toList()[reversedIndex];
                            final shouldAnimate = reversedIndex ==
                                0; // Animate only the newest message
                            return _buildMessageTile(message, shouldAnimate);
                          }
                        },
                      ),
              ),
            ),
            _buildInputField(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  PopupMenuButton<Option> _popupItems() {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: AppColors.white,
      ),
      itemBuilder: (BuildContext context) {
        return controller.options.map((Option option) {
          return PopupMenuItem(
            textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            onTap: () {
              if (option.name == 'Logout') {
                CommonDialog.showOkDialog('Confirm Logout?',
                    'You will be logged out of Chatbot', context, () async {
                  saveBoolDataToStorage(Constants.isLoggedIn, false);
                  Get.offAllNamed(RouteName.welcomeScreen);
                });
              } else {
                option.onTap();
              }
            },
            value: option,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                option.icon != null
                    ? Icon(
                        option.icon,
                      )
                    : Text(
                        'Version:',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                SizedBox(width: 10.0.w),
                Text(
                  option.name.isEmpty
                      ? controller.appVersion.value
                      : option.name,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          );
        }).toList();
      },
    );
  }

  Widget _buildMessageTile(Message message, bool shouldAnimate) {
    final isUserMessage = message.isSent;
    final formattedTime = DateFormat('MMM d • h:mm a').format(message.timestamp);

    Widget messageTile = Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0.h),
        child: Row(
          mainAxisAlignment:
              isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            Flexible(
              child: Column(
                crossAxisAlignment:  isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: isUserMessage ? 50.w : 8.w,
                      right: isUserMessage ? 8.w : 50.w,
                    ),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: isUserMessage
                          ? Theme.of(context).canvasColor
                          : Theme.of(context).cardColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        message.text,
                      ),
                    ),
                  ),
                Container(
                    margin: EdgeInsets.only(
                      left: isUserMessage ? 50.w : 8.w,
                      right: isUserMessage ? 8.w : 50.w,
                    ),
                  
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child:Text(
                      formattedTime,
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                    ),
                  ),
                ],
              ),
            ),
        
          ],
        ),
      ),
    );

    // Apply animation only if shouldAnimate is true
    return shouldAnimate
        ? messageTile
            .animate()
            .fadeIn(duration: Duration(milliseconds: 500))
            .slide(begin: Offset(0, 0.3))
        : messageTile;
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            Container(
              margin: EdgeInsets.only(
                // top: 20.h,
                // bottom: 4.h,
                left: 8.w,
                // right: 8.w,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: LoadingAnimationWidget.waveDots(
                  color: Get.isDarkMode ? AppColors.themeLight : AppColors.theme, size: 30),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding:
          EdgeInsets.only(left: 8, right: 8, bottom: Platform.isIOS ? 20 : 8),
      child: Obx(() => Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF51758C).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: TextField(
                      focusNode: focusNode,
                      keyboardType: TextInputType.text,
                      controller: controller.messageController,
                      decoration: InputDecoration(
                        hintText: 'Message',
                        hintStyle: TextStyle(fontSize: 15),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                  onTap: () async {
                    if (!controller.isBotTyping.value) {
                      await controller.sendMessage(context, focusNode);
                    }
                  },
                  child: Opacity(
                    opacity: controller.isBotTyping.value ? 0.5 : 1,
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(
                        Icons.send,
                        size: 20,
                        color: AppColors.appColor,
                      ),
                    ),
                  )),
            ],
          )).animate().flip(),
    );
  }
}
