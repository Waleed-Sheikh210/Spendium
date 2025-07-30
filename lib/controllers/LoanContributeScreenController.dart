import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/LoanHistoryModel.dart';
import '../Services/loanManagementService.dart';
import '../Utils/utils.dart';

class LoanContributeScreenController extends GetxController {

  RxList<LoanHistoryModel> loanData = <LoanHistoryModel>[].obs;

  addContribution(
      {required String loanId, required String amount, required String note}) {
    showLoading();
    contributeLoan(loanId: loanId,
        amount: amount,
        note: note,
        onSuccess: (data) {
          hideLoading();
          Get.snackbar("Success", "Loan contribution added successfully",
              backgroundColor: Colors.green, colorText: Colors.white);
          getAllLoan();
        },
        onError: (error) {
          hideLoading();
          Get.snackbar(
              "Error", error, backgroundColor: Colors.red, colorText: Colors.white);
        },);
  }

  getAllLoan() {
    showLoading();
    getLoan(onSuccess: (data) {
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