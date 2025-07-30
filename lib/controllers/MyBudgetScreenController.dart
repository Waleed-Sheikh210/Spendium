import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/BudgetModel.dart';
import '../Services/user_service.dart';
import '../Utils/utils.dart';

class MyBudgetScreenController extends GetxController{

  RxList<BudgetModel> myBudgets = <BudgetModel>[].obs;
  final totalAmount = "0.0".obs;
  getMyBudgetAssigned() {
    showLoading();
    getMyAssignedBudget(
      onSuccess: (data) {
        hideLoading();
        myBudgets.value = (data.data["budgets"] as List)
            .map((e) => BudgetModel.fromJson(e))
            .toList();
        myBudgets.refresh();
        totalAmount.value = data.data["total_amount"].toString();
        totalAmount.refresh();
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error.toString(),
            colorText: Colors.white, backgroundColor: Colors.red);
      },
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getMyBudgetAssigned();
    super.onInit();
  }

}