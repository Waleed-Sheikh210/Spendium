import 'package:hisab_kitab/Models/ExpensesModel.dart';
import 'package:hisab_kitab/Models/SavingHistoryModel.dart';

import '../Models/BaseModel.dart';
import '../Utils/Constants.dart';
import '../Utils/restApi.dart';

Future<void> getSavingHistory(
    {required Function(List<SavingHistoryModel> data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.savingsHistory,
      onSuccess: (BaseModel basemodel) {
        onSuccess((basemodel.data as List)
            .map((e) => SavingHistoryModel.fromJson(e))
            .toList());
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> getMySavingsAmount(
    {required Function(BaseModel data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.savingsMy,
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> addSavingAmount(
    {required String amount,
    required Function(BaseModel data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Post,
      endPoint: Constants.savingsAdd,
      body: {
        'amount': amount,
      },
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}
Future<void> transferAmount(
    {required String amount,
    required String id,
    required Function(BaseModel data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Post,
      endPoint: Constants.savingsAdd,
      body: {
        "goal_id": id,
        'amount': amount,
      },
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> myExpenses(
    {required Function(List<ExpensesModel> data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.myExpenses,
      onSuccess: (BaseModel basemodel) {
        onSuccess((basemodel.data as List)
            .map((e) => ExpensesModel.fromJson(e))
            .toList());
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> expensesFamily(
    {required Function(List<ExpensesModel> data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.expensesFamily,
      onSuccess: (BaseModel basemodel) {
        onSuccess((basemodel.data as List)
            .map((e) => ExpensesModel.fromJson(e))
            .toList());
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> budgetFamily(
    {required String amount,
    required Function(BaseModel data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Post,
      endPoint: Constants.budgetFamily,
      body: {
        'amount': amount,
      },
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> budgetAssigned(
    {required String amount,
    required String userId,
    required Function(BaseModel data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.budgetAssigned,
      body: {
        'amount': amount,
        "user_id": userId
      },
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> myBudget(
    {
    required Function(BaseModel data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.budgetFamily,
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> myAssignedBudget(
    {
    required Function(BaseModel data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.budgetAssigned,
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}
