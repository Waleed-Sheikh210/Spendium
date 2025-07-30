import '../Models/CategoriesModel.dart';
import '../Utils/Constants.dart';
import '../Models/BaseModel.dart';
import '../Utils/restApi.dart';

Future<void> getAllCategories(
    {required Function(List<CategoriesModel> data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.categoriesAll,
      onSuccess: (BaseModel basemodel) {
        onSuccess((basemodel.data["custom"] as List)
            .map((e) => CategoriesModel.fromJson(e))
            .toList());
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> categoriesAdd(
    {required String name,
    required Function(CategoriesModel data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Post,
      endPoint: Constants.categoriesAdd,
      body: {'name': name},
      onSuccess: (BaseModel basemodel) {
        onSuccess(CategoriesModel.fromJson(basemodel.data));
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> createExpense(
    {required String budget_id,
      required String category_id,
    required String title,
    required String amount,
    required String note,
    required Function(CategoriesModel data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Post,
      endPoint: Constants.expensesAdd,
      body: {
        'budget_id': budget_id,
        'category_id': category_id,
        'title': title,
        'amount': amount,
        'note': note,
        'date': DateTime.now().toString().split(" ")[0],
      },
      onSuccess: (BaseModel basemodel) {
        onSuccess(CategoriesModel.fromJson(basemodel.data));
      },
      onError: (String error) {
        onError(error);
      });
}
