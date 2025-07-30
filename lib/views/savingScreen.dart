import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Utils/utils.dart';

import '../controllers/savingsController.dart';

class SavingScreen extends GetWidget<SavingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Savings")),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Obx(() => Text(
                "PKR ${controller.totalSavings.value}",
                style:
                    const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              )),
          const SizedBox(height: 8),
          const Text("My Savings",
              style: TextStyle(fontSize: 18, color: Colors.grey)),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Transfer History",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.history.length,
                  itemBuilder: (context, index) {
                    final item = controller.history[index];
                    final isNegative = item.type == "add" ? false : true;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                        child: ListTile(
                          title: Text(
                              formatDateAndTime(
                                  dateString:
                                      DateTime.parse(item.createdAt.toString())
                                          .toLocal()
                                          .toString(),
                                  dateFormat: "dd MMM, yyyy hh:mm a"),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                          // subtitle: Text(item.date),
                          trailing: Text(
                            "${isNegative ? '-' : '+'} PKR ${item.amount}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: isNegative ? Colors.red : Colors.green,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showAmountDialog(context, (amount) {
                        controller.addSaving(amount);
                      });
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    label: const Text("Add Saving",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showTransferDialog(
                        context: context,

                        onSubmit: (amount, selectedGoalId) {
                          controller.transferSaving(amount: amount, id: selectedGoalId);
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    label: const Text("Transfer Saving",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showAmountDialog(
      BuildContext context, void Function(String amount) onSubmit) {
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter Amount"),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Amount",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final amount = amountController.text.trim();
                Navigator.pop(context);
                onSubmit(amount);
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  void _showTransferDialog({
    required BuildContext context,
    required void Function(
            String amount, String selectedGoalId)
        onSubmit,
  }) {
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Transfer Savings"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Toggle Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Obx(
                       () {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.selectedTab.value == 1
                                ? Colors.blue
                                : Colors.grey[300],
                          ),
                          onPressed: () {
                            controller.selectedTab.value = 1;
                            controller.goals.value = [];
                            controller.getFamilyGoals();
                          },
                          child:  Text("Family Goal",style: TextStyle(color:controller.selectedTab.value == 1 ? Colors.white : Colors.black ),),
                        );
                      }
                    ),
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    child: Obx(
                       () {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.selectedTab.value == 2
                                ? Colors.blue
                                : Colors.grey[300],
                          ),
                          onPressed: () {
                            controller.selectedTab.value = 2;
                            controller.goals.value = [];
                            controller.getPersonalGoals();
                          },
                          child:  Text("Personal Goal",style: TextStyle(color:controller.selectedTab.value == 2 ? Colors.white : Colors.black ),),
                        );
                      }
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Amount Text Field
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Amount",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Goal Dropdown
              Obx(() {
                return DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Select Goal',
                    border: OutlineInputBorder(),
                  ),
                  value:  controller.selectedGoalId.value,
                  items:
                       controller.goals.value
                          .map((goal) => DropdownMenuItem(
                                value: goal.id.toString(),
                                child: Text(goal.title.toString()!),
                              ))
                          .toList()
                     ,
                  onChanged: (value) {
                    controller.selectedGoalId.value =  controller.goals.value
                            .firstWhere((goal) => goal.id.toString() == value)
                            .id.toString();
                  },
                );
              }),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.selectedTab.value = 0;
                    Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final amount = amountController.text.trim();
                if(amount.isEmpty){
                  Get.snackbar("Error", "Amount is required",colorText: Colors.white,backgroundColor: Colors.red);
                  return;
                }
                if(controller.selectedGoalId.value == null){
                  Get.snackbar("Error", "Goal is required",colorText: Colors.white,backgroundColor: Colors.red);
                  return;
                }
                if (amount.isNotEmpty &&  controller.selectedGoalId.value != null) {
                  Navigator.pop(context);
                  onSubmit(amount,  controller.selectedGoalId.value!);
                }
              },
              child: const Text("Transfer"),
            ),
          ],
        );
      },
    );
  }
}
