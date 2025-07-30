import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Services/savingServices.dart';
import 'package:hisab_kitab/Services/user_service.dart';
import 'package:hisab_kitab/Utils/utils.dart';

import '../Models/AnalyticsModel.dart';
import '../Utils/ImageUtils.dart';
import 'UserController.dart';

class HomeScreenController extends GetxController {
  var totalBalance = "0".obs;
  var cash = 23600.0.obs;
  var standardChartered = 150600.0.obs;
  var alliedBank = 81400.0.obs;

  var wedding = 8700.0.obs;
  var utilities = 5000.0.obs;
  var medical = 3600.0.obs;
  var food = 3000.0.obs;

  double get totalExpense =>
      wedding.value + utilities.value + medical.value + food.value;

  var shoppingSpent = 7600.0.obs;
  var shoppingBudget = 25000.0.obs;
  Rx<AnalyticsModel> analyticsData = AnalyticsModel().obs;
  final userController = Get.find<UserController>();
  final Map<String, Color> fixedCategoryColors = {
    "Food": Colors.orange,
    "Transport": Colors.teal,
    "Bills": Colors.purple,
    "Shopping": Colors.blue,
  };
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var recentTransactions = <Transaction>[
    Transaction(title: 'Salary', amount: 2000003, source: 'Cash'),
    Transaction(title: 'Grocery', amount: -5400, source: 'Standard Chartered'),
    Transaction(title: 'Electric Bill', amount: -3200, source: 'Allied Bank'),
    Transaction(title: 'Bonus', amount: 45000, source: 'Cash'),
  ].obs;

  getMyBudget() {
    showLoading();
    if (userController.user?.value?.role == "father") {
      myBudget(
        onSuccess: (data) {
          hideLoading();
          print(data);
          totalBalance.value = (data.data as List).firstOrNull["amount"] ?? 0;
        },
        onError: (error) {
          hideLoading();
          Get.snackbar("Error", error.toString(),
              colorText: Colors.white, backgroundColor: Colors.red);
        },
      );
    } else {
      myAssignedBudget(
        onSuccess: (data) {
          hideLoading();
          print(data);
          totalBalance.value = (data.data["budgets"] as List).firstOrNull["amount"] ?? 0;
        },
        onError: (error) {
          hideLoading();
          Get.snackbar("Error", error.toString(),
              colorText: Colors.white, backgroundColor: Colors.red);
        },
      );
    }
  }

  getAnalytics() {
    analytics(
      onSuccess: (data) {
        hideLoading();
        log(data.toString(), name: "Analytics");
        analyticsData.value = data;
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
    getMyBudget();
    getAnalytics();
    // TODO: implement onReady
    super.onReady();
  }
}

class Transaction {
  final String title;
  final double amount;
  final String source;

  Transaction(
      {required this.title, required this.amount, required this.source});
}
