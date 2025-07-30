import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/controllers/chatController.dart';

class AiChatScreen extends GetWidget<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        leading: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              controller.bottomNavController.selectedIndex.value = 0;
              controller.bottomNavController.persistentTabController.jumpToPreviousTab();
            },
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text("AI Assistant", style: TextStyle(color: Colors.white)),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => Get.focusScope?.unfocus(),
        child: Column(
          children: [
            Expanded(child: Obx(() => _buildChatList())),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      reverse: true,
      itemCount: controller.messages.length,
      itemBuilder: (context, index) {
        final reversedIndex = controller.messages.length - 1 - index;
        final msg = controller.messages[index];
        return Align(
          alignment: msg.isAI  == false? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            constraints: BoxConstraints(maxWidth: 250),
            decoration: BoxDecoration(
              color: msg.isAI ==false ? Colors.teal : Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
               msg.message ??"",
              style:
                  TextStyle(color: msg.isAI == false ? Colors.white : Colors.black87),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 40, top: 10),
      color: Colors.white,
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.textController.value,
              decoration: InputDecoration(
                hintText: "Ask something...",
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.send, color: Colors.teal),
            onPressed: () {
              final text = controller.textController.value.text.trim();
              FocusScope.of(Get.context!).unfocus();
              controller.askQuestion();
              controller.textController.value.clear();
            },
          ),
        ],
      ),
    );
  }
}
