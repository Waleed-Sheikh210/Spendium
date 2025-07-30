

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../controllers/RequestFundsController.dart';

class RequestFunds extends GetWidget<RequestFundsController>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(title: const Text("Request Fund")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Category Dropdown
              Obx(
                      () {
                    return DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      value: controller.selectedCategoryId.value.toString(),
                      hint: const Text("Choose Category"),
                      items: controller.categories.map((cat) {
                        return DropdownMenuItem<String>(
                          value: cat.id.toString(),
                          child: Text(cat.name??""),
                        );
                      }).toList(),
                      onChanged: (val) {
                        controller.selectedCategoryId.value = val.toString();
                      },
                    );
                  }
              ),
              const SizedBox(height: 16),
          
              /// Amount TextField
              TextField(
                controller: controller.amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Amount",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
          
              /// Note TextField
              TextField(
                controller: controller.noteController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Note",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
          
              /// Submit Button
              ElevatedButton(
                onPressed: controller.submitForm,
                child: const Text("Submit Request"),
              ),
            ],
          ),
        ),
      ),
    );
  }

}