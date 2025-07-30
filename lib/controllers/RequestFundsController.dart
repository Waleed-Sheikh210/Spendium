import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:hisab_kitab/Services/user_service.dart';

import '../Models/CategoriesModel.dart';
import '../Models/LoanCategoryModel.dart';
import '../Services/ExpenseServices.dart';
import '../Utils/utils.dart';

class RequestFundsController extends GetxController {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  RxnString selectedCategoryId = RxnString();

  RxList<CategoriesModel> categories = <CategoriesModel>[].obs;

  getCategories() {
    showLoading();
    getAllCategories(
      onSuccess: (data) {
        hideLoading();
        print(data);
        categories.value = data;
        // categories.value.insert(0, CategoriesModel(id: "0", name: "Add"));
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error.toString(),
            colorText: Colors.white, backgroundColor: Colors.red);
      },
    );
  }

  void submitForm() {
    if (
        // selectedCategoryId.value != null &&
        amountController.text.isNotEmpty && noteController.text.isNotEmpty) {
      showLoading();
      fundRequestAsk(
        category_id: "25",
        // selectedCategoryId.value.toString(),
        amount: amountController.text,
        note: noteController.text,
        onSuccess: (data) {
          hideLoading();
          Get.back();
          Get.snackbar("Success", "Fund Requested Successfully",
              colorText: Colors.white, backgroundColor: Colors.green);
        },
        onError: (error) {
          hideLoading();
          Get.snackbar("Error", error.toString(),
              colorText: Colors.white, backgroundColor: Colors.red);
        },
      );
    } else {
      Get.snackbar(
        "Error",
        "Please fill in all fields",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  void onInit() {
    getCategories();
    // TODO: implement onInit
    super.onInit();
  }
}
