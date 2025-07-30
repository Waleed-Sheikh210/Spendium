import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hisab_kitab/Services/savingServices.dart';

import '../Models/GoalsModel.dart';
import '../Models/SavingHistoryModel.dart';
import '../Services/goalsServices.dart';
import '../Utils/widgets.dart';

class SavingController extends GetxController {
  RxString totalSavings = "0.0".obs;
  RxInt selectedTab = 0.obs;
  RxString selectedGoalId = "0".obs;
  RxList<SavingHistoryModel> history = <SavingHistoryModel>[].obs;
  var goals = <Goal>[].obs;

  getMySavingHistory() {
    showLoading();
    getSavingHistory(
      onSuccess: (data) {
        hideLoading();
        history.value = data;
      },
      onError: (error) {
        Get.snackbar("Error", error);

        hideLoading();
      },
    );
  }

  getMySavings() {
    getMySavingsAmount(
      onSuccess: (data) {
        totalSavings.value = data.data["total"];
      },
      onError: (error) {
        Get.snackbar("Error", error);
      },
    );
  }

  void addSaving(String amount) {
    showLoading();
    addSavingAmount(
      amount: amount,
      onSuccess: (data) {
        hideLoading();
        Get.snackbar("Success", "Savings added successfully",
            backgroundColor: Colors.green, colorText: Colors.white);
        getMySavings();
        getMySavingHistory();
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error);
      },
    );
    // totalSavings.value += "3000";
  }

  void transferSaving({required String amount,required String id}) {
    transferAmount(
      amount: amount,
      id: id,
      onSuccess: (data) {
        Get.snackbar("Success", "Transferred successfully",
            backgroundColor: Colors.green, colorText: Colors.white);
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error,
            backgroundColor: Colors.red, colorText: Colors.white);
      },
    );
    // history.insert(0, SavingModel(title: "Transferred to Bank", date: "Today", amount: -2000));
    // totalSavings.value -= "2000";
  }

  getPersonalGoals() {
    showLoading();
    getGoalsPersonal(
      onSuccess: (data) {
        hideLoading();
        goals.value = data;
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error);
      },
    );
  }

  getFamilyGoals() {
    showLoading();
    getGoalsFamily(
      onSuccess: (data) {
        goals.value = data;
        hideLoading();
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
    getMySavings();
    getMySavingHistory();
    super.onReady();
  }
}
