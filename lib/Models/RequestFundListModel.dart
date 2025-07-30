class RequestFundListModel {
  int? id;
  String? userId;
  String? familyId;
  String? categoryId;
  String? amount;
  String? note;
  String? status;
  String? createdAt;
  String? updatedAt;
  Category? category;
  ReqUser? user;

  RequestFundListModel(
      {this.id,
        this.userId,
        this.familyId,
        this.categoryId,
        this.amount,
        this.note,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.category});

  RequestFundListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    familyId = json['family_id'];
    categoryId = json['category_id'];
    amount = json['amount'];
    note = json['note'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    user = json['user'] != null ? new ReqUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['family_id'] = this.familyId;
    data['category_id'] = this.categoryId;
    data['amount'] = this.amount;
    data['note'] = this.note;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? userId;
  String? familyId;
  String? name;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
        this.userId,
        this.familyId,
        this.name,
        this.createdAt,
        this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    familyId = json['family_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['family_id'] = this.familyId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ReqUser {
String? id;
  String? name;
  String? email;
ReqUser(
      {this.id,
        this.name,
        this.email,});

ReqUser.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    email = json['email'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}

