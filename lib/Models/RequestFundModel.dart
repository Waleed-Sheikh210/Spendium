class RequestFundModel {
  int? userId;
  String? familyId;
  String? categoryId;
  String? amount;
  String? note;
  String? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  RequestFundModel(
      {this.userId,
        this.familyId,
        this.categoryId,
        this.amount,
        this.note,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.id});

  RequestFundModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    familyId = json['family_id'];
    categoryId = json['category_id'];
    amount = json['amount'];
    note = json['note'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['family_id'] = this.familyId;
    data['category_id'] = this.categoryId;
    data['amount'] = this.amount;
    data['note'] = this.note;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
