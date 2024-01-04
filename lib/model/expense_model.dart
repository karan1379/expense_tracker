class ExpenseModel {
  String expenseTitle;
  CategoryData? data;
  double amount;

  ExpenseModel({required this.expenseTitle, this.data, required this.amount});
}

class CategoryData {
  String categoryName;


  CategoryData({
    required this.categoryName,
  });

  @override
  String toString() {
    return categoryName; // Return the categoryName when converted to a string
  }
}
