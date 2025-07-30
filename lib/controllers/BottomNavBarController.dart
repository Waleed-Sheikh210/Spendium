import 'dart:developer';

import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../Services/user_service.dart';
import '../Utils/utils.dart';
import 'HomeScreenController.dart';

class BottomNavBarController extends GetxController{
RxInt selectedIndex = 0.obs;
final persistentTabController = PersistentTabController();
final homeScreenController = Get.find<HomeScreenController>();

  void onItemTapped(int index) {
    if(index == 0){
      homeScreenController.getAnalytics();
    }
    selectedIndex.value = index;
  }
  }