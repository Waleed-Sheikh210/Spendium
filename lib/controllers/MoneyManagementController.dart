import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:hisab_kitab/Models/BudgetModel.dart';
import 'package:hisab_kitab/Models/CategoriesModel.dart';
import 'package:hisab_kitab/Models/ExpensesModel.dart';
import 'package:hisab_kitab/Services/savingServices.dart';

import '../Models/BudgetTransactionModel.dart';
import '../Models/FamilyMemberModel.dart';
import '../Services/ExpenseServices.dart';
import '../Services/user_service.dart';
import '../Utils/utils.dart';
import 'UserController.dart';

class MoneyManagementController extends GetxController {
  final RxString selectedType = 'Expense'.obs;
  final RxString selectedCategory = 'Food & Drinks'.obs;
  final RxString selectedAccount = 'Cash'.obs;
  final RxString selectedCategoryId = ''.obs;
  final RxInt budgetId = 0.obs;
  final RxDouble amount = 0.0.obs;
  final RxDouble budgetAmount = 0.0.obs;
  final RxDouble assignBudgetAmount = 0.0.obs;
  final userController = Get.find<UserController>();
  var members = <FamilyMemberModel>[].obs;
  Rxn<FamilyMemberModel> selectedMember = Rxn(FamilyMemberModel());
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  final assignBudgetController = TextEditingController();
  final amountController = TextEditingController();
  final budgetController = TextEditingController();
  RxList<BudgetModel> myBudgets = <BudgetModel>[].obs;
  final totalAmount = "0.0".obs;
  RxList<BudgetTransactionModel> budgetTransaction =
      <BudgetTransactionModel>[].obs;
  RxList<CategoriesModel> categories = <CategoriesModel>[].obs;

  final accounts = [
    'Cash',
    "Credit Card",
  ];

  final types = [
    "My Budget",
    "Add Budget",
    'Expense',
    'My Expenses',
    "Family Expenses",
    "Assign Budget",
  ];
  RxList<ExpensesModel> expenses = <ExpensesModel>[].obs;

  getMyExpenses() {
    showLoading();
    myExpenses(
      onSuccess: (data) {
        hideLoading();
        print(data);
        expenses.value = data;
      },
      onError: (error) {
        hideLoading();

        Get.snackbar("Error", error,
            backgroundColor: Colors.red, colorText: Colors.white);
      },
    );
  }

  getExpensesFamily() {
    showLoading();
    expensesFamily(
      onSuccess: (data) {
        print(data);
        hideLoading();
        expenses.value = data;
      },
      onError: (error) {
        hideLoading();

        Get.snackbar("Error", error,
            backgroundColor: Colors.red, colorText: Colors.white);
      },
    );
  }

  getMyFamilyMembers() {
    showLoading();
    getMyFamily(
      onSuccess: (data) {
        hideLoading();
        members.value = data;
        members.value.removeWhere((element) => element.role == "father");
        members.refresh();
      },
      onError: (error) {
        hideLoading();
        // Get.snackbar("Error", error.toString(),
        //     colorText: Colors.white, backgroundColor: Colors.red);
      },
    );
  }

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

  addBudget() {
    showLoading();
    budgetFamily(
      amount: budgetAmount.toString(),
      onSuccess: (data) {
        hideLoading();
        print(data);
        budgetController.clear();
        getFamilyBudget();

        Get.snackbar("Success", "Budget added successfully",
            colorText: Colors.white, backgroundColor: Colors.green);
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error.toString(),
            colorText: Colors.white, backgroundColor: Colors.red);
      },
    );
  }

  assignBudget() {
    showLoading();
    budgetAssigned(
      amount: assignBudgetAmount.toString(),
      userId: selectedMember.value!.user!.id.toString(),
      onSuccess: (data) {
        hideLoading();
        print(data);
        assignBudgetController.clear();
        getAssignBudget();

        Get.snackbar("Success", "Budget added successfully",
            colorText: Colors.white, backgroundColor: Colors.green);
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error.toString(),
            colorText: Colors.white, backgroundColor: Colors.red);
      },
    );
  }

  getCategories() {
    showLoading();
    getAllCategories(
      onSuccess: (data) {
        hideLoading();
        print(data);
        categories.value = data;
        categories.value.insert(0, CategoriesModel(id: "0", name: "Add"));
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error.toString(),
            colorText: Colors.white, backgroundColor: Colors.red);
      },
    );
  }

  addCategory(String name) {
    showLoading();
    categoriesAdd(
      name: name,
      onSuccess: (data) {
        categories.value.add(data);
        categories.refresh();
        hideLoading();
        Get.snackbar("Success", "Category added successfully",
            colorText: Colors.white, backgroundColor: Colors.green);
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error.toString(),
            colorText: Colors.white, backgroundColor: Colors.red);
      },
    );
  }

  getMyBudget() {
    showLoading();
    if (userController.user?.value?.role == "father") {
      myBudget(
        onSuccess: (data) {
          hideLoading();
          print(data);
          budgetId.value = (data.data as List).firstOrNull["id"] ?? 0;
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
          budgetId.value = (data.data["budgets"] as List).firstOrNull["id"] ?? 0;
        },
        onError: (error) {
          hideLoading();
          Get.snackbar("Error", error.toString(),
              colorText: Colors.white, backgroundColor: Colors.red);
        },
      );
    }
  }

  getFamilyBudget() {
    showLoading();
    myBudget(
      onSuccess: (data) {
        hideLoading();
        print(data);
        budgetTransaction.value = (data.data as List)
            .map((e) => BudgetTransactionModel.fromJson(e))
            .toList();
        budgetTransaction.refresh();
        // budgetId.valueasd = (data.data as List).firstOrNull["id"] ?? 0;
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error.toString(),
            colorText: Colors.white, backgroundColor: Colors.red);
      },
    );
  }

  getAssignBudget() {
    showLoading();
    myAssignedBudget(
      onSuccess: (data) {
        hideLoading();
        print(data);
        budgetTransaction.value = (data.data as List)
            .map((e) => BudgetTransactionModel.fromJson(e))
            .toList();
        budgetTransaction.refresh();
        // budgetId.valueasd = (data.data as List).firstOrNull["id"] ?? 0;
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error.toString(),
            colorText: Colors.white, backgroundColor: Colors.red);
      },
    );
  }

  addExpense() {
    createExpense(
      budget_id: budgetId.value.toString(),
      category_id: selectedCategoryId.value,
      title: titleController.text,
      amount: amountController.text,
      note: noteController.text,
      onSuccess: (data) {
        hideLoading();
        print(data);
        Get.snackbar("Success", "Expense added successfully",
            colorText: Colors.white, backgroundColor: Colors.green);
        amountController.clear();
        titleController.clear();
        noteController.clear();
        selectedCategoryId.value = "";
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
    getMyExpenses();
    if (userController.user?.value?.role == "father") {
      getExpensesFamily();
    }
    getCategories();
    getMyBudget();
    super.onInit();
  }
}
