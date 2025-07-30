import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/controllers/MemberScreenController.dart';

import '../Utils/paths.dart';

class MembersScreen extends GetWidget<MemberController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(
         () {
          return
            !controller.hasFamilyCreated.value && controller.userController.user.value?.role == "father"?
            FloatingActionButton(
            onPressed: () => _showCreateForumDialog(context),
            backgroundColor: Colors.teal,
            child: Icon(Icons.add),
            tooltip: "",
          ):SizedBox();
        }
      ),
      appBar: AppBar(
          toolbarHeight: 80.h,
          title: Padding(
    padding:  EdgeInsets.only(top:20.0,left: 20),
    child: Text('Family Members'))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              // onChanged: controller.updateSearch,
              readOnly: true,
              onTap: () {
                Get.toNamed(Paths.innerSearchScreenPath);
              },
              decoration: InputDecoration(
                hintText: 'Search by name, username or email...',
                prefixIcon: const Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),

          Obx(
             () {
              return
                (controller.userController.user.value?.role != "father" && controller.invitaitonLength.value >0 )?
                Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.toNamed(Paths.memberRequestScreenPath)?.then((value) {
                    controller.getMyFamilyMembers();
                    });
                  },
                  child:  Text('Requests(${controller.invitaitonLength.value})'),
                ),
              ): SizedBox();
            }
          ),
          Expanded(
            child: Obx(() {
              final isSearching =
                  controller.searchQuery.value.trim().isNotEmpty;
              final list =
                  isSearching ? controller.searchedUsers : controller.members;

              return
                list.isEmpty?

                    const Center(child: Text("No members found"))
                    :
                ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final member = list[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(member.user?.name ?? "",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Text('@${member.user?.username}',
                                      style:
                                          const TextStyle(color: Colors.grey)),
                                  const SizedBox(height: 4),
                                  Text(member.user?.email ?? ""),
                                ],
                              ),
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

  void _showCreateForumDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Create Family Name",
                  style:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: controller.titleController,
                  decoration: InputDecoration(
                    labelText: "Family Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text("Cancel",
                          style: TextStyle(color: Colors.red)),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        final title =
                        controller.titleController.text.trim();

                        if (title.isEmpty) {
                          Get.snackbar("Error", "Name is required",
                              colorText: Colors.white, backgroundColor: Colors.red);
                          return;
                        }

                        controller.createAFamily();// Close dialog
                      },
                      child: Text("Create",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
