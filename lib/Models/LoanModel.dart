class LoanModel {
  int? familyId;
  int? loanCategoryId;
  String? lender;
  int? amount;
  int? remainingAmount;
  String? purpose;
  String? dueDate;
  String? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  LoanModel(
      {this.familyId,
        this.loanCategoryId,
        this.lender,
        this.amount,
        this.remainingAmount,
        this.purpose,
        this.dueDate,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.id});

  LoanModel.fromJson(Map<String, dynamic> json) {
    familyId = json['family_id'];
    loanCategoryId = json['loan_category_id'];
    lender = json['lender'];
    amount = json['amount'];
    remainingAmount = json['remaining_amount'];
    purpose = json['purpose'];
    dueDate = json['due_date'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['family_id'] = this.familyId;
    data['loan_category_id'] = this.loanCategoryId;
    data['lender'] = this.lender;
    data['amount'] = this.amount;
    data['remaining_amount'] = this.remainingAmount;
    data['purpose'] = this.purpose;
    data['due_date'] = this.dueDate;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
