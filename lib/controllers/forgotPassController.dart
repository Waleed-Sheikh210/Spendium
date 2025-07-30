import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Services/user_service.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;

  void sendResetLink() {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar("Error", "Please enter your email",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Invalid", "Enter a valid email address",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    forgetPassword(
        email: emailController.text.trim(),
        onSuccess: (baseModel) {
          isLoading.value = false;
          Get.back();
          Get.snackbar('Success', 'Reset link sent to $email!',
              backgroundColor: Colors.green, colorText: Colors.white);
        },
        onError: (String error) {
          isLoading.value = false;
        });
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
