import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Models/SocialForumModel.dart';
import 'package:hisab_kitab/Services/ForumServices.dart';
import 'package:hisab_kitab/Utils/utils.dart';

import 'UserController.dart';

class SocialForumController extends GetxController {
  final titleController = TextEditingController().obs;
  final descController = TextEditingController().obs;
  final userController = Get.find<UserController>();
  final Rxn<File?> selectedImage = Rxn<File?>();
  var posts = <SocialForumModel>[].obs;

    followUnfollowPost({required String postId,required Function(dynamic data) onSuccess,}) {
    showLoading();
    followUnfollow(postId: postId, onSuccess: (data) {
      hideLoading();
      print(data);
      onSuccess(data);
    }, onError: (error) {
      Get.snackbar("Error", error, backgroundColor: Colors.red, colorText: Colors.white);
      hideLoading();
    },);
  }

  postAForum() {
    showLoading();
    createPost(
      title: titleController.value.text,
      description: descController.value.text,
      photo: selectedImage.value!.path.toString(),
      onSuccess: (data) {
        hideLoading();
        print(data);
        // posts.insert(
        //   0,
        //   SocialForumModel(
        //     title: data.title,
        //     description: data.description,
        //     photo: data.photo,
        //   ),
        // );
        posts.refresh();
        getAllPosts();
        Get.snackbar("Success", "Post created successfully",
            backgroundColor: Colors.green, colorText: Colors.white);

        titleController.value.clear();
        descController.value.clear();
        selectedImage.value = null;
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error,
            backgroundColor: Colors.red, colorText: Colors.white);
      },
    );
  }

  getAllPosts() {
    showLoading();
    getPosts(
      onSuccess: (data) {
        posts.value = data;
        hideLoading();
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
    getAllPosts();
    super.onReady();
  }
}
