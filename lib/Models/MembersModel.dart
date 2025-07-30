class MemberModel {
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

  MemberModel(
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

  MemberModel.fromJson(Map<String, dynamic> json) {
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
