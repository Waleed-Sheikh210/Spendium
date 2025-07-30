class ContributeModel {
  int? id;
  String? familyId;
  String? loanCategoryId;
  String? lender;
  String? amount;
  String? purpose;
  String? remainingAmount;
  String? status;
  String? dueDate;
  String? createdAt;
  String? updatedAt;
  Category? category;

  ContributeModel(
      {this.id,
        this.familyId,
        this.loanCategoryId,
        this.lender,
        this.amount,
        this.purpose,
        this.remainingAmount,
        this.status,
        this.dueDate,
        this.createdAt,
        this.updatedAt,
        this.category});

  ContributeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    familyId = json['family_id'];
    loanCategoryId = json['loan_category_id'];
    lender = json['lender'];
    amount = json['amount'];
    purpose = json['purpose'];
    remainingAmount = json['remaining_amount'];
    status = json['status'];
    dueDate = json['due_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['family_id'] = this.familyId;
    data['loan_category_id'] = this.loanCategoryId;
    data['lender'] = this.lender;
    data['amount'] = this.amount;
    data['purpose'] = this.purpose;
    data['remaining_amount'] = this.remainingAmount;
    data['status'] = this.status;
    data['due_date'] = this.dueDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? userId;
  String? familyId;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
        this.name,
        this.userId,
        this.familyId,
        this.createdAt,
        this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    familyId = json['family_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['family_id'] = this.familyId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
