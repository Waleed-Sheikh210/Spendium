import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Models/MembersModel.dart';
import 'package:hisab_kitab/Utils/ColorUtils.dart';
import 'package:hisab_kitab/Utils/widgets.dart';

import '../controllers/MoneyManagementController.dart';

class MoneyManagement extends GetWidget<MoneyManagementController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80.h,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: const Text('Add Transactions',
              style: TextStyle(color: Colors.white)),
        ),
        centerTitle: true,
      ),
      // floatingActionButton: _buildSubmitButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: GestureDetector(
        onTap: () => Get.focusScope?.unfocus(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTransactionTypeSelector(),
            Expanded(
              child: Obx(() {
                return controller.selectedType.value == 'Add Budget'
                    ? _budgetView()
                    : controller.selectedType.value == 'Assign Budget'
                        ? _budgetAssignView()
                        : controller.selectedType.value == 'Expense'
                            ? SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildAmountInput(),
                                    // const SizedBox(height: 10),
                                    _buildTitleInput(),
                                    // const SizedBox(height: 10),
                                    _buildNoteInput(),
                                    const SizedBox(height: 10),
                                    _buildCategorySelector(),
                                    const SizedBox(height: 20),
                                    _buildAccountSelector(),
                                    const SizedBox(
                                        height: 100), // Leave space for button
                                  ],
                                ),
                              )
                            : controller.selectedType.value == "My Budget"
                                ? _buildBudgetList()
                                : _buildExpenseList();
              }),
            )
          ],
        ),
      ),
      bottomNavigationBar: _buildSubmitButton(),
    );
  }

  Widget _buildBudgetList() {
    return Column(
      children: [
        Text(
          "Total Remaining Budget",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
         Text(
          "${controller.totalAmount.value}",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),

        Obx(
          () =>
              controller.myBudgets.value.isEmpty
          ? Text("No Budget Data"):
              Expanded(
            child: ListView.builder(
              itemCount: controller.myBudgets.value.length,
              itemBuilder: (context, index) {
                var data = controller.myBudgets.value[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ID: ${data.id}",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text("Category: ${data.category?.name ?? ""}"),
                      const SizedBox(height: 8),
                      Text("Initial Amount: Rs ${data.initialAmount.toString()}"),
                      // const SizedBox(height: 4),
                      // Text("Total Amount: Rs ${controller.totalAmount.toString()}"),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _budgetAssignView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Assign Budget',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: TextFormField(
                controller: controller.assignBudgetController,
                // initialValue:
                //     controller.assignBudgetAmount.value.toStringAsFixed(0),
                onChanged: (val) {
                  final parsed = double.tryParse(val);
                  if (parsed != null)
                    controller.assignBudgetAmount.value = parsed;
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Rs. 0',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() {
              return MemberDropdown(
                members: controller.members.value,
                onChanged: (value) {
                  controller.selectedMember.value = value!;
                  controller.update();
                },
              );
            }),
          )
        ],
      ),
    );
  }

  Widget _budgetView() {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Add Budget',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: TextFormField(
                controller: controller.budgetController,
                onChanged: (val) {
                  final parsed = double.tryParse(val);
                  if (parsed != null) controller.budgetAmount.value = parsed;
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Rs. 0',
                ),
              ),
            ),
          ),
          TabBar(
            labelColor: Colors.teal,
            unselectedLabelColor: Colors.black54,
            onTap: (value) {
              if (value == 0) {
                controller.getFamilyBudget();
              } else {
                controller.getAssignBudget();
              }
            },
            tabs: [
              Tab(
                text: 'Family Budget',
              ),
              Tab(text: 'Assign Budget'),
            ],
          ),
          SizedBox(
            height: 300, // Adjust height as needed
            child: TabBarView(
              children: [
                // Family Budget Tab
                ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.budgetTransaction.value.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final tx = controller.budgetTransaction.value[index];
                    return _budgetItem(tx);
                  },
                ),

                // Assign Budget Tab
                ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.budgetTransaction.value.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final tx = controller.budgetTransaction.value[index];
                    final userName = tx.user?.name ?? 'N/A';
                    final initialAmount = tx.initialAmount ?? '0';

                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.indigo[50],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 4)
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Family ID: ${tx.familyId}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 6),
                          Text("User: $userName",
                              style: TextStyle(fontSize: 15)),
                          SizedBox(height: 6),
                          Text("Amount: Rs. ${tx.amount}",
                              style: TextStyle(fontSize: 15)),
                          SizedBox(height: 6),
                          Text("Initial Amount: Rs. $initialAmount",
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _budgetItem(dynamic tx) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Family ID: ${tx.familyId}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          SizedBox(height: 4),
          Text("Amount: Rs. ${tx.amount}", style: TextStyle(fontSize: 16)),
          SizedBox(height: 4),
          Text("Initial Amount: ${tx.initialAmount ?? '1000'}",
              style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildExpenseList() {
    return controller.expenses.value.isEmpty
        ? const Center(child: Text("No expenses found"))
        : ListView.separated(
            padding: EdgeInsets.only(bottom: 30.h),
            itemCount: controller.expenses.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final item = controller.expenses.value[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title ?? "",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 3),
                      Text("Amount: Rs. ${item.amount?.toString()}",
                          style: const TextStyle(fontSize: 16)),
                      Text("Date: ${item.date}",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.grey)),
                      // if (item.note.isNotEmpty)
                      Text("Note: ${item.note}",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black87)),
                    ],
                  ),
                ),
              );
            },
          );
  }

  Widget _buildTransactionTypeSelector() {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Wrap(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: controller.types.map((type) {
              final isSelected = controller.selectedType.value == type;
              return Padding(
                padding: EdgeInsets.only(right: 7.0),
                child: ChoiceChip(
                  label: Text(type),
                  selected: isSelected,
                  onSelected: (_) {
                    if (type == "My Budget") {
                      controller.selectedType.value = type;
                      controller.getMyBudgetAssigned();
                    } else if (type == 'My Expenses') {
                      controller.selectedType.value = type;

                      controller.getMyExpenses();
                    } else if (type == 'Assign Budget') {
                      if (controller.userController.user.value!.role
                              .toString() ==
                          "father") {
                        controller.selectedType.value = type;

                        controller.getMyFamilyMembers();
                      } else {
                        Get.snackbar("Error", "Only father can assign budget",
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      }
                    } else if (type == 'Family Expenses') {
                      if (controller.userController.user.value!.role
                              .toString() ==
                          "father") {
                        controller.selectedType.value = type;

                        controller.getExpensesFamily();
                      } else {
                        Get.snackbar("Error", "Only father can assign budget",
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      }
                    } else if (type == 'Add Budget') {
                      if (controller.userController.user.value!.role
                              .toString() ==
                          "father") {
                        controller.selectedType.value = type;

                        controller.getFamilyBudget();
                        controller.getAssignBudget();
                      } else {
                        Get.snackbar("Error", "Only father can assign budget",
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      }
                    }
                    controller.getMyBudget();
                  },
                  selectedColor: Colors.teal[300],
                  backgroundColor: Colors.grey[200],
                  labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black),
                ),
              );
            }).toList(),
          ),
        ));
  }

  Widget _buildAmountInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: TextFormField(
          controller: controller.amountController,
          // initialValue: controller.amount.value.toStringAsFixed(0),
          onChanged: (val) {
            final parsed = double.tryParse(val);
            if (parsed != null) controller.amount.value = parsed;
          },
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Rs. 0',
          ),
        ),
      ),
    );
  }

  Widget _buildTitleInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller.titleController,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter title',
        ),
      ),
    );
  }

  Widget _buildNoteInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller.noteController,
        maxLines: 3,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Add a note (optional)',
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Category",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: controller.categories.value.map((category) {
                  final isSelected =
                      controller.selectedCategory.value == category.name;
                  return GestureDetector(
                    onTap: () {
                      controller.selectedCategory.value = category.name!;
                      if (controller.selectedCategory.value == "Add") {
                        showNamePopup(Get.context!, (data) {
                          print(data);
                          controller.addCategory(data);
                        });
                      } else {
                        controller.selectedCategory.value = category.name!;
                        controller.selectedCategoryId.value =
                            category.id.toString();
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        category.name == "Add"
                            ? CircleAvatar(
                                backgroundColor: Colors.lightBlue,
                                radius: 25,
                                child: Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor:
                                    isSelected ? Colors.teal : Colors.grey[200],
                                radius: 25,
                                child: Icon(
                                  Icons.category,
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                        const SizedBox(height: 4),
                        Text(category.name ?? "",
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ));
  }

  Widget _buildAccountSelector() {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Account",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              Wrap(
                  spacing: 16,
                  children: controller.accounts.map((account) {
                    final isSelected =
                        controller.selectedAccount.value == account;
                    return GestureDetector(
                      onTap: () => controller.selectedAccount.value = account,
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                isSelected ? Colors.teal : Colors.grey[200],
                            radius: 22,
                            child: Icon(
                                account == "Cash"
                                    ? Icons.account_balance_wallet
                                    : Icons.credit_card,
                                color:
                                    isSelected ? Colors.white : Colors.black),
                          ),
                          const SizedBox(height: 4),
                          Text(account, style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    );
                  }).toList()),
            ],
          ),
        ));
  }

  Widget _buildSubmitButton() {
    return Obx(() {
      return controller.selectedType.value == 'Add Budget'
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 65.h,
                  ),
                  child: MyButton(
                    onPress: () {
                      // You can handle submission here
                      if (controller.budgetController.text.trim().isEmpty) {
                        Get.snackbar("Error", "Amount cannot be zero",
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                        return;
                      }
                      controller.addBudget();
                    },
                    color: ColorUtils.teal,
                    text: "Add Budget",
                  ),
                ),
              ],
            )
          : controller.selectedType.value == 'Expense'
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 65.h,
                      ),
                      child: MyButton(
                        onPress: () {
                          if (controller.amountController.text.trim().isEmpty) {
                            Get.snackbar("Error", "Amount cannot be zero",
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                            return;
                          }
                          if (controller.selectedCategory.value == null) {
                            Get.snackbar("Error", "Please Select Category",
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                            return;
                          }
                          if (controller.titleController.text.trim().isEmpty) {
                            Get.snackbar("Error", "Please Enter Title",
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                            return;
                          }
                          if (controller.noteController.text.trim().isEmpty) {
                            Get.snackbar("Error", "Please Enter Note",
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                            return;
                          }

                          if (controller.budgetId.value == 0) {
                            Get.snackbar("Error", "Please Add Budget First",
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                            return;
                          }
                          controller.addExpense();
                        },
                        color: ColorUtils.teal,
                        text: "Submit",
                      ),
                    ),
                  ],
                )
              : controller.selectedType.value == 'Assign Budget'
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 65.h,
                          ),
                          child: MyButton(
                            onPress: () {
                              print("object");
                              // You can handle submission here
                              if (controller.assignBudgetController.text
                                  .trim()
                                  .isEmpty) {
                                Get.snackbar("Error", "Amount cannot be zero",
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white);
                                return;
                              }
                              if (controller.selectedMember.value?.user ==
                                  null) {
                                Get.snackbar("Error", "Member is required",
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white);
                                return;
                              }
                              controller.assignBudget();
                            },
                            color: ColorUtils.teal,
                            text: "Assign Budget",
                          ),
                        ),
                      ],
                    )
                  : SizedBox();
    });
  }

  void showNamePopup(BuildContext context, Function(String) onNameEntered) {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter Name"),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: "Enter your name",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close dialog
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                onNameEntered(nameController.text);
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }
}

class RandomIconCircle extends StatelessWidget {
  final bool isSelected;

  RandomIconCircle({required this.isSelected});

  final List<IconData> _icons = [
    Icons.star,
    Icons.work,
    Icons.home,
    Icons.school,
    Icons.flight,
    Icons.favorite,
    Icons.shopping_cart,
    Icons.pets,
    Icons.directions_car,
    Icons.sports_soccer,
  ];

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final icon = _icons[random.nextInt(_icons.length)];

    return CircleAvatar(
      backgroundColor: isSelected ? Colors.teal : Colors.grey[200],
      radius: 25,
      child: Icon(
        icon,
        color: isSelected ? Colors.white : Colors.black,
      ),
    );
  }
}
