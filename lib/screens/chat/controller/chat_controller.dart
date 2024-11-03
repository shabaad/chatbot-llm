import 'dart:convert';
import 'dart:developer';
import 'package:chatbot_llm/data/secrets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cohere/flutter_cohere.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../common_utils/common_methods.dart';
import '../../../common_utils/constants.dart';
import '../../../common_utils/network_connectivity.dart';
import '../../../routeInfo/route_name.dart';


class ChatController extends GetxController {

  final TextEditingController messageController = TextEditingController();
  final RxList<Message> messages = <Message>[].obs;

  RxBool isBotTyping = false.obs;
  RxBool isHistoryLoading = false.obs;

  RxString appVersion = "".obs;
  final FocusNode focusNode = FocusNode();
  var co = CohereClient(apiKey: Secrets.cohereApiKey);

  @override
  onInit() {
    super.onInit();
    _initPackageInfo();

    fetchMessageHistory();
  }

  Future<void> sendMessage(context, FocusNode focusNode) async {
    isBotTyping(true);
    final messageText = messageController.text.trim();
    if (messageText.isNotEmpty) {
      final userMessage = Message(messageText, true, timestamp: DateTime.now());
      messages.add(userMessage);
      messageController.clear();

      await saveMessageToSupabase(
          Supabase.instance.client.auth.currentUser?.id ?? '', userMessage);

      try {
        final response = await co
            .generate(
          prompt: userMessage.text,
          maxTokens: 200,
          temperature: 0.7,
        )
            .then((value) async {
          final text = value['generations'][0]['text'];
          final botMessage = Message(text, false, timestamp: DateTime.now());
          messages.add(botMessage);
          await saveMessageToSupabase(
              Supabase.instance.client.auth.currentUser?.id ?? '', botMessage);
        }).catchError((e) {
          log(e);
          messages.add(Message(e ?? '', false, timestamp: DateTime.now()));
        });
      } catch (e) {
        if (await NetworkConnectivity().checkInternetConnection()) {
          messages.add(Message("Something went wrong. Please try again.", false,
              timestamp: DateTime.now()));
        } else {
          messages.add(Message(
              "Please check your internet connection and retry", false,
              timestamp: DateTime.now()));
        }
        debugPrint(e.toString());
      }
    }
    isBotTyping(false);
  }

  Future<void> saveMessageToSupabase(String userId, Message message) async {
    try {
      final response = await Supabase.instance.client.from('messages').insert({
        'user_id': userId,
        'message': message.text,
        'is_sent': message.isSent,
        'timestamp': message.timestamp.toIso8601String(),
      });
    } catch (e) {
      log('Error saving message: ${e}');
    }
  }

  Future<void> fetchMessageHistory() async {
    isHistoryLoading(true);
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id ?? '';
      final response = await Supabase.instance.client
          .from('messages')
          .select()
          .eq('user_id', userId)
          .order('timestamp', ascending: true);
      for (var messageData in response) {
        final message = Message(
          messageData['message'],
          messageData['is_sent'],
          timestamp: DateTime.parse(messageData['timestamp']),
        );
        messages.add(message);
      }
    } catch (e) {
      log('Error fetching message history: ${e}');
      final message = Message(
         'Message history not available now',
          false,
          timestamp: DateTime.now(),
        );
       messages.add(message);
    }finally{
          isHistoryLoading(false);

    }
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    appVersion.value = "${info.version} (${info.buildNumber})";
  }

  Future<void> logout() async {
    saveBoolDataToStorage(Constants.isLoggedIn, false);

    Get.offAllNamed(RouteName.welcomeScreen);
  }

  void resetBot() {
    Get.back();
    messages.clear();
  }

  List<Option> options = [

    Option(
      name: 'Theme',
      icon: Icons.sunny,
      onTap: () {
        Get.toNamed(RouteName.themeScreen);
      },
    ),
    Option(
      name: 'Logout',
      icon: Icons.logout,
      onTap: () {},
    ),
    Option(
      name: '',
      onTap: () {},
    ),
  ];
}

class Option {
  final String name;
  final IconData? icon;
  final VoidCallback onTap;

  Option({required this.name, this.icon, required this.onTap});
}

class Message {
  final String text;
  final bool isSent;
  final DateTime timestamp;

  Message(this.text, this.isSent, {required this.timestamp});
}
