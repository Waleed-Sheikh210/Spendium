class SavingHistoryModel {
  int? id;
  String? savingId;
  String? userId;
  String? type;
  String? amount;
  String? note;
  String? createdAt;
  String? updatedAt;

  SavingHistoryModel(
      {this.id,
        this.savingId,
        this.userId,
        this.type,
        this.amount,
        this.note,
        this.createdAt,
        this.updatedAt});

  SavingHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    savingId = json['saving_id'];
    userId = json['user_id'];
    type = json['type'];
    amount = json['amount'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['saving_id'] = this.savingId;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['note'] = this.note;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
