import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Utils/ColorUtils.dart';

import '../Utils/paths.dart';
import '../controllers/InnerSearchScreenController.dart';

class InnerSearchScreen extends GetWidget<InnerSearchScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Members')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: controller.updateSearch,
              decoration: InputDecoration(
                hintText: 'Search members...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              final filtered = controller.filteredMembers;

              return

              filtered.isEmpty?

            const Center(child: Text("No results found")):
                ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final member = filtered[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(member.name??"",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      Text(' (${member.role})',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: ColorUtils.teal,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text('@${member.username}',
                                      style:
                                          const TextStyle(color: Colors.grey)),
                                  const SizedBox(height: 4),
                                  Text(member.email??""),
                                ],
                              ),
                            ),
                            if(controller.userController.user.value?.role == "father")
                            ElevatedButton(
                              onPressed: () {
                                controller.inviteMember(member);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                              child: const Text('Invite'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
