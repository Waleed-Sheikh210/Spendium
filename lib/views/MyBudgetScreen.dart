import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/MyBudgetScreenController.dart';

class MyBudgetScreen extends GetWidget<MyBudgetScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Budget'),
      ),
      body:Column(
        children: [
          SizedBox(height: 20.h,),
          Center(
            child: Text(
              "Total Remaining Budget",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              "${controller.totalAmount.value}",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20.h,),

          Obx(
                () =>
                controller.myBudgets.value.isEmpty
                    ? Center(child: Text("No Budget Data")):
                    Expanded(
              child: ListView.separated(
                itemCount: controller.myBudgets.value.length,
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemBuilder: (context, index) {
                  var data = controller.myBudgets.value[index];
                  return Container(
                    margin: const EdgeInsets.symmetric( horizontal: 12),
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
      )
    );
  }

}