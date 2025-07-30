class AnalyticsModel {
  int? totalFamilyMembers;
  int? totalCategories;
  List<Categories>? categories;
  List<ExpenseByCategory>? expenseByCategory;
  List<Last5Transactions>? last5Transactions;
  String? totalBudget;
  String? totalLoan;
  String? totalSavings;
  List<CategoryExpenseForAndroid>? categoryExpenseForAndroid;
  List<LoanCategorySummaryForAndroid>? loanCategorySummaryForAndroid;

  AnalyticsModel(
      {this.totalFamilyMembers,
        this.totalCategories,
        this.categories,
        this.expenseByCategory,
        this.last5Transactions,
        this.totalBudget,
        this.totalLoan,
        this.totalSavings,
        this.categoryExpenseForAndroid,
        this.loanCategorySummaryForAndroid});

  AnalyticsModel.fromJson(Map<String, dynamic> json) {
    totalFamilyMembers = json['total_family_members'];
    totalCategories = json['total_categories'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['expense_by_category'] != null) {
      expenseByCategory = <ExpenseByCategory>[];
      json['expense_by_category'].forEach((v) {
        expenseByCategory!.add(new ExpenseByCategory.fromJson(v));
      });
    }
    if (json['last_5_transactions'] != null) {
      last5Transactions = <Last5Transactions>[];
      json['last_5_transactions'].forEach((v) {
        last5Transactions!.add(new Last5Transactions.fromJson(v));
      });
    }
    totalBudget = json['total_budget'];
    totalLoan = json['total_loan'];
    totalSavings = json['total_savings'];
    if (json['category_expense_for_android'] != null) {
      categoryExpenseForAndroid = <CategoryExpenseForAndroid>[];
      json['category_expense_for_android'].forEach((v) {
        categoryExpenseForAndroid!
            .add(new CategoryExpenseForAndroid.fromJson(v));
      });
    }
    if (json['loan_category_summary_for_android'] != null) {
      loanCategorySummaryForAndroid = <LoanCategorySummaryForAndroid>[];
      json['loan_category_summary_for_android'].forEach((v) {
        loanCategorySummaryForAndroid!
            .add(new LoanCategorySummaryForAndroid.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_family_members'] = this.totalFamilyMembers;
    data['total_categories'] = this.totalCategories;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.expenseByCategory != null) {
      data['expense_by_category'] =
          this.expenseByCategory!.map((v) => v.toJson()).toList();
    }
    if (this.last5Transactions != null) {
      data['last_5_transactions'] =
          this.last5Transactions!.map((v) => v.toJson()).toList();
    }
    data['total_budget'] = this.totalBudget;
    data['total_loan'] = this.totalLoan;
    data['total_savings'] = this.totalSavings;
    if (this.categoryExpenseForAndroid != null) {
      data['category_expense_for_android'] =
          this.categoryExpenseForAndroid!.map((v) => v.toJson()).toList();
    }
    if (this.loanCategorySummaryForAndroid != null) {
      data['loan_category_summary_for_android'] =
          this.loanCategorySummaryForAndroid!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? name;

  Categories({this.id, this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ExpenseByCategory {
  String? categoryId;
  String? categoryName;
  String? expenseCount;
  String? totalExpense;

  ExpenseByCategory(
      {this.categoryId,
        this.categoryName,
        this.expenseCount,
        this.totalExpense});

  ExpenseByCategory.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    expenseCount = json['expense_count'];
    totalExpense = json['total_expense'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['expense_count'] = this.expenseCount;
    data['total_expense'] = this.totalExpense;
    return data;
  }
}

class Last5Transactions {
  int? id;
  String? userId;
  String? budgetId;
  String? title;
  String? amount;
  String? note;
  String? date;
  String? approved;
  String? createdAt;
  String? updatedAt;
  String? categoryId;
  Category? category;

  Last5Transactions(
      {this.id,
        this.userId,
        this.budgetId,
        this.title,
        this.amount,
        this.note,
        this.date,
        this.approved,
        this.createdAt,
        this.updatedAt,
        this.categoryId,
        this.category});

  Last5Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    budgetId = json['budget_id'];
    title = json['title'];
    amount = json['amount'];
    note = json['note'];
    date = json['date'];
    approved = json['approved'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['budget_id'] = this.budgetId;
    data['title'] = this.title;
    data['amount'] = this.amount;
    data['note'] = this.note;
    data['date'] = this.date;
    data['approved'] = this.approved;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_id'] = this.categoryId;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? userId;
  String? familyId;
  String? name;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
        this.userId,
        this.familyId,
        this.name,
        this.createdAt,
        this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    familyId = json['family_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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

class LoanCategorySummaryForAndroid {
  String? loanCategoryId;
  String? loanCategoryName;
  String? totalLoan;

  LoanCategorySummaryForAndroid(
      {this.loanCategoryId, this.loanCategoryName, this.totalLoan});

  LoanCategorySummaryForAndroid.fromJson(Map<String, dynamic> json) {
    loanCategoryId = json['loan_category_id'];
    loanCategoryName = json['loan_category_name'];
    totalLoan = json['total_loan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_category_id'] = this.loanCategoryId;
    data['loan_category_name'] = this.loanCategoryName;
    data['total_loan'] = this.totalLoan;
    return data;
  }
}
class CategoryExpenseForAndroid {
  String? loanCategoryId;
  String? loanCategoryName;
  String? totalLoan;

  CategoryExpenseForAndroid(
      {this.loanCategoryId, this.loanCategoryName, this.totalLoan});

  CategoryExpenseForAndroid.fromJson(Map<String, dynamic> json) {
    loanCategoryId = json['loan_category_id'];
    loanCategoryName = json['loan_category_name'];
    totalLoan = json['total_loan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_category_id'] = this.loanCategoryId;
    data['loan_category_name'] = this.loanCategoryName;
    data['total_loan'] = this.totalLoan;
    return data;
  }
}
