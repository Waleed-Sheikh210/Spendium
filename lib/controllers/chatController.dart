import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Services/user_service.dart';
import 'package:hisab_kitab/Utils/utils.dart';

import '../Models/MessageModel.dart';
import 'BottomNavBarController.dart';

class ChatController extends GetxController {
  final bottomNavController = Get.find<BottomNavBarController>();
  RxList<MessageModel> messages = <MessageModel>[].obs;
  final textController = TextEditingController().obs;

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    // messages.add(MessageModel());
    // messages.add(Message(
    //     text: "This is a mock AI response.",
    //     isUser: false)); // You can replace this with real AI call
  }

  askQuestion() {
    if (textController.value.text.trim().isEmpty) return;

    showLoading(needTimer: false);
    askAI(
      question: textController.value.text,
      onSuccess: (baseModel) {
        hideLoading();
        getHistory();
      },
      onError: (error) {
        hideLoading();

        Get.snackbar("Error", error,
            backgroundColor: Colors.red, colorText: Colors.white);
      },
    );
  }

  getHistory() {
    aiHistory(
      onSuccess: (data) {
        hideLoading();

        messages.value = data;
      },
      onError: (error) {
        hideLoading();

        Get.snackbar("Error", error,
            backgroundColor: Colors.red, colorText: Colors.white);
      },
    );
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getHistory();
    super.onReady();
  }
}
