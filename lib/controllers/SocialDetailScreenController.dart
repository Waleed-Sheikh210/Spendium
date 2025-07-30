

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Models/SocialForumModel.dart';
import 'package:hisab_kitab/Services/ForumServices.dart';
import 'package:hisab_kitab/Utils/utils.dart';
import 'package:hisab_kitab/controllers/socialForumController.dart';

class SocialDetailScreenController extends GetxController {
  RxString postId = "".obs;
  final title = "".obs;
  final desc = "".obs;
  final imageUrl = "".obs;
  RxBool isLiked = false.obs;
  RxInt likeCount = 0.obs;
  RxList<Comments> postComments = RxList<Comments>();
  Rx<SocialForumModel> post = SocialForumModel().obs;
  final commentController = TextEditingController();
  final socialForumController = Get.find<SocialForumController>();

  void toggleLike() {

    likePost(
      postId: postId.toString(),
      onSuccess: (data) {
        hideLoading();
        // data.data['is_liked'] == "1";
        socialForumController.getAllPosts();
        isLiked.value = !isLiked.value;
        likeCount += isLiked.value ? 1 : -1;


      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error,
            backgroundColor: Colors.red, colorText: Colors.white);

      },
    );
  }

  getPostDetails() {
    showLoading();
    getPostsDetails(
      postId: postId.toString(),
      onSuccess: (data) {
        hideLoading();
        postComments.value = data;

        print(data);
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error,
            backgroundColor: Colors.red, colorText: Colors.white);
      },
    );
  }

  addComment() {
    if (commentController.text.trim().isEmpty) {
      Get.snackbar("Error", "Comment cannot be empty",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    FocusScope.of(Get.context!).unfocus();
    showLoading();
    postComment(
      postId: postId.toString(),
      comment: commentController.text.trim(),
      onSuccess: (data) {
        hideLoading();
        commentController.clear();
        getPostDetails();
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error,
            backgroundColor: Colors.red, colorText: Colors.white);
      },
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    post.value = Get.arguments?['postData'] ?? "";
    postId.value = Get.arguments?['postId'] ?? "";

    title.value = Get.arguments?['title'] ?? "";
    desc.value = Get.arguments?['description'] ?? "";
    imageUrl.value = Get.arguments?['imageUrl'] ?? "";
    isLiked.value = post.value.isLiked == "1";
    likeCount.value = int.parse(post.value.likeCount.toString());
    getPostDetails();

    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
}
