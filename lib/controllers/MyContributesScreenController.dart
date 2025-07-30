import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Models/MyContributeModel.dart';

import '../Models/LoanHistoryModel.dart';
import '../Services/loanManagementService.dart';
import '../Utils/utils.dart';
class MyContributesScreenController extends GetxController{

  RxList<MyContributeModel> loanData = <MyContributeModel>[].obs;


  getAllLoan() {
    showLoading();
    loanContributionsMy(onSuccess: (data) {
      hideLoading();
      loanData.value = data;
    }, onError: (error) {
      hideLoading();
      Get.snackbar(
          "Error", error, backgroundColor: Colors.red, colorText: Colors.white);
    },);
  }

  @override
  void onInit() {
    getAllLoan();
    super.onInit();
  }
}