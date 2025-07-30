import '../Utils/Constants.dart';

class User {
  String? apiToken;
  String? name;
  String? email;
  String? username;
  String? role;
  String? image;
  String? updatedAt;
  String? createdAt;
  int? id;

  User(
      {this.name,
        this.apiToken,
        this.email,
        this.username,
        this.role,
        this.image,
        this.updatedAt,
        this.createdAt,
        this.id});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    apiToken = json['token'];
    email = json['email'];
    username = json['username'];
    role = json['role'];
    image = "${Constants.baseUrl}${json['image']}";
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['token'] = this.apiToken;
    data['username'] = this.username;
    data['role'] = this.role;
    data['image'] = this.image;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }


}
