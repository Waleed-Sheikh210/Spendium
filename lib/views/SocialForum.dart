import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Models/SocialForumModel.dart';
import 'package:hisab_kitab/controllers/socialForumController.dart';
import 'package:image_picker/image_picker.dart';

import '../Utils/paths.dart';

class SocialForum extends GetWidget<SocialForumController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        title: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text('Social Forum', style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateForumDialog(context),
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
        tooltip: "Create Forum",
      ),
      body: Obx(() => ListView.builder(
            itemCount: controller.posts.length,
            padding: EdgeInsets.only(bottom: 150, top: 20, left: 20, right: 20),
            itemBuilder: (context, index) {
              final post = controller.posts[index];
              return _buildPostCard(post);
            },
          )),
    );
  }

  Widget _buildPostCard(SocialForumModel post) {
    return InkWell(
      onTap: () {
        Get.toNamed(Paths.socialDetailScreenPath, arguments: {
          'postId': post.id,
          'title': post.title,
          'description': post.description,
          'imageUrl': post.photo,
          "postData": post,
        });
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 16),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    post.title ?? "",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  if(post.user!.id != controller.userController.user?.value?.id.toString())
                  ElevatedButton(
                      onPressed: () {
                        controller.followUnfollowPost(
                          postId: post.user!.id.toString(),
                          onSuccess: (data) {
                            // post.isFollow = (post.isFollow == "0" ? "1" : "0");
                            controller.posts.refresh();
                            controller.getAllPosts();
                          },
                        );
                      },
                      child: Text(
                        post.isFollow == "1" ? "Unfollow" : "Follow",
                      ))
                ],
              ),
              const SizedBox(height: 10),
              if (post?.photo != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: post.photo!.startsWith("http")
                      ? Image.network(
                          post.photo!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.broken_image,
                            size: 100,
                          ),
                        )
                      : Image.file(File(post.photo!), fit: BoxFit.cover),
                ),
              if (post.photo != null) const SizedBox(height: 10),
              if (post.description != null &&
                  post.description!.trim().isNotEmpty)
                Text(
                  post.description!,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateForumDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Obx(() => SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Create Forum Post",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: controller.titleController.value,
                      decoration: InputDecoration(
                        labelText: "Title",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: controller.descController.value,
                      maxLines: 3,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: "Description",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    SizedBox(height: 12),
                    GestureDetector(
                      onTap: () async {
                        final picked = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (picked != null) {
                          controller.selectedImage.value = File(picked.path);
                        }
                      },
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade400),
                          image: controller.selectedImage.value != null
                              ? DecorationImage(
                                  image: FileImage(
                                      controller.selectedImage.value!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: controller.selectedImage.value == null
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add,
                                        size: 30, color: Colors.grey[600]),
                                    SizedBox(height: 5),
                                    Text(
                                      "Add Image",
                                      style: TextStyle(color: Colors.grey[700]),
                                    )
                                  ],
                                ),
                              )
                            : null,
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
                                controller.titleController.value.text.trim();
                            final desc =
                                controller.descController.value.text.trim();

                            if (title.isEmpty) {
                              Get.snackbar("Error", "Title is required");
                              return;
                            }

                            if (desc.isEmpty) {
                              Get.snackbar("Error", "Description is required");
                              return;
                            }

                            if (controller.selectedImage.value == null) {
                              Get.snackbar("Error", "Image is required");
                              return;
                            }
                            controller.postAForum();

                            Get.back(); // Close dialog
                          },
                          child: Text("Post",
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
              )),
        ),
      ),
    );
  }
}
