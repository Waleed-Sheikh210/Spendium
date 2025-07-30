import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Services/user_service.dart';

import '../Utils/paths.dart';

class SignupController extends GetxController {
  final nameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final cPassFocus = FocusNode().obs;
  final selectedFamilyStatus = ''.obs;
  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;

  // Rxn<File> imageFile = Rxn();
  final familyOptions = ['Child', 'Mother', 'Father'];
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  final selectedGender = ''.obs;

  void signup() {
    String name = nameController.text.trim();
    String userName = userNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        userName.isEmpty ||
        selectedFamilyStatus.value.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar('Error', 'Please fill all the fields',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    // if (imageFile.value == null) {
    //   Get.snackbar('Error', 'Please select an image',
    //       backgroundColor: Colors.red, colorText: Colors.white);
    //   return;
    // }
    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Invalid Email', 'Please enter a valid email address',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (password.length < 8) {
      Get.snackbar('Weak Password', 'Password must be at least 6 characters',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar('Mismatch', 'Passwords do not match',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    isLoading.value = true;
    signUp(
      name: nameController.text.trim(),
      // image: imageFile.value!.path,
      email: emailController.text.trim(),
      username: userNameController.text.trim(),
      password: passwordController.text.trim(),
      password_confirmation: confirmPasswordController.text.trim(),
      role: selectedFamilyStatus.value,
      onSuccess: (user) {
        isLoading.value = false;

        Get.snackbar('Success', 'Account created successfully!',
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAllNamed(Paths.bottomNavBarScreenPath);

      },
      onError: (error) {
        isLoading.value = false;
      },
    );

    // Navigate or submit data to API
  }
}
