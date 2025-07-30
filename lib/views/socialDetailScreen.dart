import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Models/SocialForumModel.dart';
import 'package:hisab_kitab/Utils/fontUtils.dart';

import '../Utils/ColorUtils.dart';
import '../controllers/SocialDetailScreenController.dart';

class SocialDetailScreen extends GetWidget<SocialDetailScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forum Post Detail")),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Obx(() {
                    return Text(
                      controller.title.value,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                  const SizedBox(height: 12),

                  /// Description
                  Obx(() {
                    return (controller.desc.value.isNotEmpty)
                        ? Text(
                            controller.desc.value,
                            style: const TextStyle(fontSize: 16),
                          )
                        : SizedBox();
                  }),
                  const SizedBox(height: 16),

                  /// Image

                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Obx(() {
                      return Image.network(
                        controller.imageUrl.value,
                        // fit: BoxFit.cover,
                        // width: double.infinity,
                        // height: 200,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 100),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),

                  /// Divider
                  const Divider(thickness: 1.5),
                  Row(
                    children: [
                      InkWell(
                        onTap: controller.toggleLike,
                        child: Obx(() {
                          return Row(
                            children: [
                              Icon(
                                controller.isLiked.value
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: controller.isLiked.value
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text('Like (${controller.likeCount})'),
                            ],
                          );
                        }),
                      ),
                      const SizedBox(width: 24),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: const [
                            Icon(Icons.share, color: Colors.grey),
                            SizedBox(width: 4),
                            Text('Share'),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const Divider(thickness: 1.5),

                  /// Comment Section
                   Obx(
                      () {
                       return Text(
                        "Comments (${controller.postComments.value.length})",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                                         );
                     }
                   ),
                  const SizedBox(height: 12),

                  Obx(() {
                    return controller.postComments.value.isEmpty
                        ? Text("No comments yet")
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.postComments.value.length,
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: Image.network(
                                    controller.postComments.value[index].user
                                            ?.image ??
                                        "",
                                    errorBuilder:
                                        (context, error, stackTrace) => Icon(
                                      Icons.error,
                                      // size: 100,
                                    ),
                                    fit: BoxFit.fill,
                                  ).image,
                                ),
                                title: Text(
                                  controller.postComments.value[index].user
                                          ?.name ??
                                      "",
                                  style: TextStyle(
                                    fontFamily: FontUtils.SemiBold,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(controller
                                        .postComments.value[index].content ??
                                    ""),
                              );
                            },
                          );
                  }),
                ],
              ),
            ),
          ),

          /// Comment Box
          SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: ColorUtils.teal),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.commentController,
                      decoration: const InputDecoration(
                        hintText: "Add a comment...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: controller.addComment,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
