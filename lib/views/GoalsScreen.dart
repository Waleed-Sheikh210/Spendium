import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../Models/GoalsModel.dart';
import '../controllers/savingsController.dart';
import '../controllers/GoalScreenController.dart';

class GoalScreen extends GetWidget<GoalScreenController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          controller.tabController.value = DefaultTabController.of(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text("My Goals"),
              bottom: TabBar(
                controller: controller.tabController.value,
                onTap: (index) {
                  controller.tabController.value!.animateTo(index);
                },
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3,
                indicatorPadding: const EdgeInsets.all(5),
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 14,
                ),
                tabs: [
                  Tab(
                    text: "Family",
                  ),
                  Tab(text: "My Goals"),
                ],
              ),
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildGoalList(
                  title: "Family",
                  goals: controller.familyGoals,
                  onCreate: () => _showCreateGoalDialog("Family"),
                ),
                _buildGoalList(
                  title: "My Goals",
                  goals: controller.personalGoals,
                  onCreate: () => _showCreateGoalDialog("My Goals"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGoalList({
    required String title,
    required RxList<Goal> goals,
    required VoidCallback onCreate,
  }) {
    return Stack(
      children: [
        Obx(() {
          if (controller.userController.user.value?.role != "father" &&
              title == "Family") {
            return const Center(
                child: Text("You are not allowed to view Family Goals"));
          }
          if (goals.isEmpty) {
            return const Center(child: Text("No goals added."));
          }

          return ListView.builder(
            itemCount: goals.length,
            padding: const EdgeInsets.only(bottom: 80),
            itemBuilder: (context, index) {
              final goal = goals[index];
              return GoalCard(goal: goal); // <-- use this instead of ListTile
            },
          );
        }),

        controller.userController.user.value?.role != "father" &&
            title == "Family" ? const SizedBox() :
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: onCreate,
              child: const Icon(Icons.add),
            ),
          ),
      ],
    );
  }

  void _showCreateGoalDialog(String category) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();

    Get.defaultDialog(
      title: "Create $category Goal",
      content: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: "Title"),
          ),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Amount"),
          ),
        ],
      ),
      textConfirm: "Create",
      textCancel: "Cancel",
      onConfirm: () {
        final title = titleController.text.trim();
        final amount = double.tryParse(amountController.text.trim()) ?? 0.0;
        if (title.isEmpty || amount <= 0) {
          Get.snackbar("Invalid", "Please enter valid data");
          return;
        }

        if (category == "Family") {
          controller.addFamilyGoal(title, amount);
        } else {
          controller.addPersonalGoal(title, amount);
        }
        Get.back();
      },
    );
  }
}

class GoalCard extends StatelessWidget {
  final Goal goal;

  const GoalCard({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        title: Text(
          goal.title ??"",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        trailing: Text(
          "\$${goal.amount??0}",
          style: const TextStyle(
            fontSize: 16,
            color: Colors.green,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
