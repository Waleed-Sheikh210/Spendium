import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../Models/MyContributeModel.dart';
import '../controllers/MyContributesScreenController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Models/LoanHistoryModel.dart';
class MyContributesScreen extends GetWidget<MyContributesScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Contributes'),
      ),
      body: Obx(() {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.loanData.value.length,
          itemBuilder: (context, index) {
            return _buildLoanContainer(controller.loanData.value[index]);
          },
        );
      }),
    );
  }

  Widget _buildLoanContainer(MyContributeModel loan) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Loan ID: ${loan.id}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text("Lender: ${loan.loan?.lender}"),
                Text("Amount: Rs. ${loan.loan?.amount}"),
                Text("Purpose: ${loan.loan?.purpose}"),
                Text("Due Date: ${loan.loan?.dueDate}"),
              ],
            ),
          ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color:loan.status.toString() == "pending" ? Colors.blue :loan.status.toString() == "approved" ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          child:
        Text(loan.status.toString(),style: TextStyle(color: Colors.white),)
        )
        ],
      ),
    );
  }
}