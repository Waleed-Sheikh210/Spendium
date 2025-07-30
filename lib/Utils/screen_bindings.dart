import 'package:get/instance_manager.dart';
import 'package:hisab_kitab/controllers/LoginController.dart';
import 'package:hisab_kitab/controllers/SignupController.dart';
import 'package:hisab_kitab/controllers/forgotPassController.dart';

import '../controllers/BottomNavBarController.dart';
import '../controllers/FundRequestsController.dart';
import '../controllers/LoanContributeScreenController.dart';
import '../controllers/LoanHistoryScreenController.dart';
import '../controllers/LoanManagementScreenController.dart';
import '../controllers/MyBudgetScreenController.dart';
import '../controllers/MyContributesScreenController.dart';
import '../controllers/MyFundRequestScreenController.dart';
import '../controllers/RequestFundsController.dart';
import '../controllers/SocialDetailScreenController.dart';
import '../controllers/savingsController.dart';
import '../controllers/GoalScreenController.dart';
import '../controllers/HomeScreenController.dart';
import '../controllers/InnerSearchScreenController.dart';
import '../controllers/MemberRequestScreenController.dart';
import '../controllers/MemberScreenController.dart';
import '../controllers/MoneyManagementController.dart';
import '../controllers/SplashScreenController.dart';
import '../controllers/chatController.dart';
import '../controllers/socialForumController.dart';

class ScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashScreenController());
    Get.lazyPut(() => BottomNavBarController());
    Get.lazyPut(() => HomeScreenController());
    Get.lazyPut(() => MoneyManagementController());
    Get.lazyPut(() => ChatController());
    Get.lazyPut(() => SocialForumController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => SignupController());
    Get.lazyPut(() => ForgotPasswordController());
    Get.lazyPut(() => GoalScreenController());
    Get.lazyPut(() => SavingController());
    Get.lazyPut(() => MemberController());
    Get.lazyPut(() => InnerSearchScreenController());
    Get.lazyPut(() => MemberRequestScreenController());
    Get.lazyPut(() => SocialDetailScreenController());
    Get.lazyPut(() => LoanManagementScreenController());
    Get.lazyPut(() => LoanHistoryScreenController());
    Get.lazyPut(() => LoanContributeScreenController());
    Get.lazyPut(() => MyContributesScreenController());
    Get.lazyPut(() => MyBudgetScreenController());
    Get.lazyPut(() => RequestFundsController());
    Get.lazyPut(() => MyFundRequestScreenController());
    Get.lazyPut(() => FundRequestsController());

  }
}