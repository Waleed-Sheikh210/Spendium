class FamilyMemberModel {
  int? id;
  String? familyId;
  String? userId;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? status;
  FamilyUser? user;

  FamilyMemberModel(
      {this.id,
        this.familyId,
        this.userId,
        this.role,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.user});

  FamilyMemberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    familyId = json['family_id'];
    userId = json['user_id'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    user = json['user'] != null ? new FamilyUser.fromJson(json['user']) : null;
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
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class FamilyUser {
  int? id;
  String? name;
  String? email;
  String? username;
  String? role;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? otp;
  String? otpExpiresAt;

  FamilyUser(
      {this.id,
        this.name,
        this.email,
        this.username,
        this.role,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.otp,
        this.otpExpiresAt});

  FamilyUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    role = json['role'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    otp = json['otp'];
    otpExpiresAt = json['otp_expires_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data['role'] = this.role;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['otp'] = this.otp;
    data['otp_expires_at'] = this.otpExpiresAt;
    return data;
  }
}
