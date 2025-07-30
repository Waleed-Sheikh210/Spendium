import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:hisab_kitab/Models/LoanCategoryModel.dart';
import 'package:hisab_kitab/Services/loanManagementService.dart';
import 'package:hisab_kitab/Utils/utils.dart';
import 'package:intl/intl.dart';

class LoanManagementScreenController extends GetxController {
  final lenderController = TextEditingController();
  final amountController = TextEditingController();
  final purposeController = TextEditingController();
  final dueDateController = TextEditingController();

  RxnInt selectedCategoryId = RxnInt();

  RxList<LoanCategoryModel> loanCategories = <LoanCategoryModel>[].obs;

  Future<void> pickDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      dueDateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  void submitLoan() {
    final data = {
      "loan_category_id": selectedCategoryId,
      "lender": lenderController.text,
      "amount": int.tryParse(amountController.text) ?? 0,
      "purpose": purposeController.text,
      "due_date": dueDateController.text,
    };
    if (selectedCategoryId.value == null) {
      Get.snackbar(
        "Error",
        "Please select loan category",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (lenderController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter lender name",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (amountController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter amount",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (purposeController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter purpose",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (dueDateController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter due date",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    showLoading();
    print("Submitted Loan Data: $data");
    addLoan();
    // Send to API or handle locally
  }

  addLoan() {
    createLoan(
      categoryId: selectedCategoryId.value.toString(),
      amount: amountController.text,
      purpose: purposeController.text,
      dueDate: dueDateController.text,
      lender: lenderController.text,
      onSuccess: (data) {
        hideLoading();
        Get.back();

        Get.snackbar(
          "Success",
          "Loan created successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      },
      onError: (error) {
        hideLoading();
        Get.snackbar(
          "Error",
          error,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      },
    );
  }

  getCategory() {
    showLoading();
    getLoanCategories(
      onSuccess: (data) {
        loanCategories.value = data;
        hideLoading();
      },
      onError: (error) {
        hideLoading();
        Get.snackbar(
          "Error",
          error,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      },
    );
  }

  @override
  void onInit() {
    getCategory();
    // TODO: implement onInit
    super.onInit();
  }
}
