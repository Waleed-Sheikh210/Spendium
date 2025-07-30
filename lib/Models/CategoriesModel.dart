class CategoriesModel {
  String? id;
  String? userId;
  String? familyId;
  String? name;
  String? createdAt;
  String? updatedAt;

  CategoriesModel(
      {this.id,
        this.userId,
        this.familyId,
        this.name,
        this.createdAt,
        this.updatedAt});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    userId = json['user_id'].toString();
    familyId = json['family_id'].toString();
    name = json['name'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
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
