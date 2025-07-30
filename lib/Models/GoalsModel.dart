
class Goal {
   String? family_id;
   String? user_id;
   String? id;
   String? title;
   String? type;
   String? created_at;
   String? amount;

  Goal(
      {required this.family_id,
        required this.type,
        required this.user_id,
        required this.id,
        required this.title,
        required this.created_at,
        required this.amount});



   Goal.fromJson(Map<String, dynamic> json) {
    family_id = json['family_id'].toString();
    user_id = json['user_id'].toString();
    id = json['id'].toString();
    title = json['title'].toString();
    type = json['type'].toString();
    created_at = json['created_at'].toString();
    amount = json['target_amount'].toString();
   }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['family_id'] = this.family_id;
    data['user_id'] = this.user_id;
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['created_at'] = this.created_at;
    data['target_amount'] = this.amount;
    return data;
  }




}
