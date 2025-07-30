import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/views/HomeScreen.dart';
import 'package:hisab_kitab/views/MemberScreen.dart';
import 'package:hisab_kitab/views/SplashScreen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../../Utils/ColorUtils.dart';
import '../../controllers/BottomNavBarController.dart';
import '../AiChatScreen.dart';
import '../SocialForum.dart';
import '../moneyManagement.dart';

class BottomNavBarScreen extends GetWidget<BottomNavBarController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() {
        return PersistentTabView(
          hideNavigationBar: controller.selectedIndex.value == 2 ? true : false,
          controller: controller.persistentTabController,
          onTabChanged: controller.onItemTapped,
          tabs: [
            PersistentTabConfig(
              screen: HomeScreen(),
              item: ItemConfig(
                activeForegroundColor: ColorUtils.teal,
                icon: Icon(Icons.home),
                title: "Home",
              ),
            ),
            PersistentTabConfig(
              screen: MoneyManagement(),
              item: ItemConfig(
                activeForegroundColor: ColorUtils.teal,
                icon: Icon(Icons.monetization_on),
                title: "Money Management",
              ),
            ),
            PersistentTabConfig(
              screen: AiChatScreen(),
              item: ItemConfig(
                activeForegroundColor: ColorUtils.teal,
                icon: Icon(
                  Icons.chat,
                  color: ColorUtils.white,
                ),
                title: "Ai Chat",
              ),
            ),
            PersistentTabConfig(
              screen: SocialForum(),
              item: ItemConfig(
                activeForegroundColor: ColorUtils.teal,
                icon: Icon(Icons.forum),
                title: "Social Forum",
              ),
            ),
            PersistentTabConfig(
              screen: MembersScreen(),
              item: ItemConfig(
                activeForegroundColor: ColorUtils.teal,
                icon: Icon(Icons.people_alt_outlined),
                title: "Members",
              ),
            ),
          ],
          navBarBuilder: (navBarConfig) => Style13BottomNavBar(
            navBarConfig: navBarConfig,
            navBarDecoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        );
      }),
    );
  }
}
