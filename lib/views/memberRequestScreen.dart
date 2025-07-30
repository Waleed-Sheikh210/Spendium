import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Utils/ColorUtils.dart';

import '../controllers/MemberRequestScreenController.dart';

class MemberRequestScreen extends GetWidget<MemberRequestScreenController> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Member Requests'),
    ),
    body: Obx(() {


      return ListView.builder(
        itemCount: controller.members.value.length,
        itemBuilder: (context, index) {
          final member = controller.members.value[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(member.family?.name??"", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {

                        controller.acceptTheInvitation();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        foregroundColor: ColorUtils.green,
                        backgroundColor: ColorUtils.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                      ),
                      child: const Text('Accept',
                          style: TextStyle(color: Colors.white)),

                    ),

                  ],
                ),
              ),
            ),
          );
        },
      );
    }),
  );
  }

}