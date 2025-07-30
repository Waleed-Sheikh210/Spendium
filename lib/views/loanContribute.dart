import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../Models/LoanHistoryModel.dart';
import '../controllers/LoanContributeScreenController.dart';

class LoanContributeScreen extends GetWidget<LoanContributeScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Contribute'),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Loan ID: ${loan.id}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text("Lender: ${loan.lender}"),
                Text("Amount: Rs. ${loan.amount}"),
                Text("Purpose: ${loan.purpose}"),
                Text("Due Date: ${loan.dueDate}"),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                _showAmountDialog(Get.context!, (amount, note) {
                  print("Amount: $amount");
                  print("Note: $note");

                  controller.addContribution(loanId: loan.id.toString(), amount: amount, note: note);
                });
              },
              child: Text("Contribute"))
        ],
      ),
    );
  }

  void _showAmountDialog(BuildContext context,
      void Function(String amount, String note) onSubmit) {
    final TextEditingController amountController = TextEditingController();
    final TextEditingController noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter Amount"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Amount",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: noteController,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Notes",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final amount = amountController.text.trim();
                final notes = noteController.text.trim();
                if(amount.isEmpty){
                  Get.snackbar("Error", "Please enter amount", backgroundColor: Colors.red,colorText: Colors.white);
                  return;
                }
                if(notes.isEmpty){
                  Get.snackbar("Error", "Please enter notes", backgroundColor: Colors.red,colorText: Colors.white);
                  return;
                }
                Navigator.pop(context);

                onSubmit(amount, notes);
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }
}
