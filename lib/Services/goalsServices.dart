
import 'package:hisab_kitab/Models/GoalsModel.dart';

import '../Models/BaseModel.dart';
import '../Utils/Constants.dart';
import '../Utils/restApi.dart';

Future<void> createFamilyGoal(
    {
      required String title,
      required String amount,
      required Function(BaseModel baseModel) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Post,
      endPoint: Constants.createFamilyGoal,
      body: {
        'title': title,
        'amount': amount,
      },
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}
Future<void> createPersonalGoal(
    {
      required String title,
      required String amount,
      required Function(BaseModel baseModel) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Post,
      endPoint: Constants.createPersonalGoal,
      body: {
        'title': title,
        'amount': amount,
      },
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}
Future<void> getGoalsPersonal(
    {
      required Function(List<Goal> baseModel) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.goalsPersonal,
      onSuccess: (BaseModel basemodel) {
        onSuccess((basemodel.data as List).map((e) => Goal.fromJson(e)).toList());
      },
      onError: (String error) {
        onError(error);
      });
}Future<void> getGoalsFamily(
    {
      required Function(List<Goal> baseModel) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.goalsFamily,
      onSuccess: (BaseModel basemodel) {
        onSuccess((basemodel.data as List).map((e) => Goal.fromJson(e)).toList());
      },
      onError: (String error) {
        onError(error);
      });
}