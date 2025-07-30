class BudgetTransactionModel {
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
  User? user;
  Category? category;

  BudgetTransactionModel(
      {this.id,
        this.familyId,
        this.userId,
        this.categoryId,
        this.amount,
        this.createdAt,
        this.updatedAt,
        this.initialAmount,
        this.type,
        this.month,
        this.user,
        this.category});

  BudgetTransactionModel.fromJson(Map<String, dynamic> json) {
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
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
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
    data['month'] = this.month;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;

  User({this.id, this.name, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
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
