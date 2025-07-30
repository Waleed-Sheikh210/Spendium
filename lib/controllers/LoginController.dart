import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Services/user_service.dart';
import 'package:hisab_kitab/Utils/utils.dart';

import '../Utils/paths.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void loginApi() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty ) {
      Get.snackbar('Error', 'Email cannot be empty',
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }
    if (password.isEmpty) {
      Get.snackbar('Error', 'Password cannot be empty',
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    // showLoading();
    login(
        email: email,
        password: password,
        onSuccess: (user) {
          // hideLoading();
          isLoading.value = false;
          Get.snackbar('Success', 'Logged in successfully!',
              backgroundColor: Colors.green, colorText: Colors.white);
          Get.offAllNamed(Paths.bottomNavBarScreenPath);
        },
        onError: (error) {
          // hideLoading();
          isLoading.value = false;

          Get.snackbar('Error', error,
              backgroundColor: Colors.redAccent, colorText: Colors.white);
        },);
    // Simulate login delay
    /*   Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
      Get.snackbar('Success', 'Logged in successfully!',
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.toNamed(Paths.bottomNavBarScreenPath);
      // Navigate to home screen here
    });*/
  }
}
