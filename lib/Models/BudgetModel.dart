class BudgetModel {
  int? id;
  String? familyId;
  String? userId;
  String? categoryId;
  String? amount;
  String? createdAt;
  String? updatedAt;
  String? initialAmount;
  String? type;
  String? month;
  CategoryModel? category;
  BudgetModel(
      {this.id,
        this.familyId,
        this.userId,
        this.categoryId,
        this.amount,
        this.createdAt,
        this.updatedAt,
        this.initialAmount,
        this.type,
        this.category,
        this.month});

  BudgetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    familyId = json['family_id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    initialAmount = json['initial_amount'];
    type = json['type'];
    month = json['month'];

    category = json['category'] != null
        ? new CategoryModel.fromJson(json['category'])
        : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['family_id'] = this.familyId;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['initial_amount'] = this.initialAmount;
    data['type'] = this.type;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['month'] = this.month;
    return data;
  }
}


class CategoryModel {
  int? id;
  String? name;

  CategoryModel({this.id, this.name});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
