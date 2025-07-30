import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../controllers/LoanManagementScreenController.dart';

class LoanManagementScreen extends GetWidget<LoanManagementScreenController>{
  @override
  Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(title: const Text('Add Loan')),
  body: SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Select Loan Category"),
        const SizedBox(height: 8),
        Obx(
           () {
            return DropdownButtonFormField<int>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              value: controller.selectedCategoryId.value,
              hint: const Text("Choose Category"),
              items: controller.loanCategories.map((cat) {
                return DropdownMenuItem<int>(
                  value: cat.id,
                  child: Text(cat.name??""),
                );
              }).toList(),
              onChanged: (val) {
             controller.selectedCategoryId.value = val;
              },
            );
          }
        ),
        const SizedBox(height: 16),

        TextFormField(
          controller: controller.lenderController,
          decoration: const InputDecoration(
            labelText: 'Lender',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),

        TextFormField(
          controller: controller.amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Amount',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),

        TextFormField(
          controller: controller.purposeController,
          decoration: const InputDecoration(
            labelText: 'Purpose',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),

        TextFormField(
          controller: controller.dueDateController,
          readOnly: true,
          onTap: () => controller.pickDueDate(context),
          decoration: const InputDecoration(
            labelText: 'Due Date',
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.calendar_today),
          ),
        ),
        const SizedBox(height: 24),

        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(500, 50),
              // foregroundColor: const Color(0xFF20B2AA),
            ),
            onPressed: controller.submitLoan,
            child: const Text("Submit Loan"),
          ),
        ),
      ],
    ),
  ),
);
  }

}