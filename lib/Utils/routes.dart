import 'package:get/get.dart';
import 'package:hisab_kitab/Utils/paths.dart';
import 'package:hisab_kitab/Utils/screen_bindings.dart';
import 'package:hisab_kitab/views/Auth/LoginScreen.dart';
import 'package:hisab_kitab/views/Auth/SignUpScreen.dart';
import 'package:hisab_kitab/views/BottomNavBar/bottomNavBar.dart';
import 'package:hisab_kitab/views/MemberScreen.dart';
import 'package:hisab_kitab/views/savingScreen.dart';
import 'package:hisab_kitab/views/innerSearchScreen.dart';

import '../controllers/MemberScreenController.dart';
import '../views/Auth/forgotPassScreen.dart';
import '../views/FundRequests.dart';
import '../views/GoalsScreen.dart';
import '../views/LoanManagementScreen.dart';
import '../views/MyBudgetScreen.dart';
import '../views/MyContributes.dart';
import '../views/MyFundRequestScreen3.dart';
import '../views/RequestFunds.dart';
import '../views/SocialForum.dart';
import '../views/SplashScreen.dart';
import '../views/loanContribute.dart';
import '../views/loanHistory.dart';
import '../views/memberRequestScreen.dart';
import '../views/moneyManagement.dart';
import '../views/socialDetailScreen.dart';

class Routes {
  static List<GetPage> getPages() {
    return [
      GetPage(
          name: Paths.splashScreenPath,
          page: () => SplashScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: Paths.bottomNavBarScreenPath,
          page: () => BottomNavBarScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: Paths.moneyManagementPath,
          page: () => MoneyManagement(),
          binding: ScreenBindings()),
      GetPage(
          name: Paths.aiChatScreenPath,
          page: () => MoneyManagement(),
          binding: ScreenBindings()),
      GetPage(
          name: Paths.socialForumPath,
          page: () => SocialForum(),
          binding: ScreenBindings()),
      GetPage(
          name: Paths.loginScreenPath,
          page: () => LoginScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: Paths.signupScreenPath,
          page: () => SignupScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: Paths.forgotPassScreenPath,
          page: () => ForgotPassScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: Paths.goalScreenPath,
          page: () => GoalScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: Paths.savingScreenPath,
          page: () => SavingScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: Paths.memberScreenPath,
          page: () => MembersScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: Paths.innerSearchScreenPath,
          page: () => InnerSearchScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: Paths.memberRequestScreenPath,
          page: () => MemberRequestScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: Paths.socialDetailScreenPath,
          page: () => SocialDetailScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: Paths.loanManagementScreenPath,
          page: () => LoanManagementScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: Paths.loanHistoryScreenPath,
          page: () => LoanHistoryScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: Paths.loanContributeScreenPath,
          page: () => LoanContributeScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: Paths.myContributeScreenPath,
          page: () => MyContributesScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: Paths.myBudgetScreenPath,
          page: () => MyBudgetScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: Paths.requestFundsScreenPath,
          page: () => RequestFunds(),
          binding: ScreenBindings()),
      GetPage(
          name: Paths.myFundRequestScreenPath,
          page: () => MyFundRequestScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: Paths.fundRequestsScreenPath,
          page: () => FundRequests(),
          binding: ScreenBindings()),
    ];
  }
}
