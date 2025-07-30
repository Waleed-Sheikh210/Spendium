import 'package:hisab_kitab/Models/LoanHistoryModel.dart';
import 'package:hisab_kitab/Models/LoanModel.dart';

import '../Models/BaseModel.dart';
import '../Models/LoanCategoryModel.dart';
import '../Models/MyContributeModel.dart';
import '../Utils/Constants.dart';
import '../Utils/restApi.dart';

Future<void> createLoan(
    {required String categoryId,
    required String amount,
    required String purpose,
    required String dueDate,
    required String lender,

    required Function(BaseModel data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Post,
      endPoint: Constants.loansCreate,
      body: {
        'loan_category_id': categoryId,
        "lender": lender,
        "amount": amount,
        "purpose": purpose,
        "due_date": dueDate,
      },
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> getLoanCategories(
    {

    required Function(List<LoanCategoryModel> data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.loanCategories,

      onSuccess: (BaseModel basemodel) {
        onSuccess((basemodel.data as List).map((e) => LoanCategoryModel.fromJson(e)).toList());
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> getLoan(
    {

    required Function(List<LoanHistoryModel> data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.loans,

      onSuccess: (BaseModel basemodel) {
        onSuccess((basemodel.data as List).map((e) => LoanHistoryModel.fromJson(e)).toList());
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> contributeLoan(
    {
      required String loanId,
      required String amount,
      required String note,
    required Function(BaseModel data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Post,
      endPoint: Constants.loanContributionsOffer,
      body: {
        "loan_id": loanId,
        "amount": amount,
        "note": note,
      },

      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}

Future loanContributionsMy(
    {
    required Function(List<MyContributeModel> data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.loanContributionsMy,

      onSuccess: (BaseModel basemodel) {
        onSuccess((basemodel.data as List).map((e) => MyContributeModel.fromJson(e)).toList());
      },
      onError: (String error) {
        onError(error);
      });
}
