import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Models/LoanHistoryModel.dart';
import 'package:hisab_kitab/Services/loanManagementService.dart';
import 'package:hisab_kitab/Utils/utils.dart';

class LoanHistoryScreenController extends GetxController {

  RxList<LoanHistoryModel> loanData = <LoanHistoryModel>[].obs;
  getAllLoan(){
    showLoading();
    getLoan(onSuccess: (data) {
      hideLoading();
      loanData.value = data;
    }, onError: (error) {

      hideLoading();
      Get.snackbar("Error", error,backgroundColor: Colors.red,colorText: Colors.white);
    },);
  }
  @override
  void onInit() {
    getAllLoan();
    super.onInit();
  }
}