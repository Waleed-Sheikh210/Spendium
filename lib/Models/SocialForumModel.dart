class SocialForumModel {
  String? id;
  String? userId;
  String? title;
  String? description;
  String? photo;
  String? createdAt;
  String? isLiked;
  String? updatedAt;
  String? isFollow;
  String? likeCount;
  User? user;
  List<Comments>? comments;
  List<Reactions>? reactions;

  SocialForumModel(
      {this.id,
        this.userId,
        this.isLiked,
        this.title,
        this.description,
        this.likeCount,
        this.photo,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.isFollow="0" ,
        this.comments,
        this.reactions});

  SocialForumModel.fromJson(Map<String, dynamic> json) {
  id = json['id'].toString();
    isLiked = json['isLiked'].toString();
    userId = json['user_id'].toString();
likeCount = json['like_count'].toString();
    title = json['title'].toString();
    description = json['description'].toString();
    photo = json['photo'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    isFollow = json['isFollow']== null ? "0" : json['isFollow'].toString();
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    if (json['reactions'] != null) {
      reactions = <Reactions>[];
      json['reactions'].forEach((v) {
        reactions!.add(new Reactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isLiked'] = this.isLiked;
    data['like_count'] = this.likeCount;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['photo'] = this.photo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    if (this.reactions != null) {
      data['reactions'] = this.reactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? id;
  String? name;
  String? email;
  String? username;
  String? role;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? otp;
  String? otpExpiresAt;

  User(
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

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    email = json['email'].toString();
    username = json['username'].toString();
    role = json['role'].toString();
    image = json['image'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    otp = json['otp'].toString();
    otpExpiresAt = json['otp_expires_at'].toString();
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

class Comments {
  String? id;
  String? userId;
  String? postId;
  String? content;
  String? createdAt;
  String? updatedAt;
  User? user;

  Comments(
      {this.id,
        this.userId,
        this.postId,
        this.content,
        this.createdAt,
        this.updatedAt,
        this.user});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    userId = json['user_id'].toString();
    postId = json['post_id'].toString();
    content = json['content'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Reactions {
  String? id;
  String? userId;
  String? reactableId;
  String? reactableType;
  String? type;
  String? createdAt;
  String? updatedAt;

  Reactions(
      {this.id,
        this.userId,
        this.reactableId,
        this.reactableType,
        this.type,
        this.createdAt,
        this.updatedAt});

  Reactions.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    userId = json['user_id'].toString();
    reactableId = json['reactable_id'].toString();
    reactableType = json['reactable_type'].toString();
    type = json['type'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['reactable_id'] = this.reactableId;
    data['reactable_type'] = this.reactableType;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
