import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Services/goalsServices.dart';
import 'package:hisab_kitab/Utils/widgets.dart';
import 'package:hisab_kitab/controllers/UserController.dart';

import '../Models/GoalsModel.dart';
import 'savingsController.dart';

class GoalScreenController extends GetxController {
  final userController = Get.find<UserController>();
  final tabController = Rx<TabController?>(null);
  var familyGoals = <Goal>[].obs;
  var personalGoals = <Goal>[].obs;

  void addFamilyGoal(String title, double amount) {
    // familyGoals.add(Goal(title: title, amount: amount));
    showLoading();
    createFamilyGoal(
      title: title,
      amount: amount.toString(),
      onSuccess: (baseModel) {
        hideLoading();
        print(baseModel);
        familyGoals.add(Goal.fromJson(baseModel.data));
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error);

      },
    );
  }

  void addPersonalGoal(String title, double amount) {
    showLoading();
    createPersonalGoal(
      title: title,
      amount: amount.toString(),
      onSuccess: (baseModel) {
        hideLoading();
        print(baseModel);
        personalGoals.add(Goal.fromJson(baseModel.data));
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error);

      },
    );
  }

  getGoals() {
    showLoading();
    getGoalsPersonal(
      onSuccess: (data) {
        personalGoals.value = data;
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error);

      },
    );
    getGoalsFamily(
      onSuccess: (data) {
        familyGoals.value = data;
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

    getGoals();
    super.onReady();
  }
}
