class MessageModel {
  String? id;
  String? message;
  String? createdAt;
  bool? isAI;

  MessageModel({this.id, this.message, this.createdAt, this.isAI});

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    createdAt = json['created_at'];
    isAI = json['isAI'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    data['isAI'] = this.isAI;
    return data;
  }
}
