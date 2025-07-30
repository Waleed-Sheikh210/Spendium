import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Utils/Prefs.dart';

import '../Utils/ColorUtils.dart';
import '../Utils/ImageUtils.dart';
import '../Utils/fontUtils.dart';
import '../Utils/paths.dart';
import '../Utils/widgets.dart';
import '../controllers/HomeScreenController.dart';

class HomeScreen extends GetWidget<HomeScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: Color(0xFFE6F7FB),
      appBar: AppBar(
        toolbarHeight: 80.h,
        leading: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: IconButton(
              onPressed: () {
                controller.scaffoldKey.currentState!
                    .openDrawer(); //controller.scaffoldKey
              },
              icon: Icon(Icons.menu)),
        ),
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text('Spendium', style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Color(0xFF20B2AA),
        // elevation: 0,
      ),
      drawer: _buildDrawer(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
                "Welcome, \n\"${controller.userController.user?.value?.name}\"",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 20.h,
            ),
            _buildAccountSection(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() {
                  return _buildBox(
                      title: "Total Budget",
                      amount: controller.analyticsData.value.totalBudget ?? "0",
                      color: Colors.blue);
                }),
                Obx(() {
                  return _buildBox(
                      title: "Total Loan",
                      amount: controller.analyticsData.value.totalLoan ?? "0",
                      color: Colors.red);
                }),
                Obx(() {
                  return _buildBox(
                      title: "Total Savings",
                      amount:
                          controller.analyticsData.value.totalSavings ?? "0",
                      color: Colors.green);
                }),
              ],
            ),
            SizedBox(height: 20),
            _buildExpenseChart(),
            SizedBox(height: 20),
            _buildRecentTransactions(),
            /*
            SizedBox(height: 20),
            _buildBudgetSection(),*/
          ],
        ),
      ),
    );
  }

  Widget _buildBox({
    required String title,
    required String amount,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        // height: 60.h,
        // width: 100.w,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "${amount.toString()}",
              style: TextStyle(
                fontSize: 16,
                color: color,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF20B2AA)),
            child: Center(
              child: Text(
                'Menu',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // _drawerItem(icon: Icons.group, label: 'Members'),
          _drawerItem(icon: Icons.flag, label: 'Goals'),
          _drawerItem(icon: Icons.savings, label: 'Saving'),
          _drawerItem(icon: Icons.money, label: 'Loan Management'),
          _drawerItem(icon: Icons.history, label: 'Loan History'),
          _drawerItem(icon: Icons.monetization_on, label: 'Loan Contribute'),
          _drawerItem(icon: Icons.handshake, label: 'My Contributes'),
          _drawerItem(
              icon: Icons.account_balance_wallet_rounded, label: 'My Budget'),
          if (controller.userController.user.value?.role.toString() != "father")
            _drawerItem(icon: Icons.request_page, label: 'Request funds'),
          if (controller.userController.user.value?.role.toString() != "father")
            _drawerItem(
                icon: Icons.local_library_sharp, label: 'My Fund Requests'),
          if (controller.userController.user.value?.role.toString() == "father")
            _drawerItem(
                icon: Icons.local_library_sharp, label: 'Fund Requests'),
          _drawerItem(icon: Icons.exit_to_app, label: 'Log out'),
        ],
      ),
    );
  }

  Widget _drawerItem({required IconData icon, required String label}) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(label),
      onTap: () {
        Get.back();

        switch (label) {
          // case 'Members':
          //   controller.scaffoldKey.currentState?.closeDrawer();
          //   Get.toNamed(Paths.memberScreenPath);
          //   break;
          case 'Goals':
            controller.scaffoldKey.currentState?.closeDrawer();
            Get.toNamed(Paths.goalScreenPath);
            break;
          case 'Loan Management':
            controller.scaffoldKey.currentState?.closeDrawer();
            Get.toNamed(Paths.loanManagementScreenPath);
            break;
          case 'Loan History':
            controller.scaffoldKey.currentState?.closeDrawer();
            Get.toNamed(Paths.loanHistoryScreenPath);
            break;
          case 'Saving':
            controller.scaffoldKey.currentState?.closeDrawer();
            Get.toNamed(Paths.savingScreenPath);
            break;
          case 'Loan Contribute':
            controller.scaffoldKey.currentState?.closeDrawer();
            Get.toNamed(Paths.loanContributeScreenPath);
            break;

          case 'My Contributes':
            controller.scaffoldKey.currentState?.closeDrawer();
            Get.toNamed(Paths.myContributeScreenPath);
            break;

          case 'My Budget':
            controller.scaffoldKey.currentState?.closeDrawer();
            Get.toNamed(Paths.myBudgetScreenPath);
            break;

          case 'My Fund Requests':
            controller.scaffoldKey.currentState?.closeDrawer();
            Get.toNamed(Paths.myFundRequestScreenPath);
            break;

          case 'Request funds':
            controller.scaffoldKey.currentState?.closeDrawer();
            Get.toNamed(Paths.requestFundsScreenPath);
            break;

          case 'Fund Requests':
            controller.scaffoldKey.currentState?.closeDrawer();
            Get.toNamed(Paths.fundRequestsScreenPath);
            break;

          case 'Log out':
            controller.scaffoldKey.currentState?.closeDrawer();
            Prefs.removeUser();
            Get.offAllNamed(Paths.loginScreenPath);
            break;
        }
      },
    );
  }

  Widget _buildAccountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Dashboard Overview and \nAnanlytics",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        // Text("Rs. ${controller.totalBalance.value.toString()}",
        //     style: TextStyle(
        //         fontSize: 32,
        //         fontWeight: FontWeight.bold,
        //         color: Colors.teal)),
        SizedBox(height: 12),
        /* Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _accountCard("Savings", controller.cash.value),
                _accountCard("Cash", controller.standardChartered.value),
                _accountCard("Allied Bank", controller.alliedBank.value),
              ],
            ),*/
      ],
    );
  }

  Widget _accountCard(String title, double amount) {
    return Column(
      children: [
        Icon(Icons.account_balance_wallet, color: Colors.teal),
        SizedBox(height: 4),
        Text(title, style: TextStyle(fontSize: 14)),
        Text("Rs. ${amount.toStringAsFixed(0)}",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildRecentTransactions() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Recent Transactions",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:
                  controller.analyticsData.value.last5Transactions?.length ?? 0,
              itemBuilder: (context, index) {
                final tx =
                    controller.analyticsData.value.last5Transactions![index];
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  margin: EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 3)
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tx.title ?? "",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              tx.note ?? "",
                              style: TextStyle(color: Colors.grey[600]),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Rs. ${tx.amount.toString()}',
                        style: TextStyle(
                          color: double.parse(tx.amount.toString()) >= 0
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ));
  }

  Widget _buildExpenseChart() {
    return Obx(() {
      if (controller.analyticsData.value.expenseByCategory == null) {
        return Text("No Expense Data");
      }

      return Column(
        children: [
          Text("Your Monthly Expense by Category",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sections: [
                  for (var i = 0;
                      i <
                          (controller.analyticsData.value.expenseByCategory
                                  ?.length ??
                              0);
                      i++)
                    PieChartSectionData(
                      value: double.parse(controller.analyticsData.value
                          .expenseByCategory![i].totalExpense
                          .toString()),
                      color: controller.fixedCategoryColors[i],
                      title: controller.analyticsData.value
                          .expenseByCategory![i].categoryName
                          .toString(),
                      // Optional: '${e.totalExpense.toStringAsFixed(0)}'
                      radius: 50,
                    ),
                ],
                // controller.analyticsData.value.expenseByCategory?.map((e) {
                //   return ;
                // }).toList(),
                centerSpaceRadius: 40,
                sectionsSpace: 2,
              ),
            ),
          ),
          SizedBox(height: 12),
          _buildExpenseLegend(),
        ],
      );
    });
  }

  Widget _buildExpenseLegend() {
    return Obx(() => Wrap(spacing: 10, runSpacing: 8, children: [
          for (int i = 0;
              i <
                  (controller.analyticsData.value.expenseByCategory?.length ??
                      0);
              i++)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle,
                    size: 12, color: controller.fixedCategoryColors[i]),
                SizedBox(width: 4),
                Text(
                    '${controller.analyticsData.value.expenseByCategory?[i].categoryName ?? ""} (Rs. ${controller.analyticsData.value.expenseByCategory?[i].totalExpense.toString()})'),
              ],
            )
        ]));
  }

  // Widget _buildExpenseChart() {
  //   return Obx(() => Column(
  //         children: [
  //           Text("Your Monthly Expense",
  //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  //           SizedBox(height: 12),
  //           SizedBox(
  //             height: 200,
  //             child: PieChart(
  //               PieChartData(
  //                 sections: [
  //                   PieChartSectionData(
  //                       value: controller.wedding.value,
  //                       color: Colors.cyan,
  //                       title: ''),
  //                   PieChartSectionData(
  //                       value: controller.utilities.value,
  //                       color: Colors.orange,
  //                       title: ''),
  //                   PieChartSectionData(
  //                       value: controller.medical.value,
  //                       color: Colors.pink,
  //                       title: ''),
  //                   PieChartSectionData(
  //                       value: controller.food.value,
  //                       color: Colors.lightBlue,
  //                       title: ''),
  //                 ],
  //                 centerSpaceRadius: 40,
  //                 sectionsSpace: 2,
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 12),
  //           _buildExpenseDetails(),
  //           // SizedBox(height: 12),
  //           // Text(
  //           //     "This month you spent Rs. ${controller.totalExpense.toStringAsFixed(0)}",
  //           //     style: TextStyle(fontSize: 16)),
  //         ],
  //       ));
  // }

  Widget _buildExpenseDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _expenseItem("Wedding", controller.wedding.value, Colors.cyan),
        _expenseItem("Utilities", controller.utilities.value, Colors.orange),
        _expenseItem("Medical", controller.medical.value, Colors.pink),
        _expenseItem("Food", controller.food.value, Colors.lightBlue),
      ],
    );
  }

  Widget _expenseItem(String label, double value, Color color) {
    return Column(
      children: [
        Icon(Icons.circle, color: color, size: 12),
        Text(label),
        Text("Rs. ${value.toStringAsFixed(0)}",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildBudgetSection() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your Budget",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Shopping",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: controller.shoppingSpent.value /
                        controller.shoppingBudget.value,
                    backgroundColor: Colors.grey[300],
                    color: Colors.teal,
                  ),
                  SizedBox(height: 8),
                  Text(
                      "Rs. ${controller.shoppingSpent.value.toStringAsFixed(0)} spent — Left: ${(controller.shoppingBudget.value - controller.shoppingSpent.value).toStringAsFixed(0)}"),
                ],
              ),
            )
          ],
        ));
  }
}
