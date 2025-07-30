class InvitaitonModel {
  int? id;
  String? familyId;
  String? userId;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? status;
  Family? family;

  InvitaitonModel(
      {this.id,
        this.familyId,
        this.userId,
        this.role,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.family});

  InvitaitonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    familyId = json['family_id'];
    userId = json['user_id'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    family =
    json['family'] != null ? new Family.fromJson(json['family']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['family_id'] = this.familyId;
    data['user_id'] = this.userId;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    if (this.family != null) {
      data['family'] = this.family!.toJson();
    }
    return data;
  }
}

class Family {
  int? id;
  String? name;
  String? fatherId;
  String? createdAt;
  String? updatedAt;

  Family({this.id, this.name, this.fatherId, this.createdAt, this.updatedAt});

  Family.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fatherId = json['father_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['father_id'] = this.fatherId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
