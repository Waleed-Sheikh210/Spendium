import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Services/user_service.dart';
import 'package:hisab_kitab/Utils/utils.dart';

import '../Models/FamilyMemberModel.dart';
import '../Models/MembersModel.dart';
import 'UserController.dart';

class MemberController extends GetxController {
  var members = <FamilyMemberModel>[].obs;
  var searchedUsers = <FamilyMemberModel>[].obs;
  var searchQuery = ''.obs;
  final invitaitonLength  = 0.obs;
  final titleController = TextEditingController();
RxBool hasFamilyCreated = false.obs;
final userController = Get.find<UserController>();
  @override
  void onInit() {
    super.onInit();

  }

  void updateSearch(String value) {
    searchQuery.value = value;

    if (value.trim().isEmpty) {
      searchedUsers.clear();
    } else {
      // Later replace this with API call
      searchMembersFromAPI(value);
    }
  }

  void searchMembersFromAPI(String query) {
    // Simulate remote search
    searchedUsers.value = members.where((m) {
      final q = query.toLowerCase();
      return m.user!.name!.toLowerCase().contains(q) ||
          m.user!.username!.toLowerCase().contains(q) ||
          m.user!.email!.toLowerCase().contains(q);
    }).toList();

    // Replace the above with your actual API call and update `searchedUsers`
  }

  void createAFamily() {
    showLoading();
    createFamily(
      name: titleController.text.trim(),
      onSuccess: (data) {
        hideLoading();
        Get.back();
        Get.snackbar("Success", "Family created successfully",
            colorText: Colors.white, backgroundColor: Colors.green);
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error.toString(),
            colorText: Colors.white, backgroundColor: Colors.red);
      },
    );
  }

  getMyFamilyMembers(){
    showLoading();
    getMyFamily(onSuccess: (data) {
      hideLoading();
      members.value = data;
    }, onError: (error) {
      hideLoading();
      // Get.snackbar("Error", error.toString(),
      //     colorText: Colors.white, backgroundColor: Colors.red);
    },);
  }
  myInvitations(){
    showLoading();
    getMyInvitations(onSuccess: (data) {
      hideLoading();
      // members.value = data;
      invitaitonLength.value = data.length;
    }, onError: (error) {
      hideLoading();
      Get.snackbar("Error", error.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    },);
  }

  checkHasFamily(){
    hasFamily(onSuccess: (data) {
      hasFamilyCreated.value = data;
    }, onError: (error) {
      Get.snackbar("Error", error.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    },);
  }
  @override
  void onReady() {
    // TODO: implement onReady
    getMyFamilyMembers();
    if(userController.user.value?.role == "father"){

    checkHasFamily();
    }else{
      myInvitations();
    }
    super.onReady();
  }
}
