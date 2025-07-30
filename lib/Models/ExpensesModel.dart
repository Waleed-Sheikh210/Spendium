class ExpensesModel {
  String? budgetId;
  String? title;
  String? amount;
  String? date;
  String? note;

  ExpensesModel({this.budgetId, this.title, this.amount, this.date, this.note});

  ExpensesModel.fromJson(Map<String, dynamic> json) {
    budgetId = json['budget_id'].toString();
    title = json['title'];
    amount = json['amount'].toString();
    date = json['date'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['budget_id'] = this.budgetId;
    data['title'] = this.title;
    data['amount'] = this.amount;
    data['date'] = this.date;
    data['note'] = this.note;
    return data;
  }
}
