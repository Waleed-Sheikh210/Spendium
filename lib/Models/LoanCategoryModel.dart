class LoanCategoryModel {
  int? id;
  String? name;
  String? userId;
  String? familyId;
  String? createdAt;
  String? updatedAt;

  LoanCategoryModel(
      {this.id,
        this.name,
        this.userId,
        this.familyId,
        this.createdAt,
        this.updatedAt});

  LoanCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'].toString();
    familyId = json['family_id'].toString();
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
