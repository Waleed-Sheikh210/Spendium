import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/InvitaitonModel.dart';
import '../Models/MembersModel.dart';
import '../Services/user_service.dart';
import '../Utils/utils.dart';
import 'UserController.dart';

class MemberRequestScreenController extends GetxController {
  var members = <InvitaitonModel>[].obs;
final userController = Get.find<UserController>();
  myInvitations() {
    showLoading();
    getMyInvitations(
      onSuccess: (data) {
        hideLoading();
        // members.value = data;
        members.value = data;
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error.toString(),
            colorText: Colors.white, backgroundColor: Colors.red);
      },
    );
  }

  acceptTheInvitation() {
    showLoading();
    acceptInvitation(
      email:userController.user.value!.email!,
      role: userController.user.value!.role!,
      onSuccess: (data) {
        hideLoading();
        // members.value = data;
        Get.back(result: [true]);
        Get.snackbar("Success", "Invitation Accepted",
            colorText: Colors.white, backgroundColor: Colors.green);
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error.toString(),
            colorText: Colors.white, backgroundColor: Colors.red);
      },
    );
  }


  @override
  void onReady() {
    myInvitations();
    // TODO: implement onReady
    super.onReady();
  }
}
