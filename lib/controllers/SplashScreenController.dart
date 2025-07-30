import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import '../Models/User.dart';
import '../Utils/Prefs.dart';
import '../Utils/paths.dart';
import 'UserController.dart';

class SplashScreenController extends GetxController {
  RxBool isInitialized = false.obs;
  RxBool isInitialized1 = false.obs;
  RxBool isInitialized2 = false.obs;
 final userController = Get.find<UserController>();

  getUserSession() async {
    userController.user.value = await Prefs.getUserSync();
  }

  @override
  void onInit() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light,
    );
    getUserSession();
    // TODO: implement onInit

    Future.delayed(Duration(milliseconds: 1200), () {
      isInitialized1.value = true;
      update();
    });
    Future.delayed(Duration(seconds: 3), () {
      if (userController.user.value == null) {
        Get.offNamedUntil(Paths.loginScreenPath, (route) => false);
      } else {
        Get.offNamedUntil(Paths.bottomNavBarScreenPath, (route) => false);
      }
    });
    super.onInit();
  }
}
