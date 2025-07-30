class MyContributeModel {
  int? id;
  String? loanId;
  String? userId;
  String? amount;
  String? note;
  String? status;
  String? createdAt;
  String? updatedAt;
  Loan? loan;
  Category? user;

  MyContributeModel(
      {this.id,
        this.loanId,
        this.userId,
        this.amount,
        this.note,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.loan,
        this.user});

  MyContributeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loanId = json['loan_id'];
    userId = json['user_id'];
    amount = json['amount'];
    note = json['note'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    loan = json['loan'] != null ? new Loan.fromJson(json['loan']) : null;
    user = json['user'] != null ? new Category.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['loan_id'] = this.loanId;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['note'] = this.note;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.loan != null) {
      data['loan'] = this.loan!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Loan {
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

  Loan(
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

  Loan.fromJson(Map<String, dynamic> json) {
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
