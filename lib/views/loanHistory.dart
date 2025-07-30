import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Models/LoanHistoryModel.dart';

import '../controllers/LoanHistoryScreenController.dart';

class LoanHistoryScreen extends GetWidget<LoanHistoryScreenController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan History'),
      ),
      body: Obx(
         () {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.loanData.value.length,
            itemBuilder: (context, index) {
              return _buildLoanContainer(controller.loanData.value[index]);
            },
          );
        }
      ),
    );
  }

  Widget _buildLoanContainer(LoanHistoryModel loan) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Loan ID: ${loan.id}", style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text("Lender: ${loan.lender}"),
          Text("Amount: Rs. ${loan.amount}"),
          Text("Purpose: ${loan.purpose}"),
          Text("Due Date: ${loan.dueDate}"),
        ],
      ),
    );
  }

}