import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Services/user_service.dart';
import 'package:hisab_kitab/Utils/widgets.dart';
import 'package:hisab_kitab/controllers/UserController.dart';

import '../Models/MembersModel.dart';

class InnerSearchScreenController extends GetxController {
  var members = <MemberModel>[].obs;
  var searchQuery = ''.obs;
  final userController = Get.find<UserController>();

  @override
  void onInit() {
    super.onInit();
  }

  List<MemberModel> get filteredMembers {
    if (searchQuery.isEmpty) return members;
    return members.where((m) {
      final q = searchQuery.value.toLowerCase();
      return m.name!.toLowerCase().contains(q) ||
          m.username!.toLowerCase().contains(q) ||
          m.email!.toLowerCase().contains(q);
    }).toList();
  }

  void updateSearch(String value) {
    searchQuery.value = value;
  }

  void getUsers() {
    showLoading();
    getAllUsersList(
      onSuccess: (users) {
        hideLoading();
        print(users);
        members.value = users;
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error);

      },
    );
  }

  void inviteMember(MemberModel member) {
    showLoading();
    print("Invited: ${member.email}");
    inviteUser(
      role: member.role.toString(),
      email: member.email.toString(),
      onSuccess: (users) {
        hideLoading();
        Get.snackbar("Success", "Invitation sent successfully",
            colorText: Colors.white, backgroundColor: Colors.green);
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error);

      },
    );
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getUsers();
    super.onReady();
  }
}
