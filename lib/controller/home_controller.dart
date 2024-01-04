import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/utils/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  TextEditingController expenseTitleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  RxList<ExpenseModel> expenseList = RxList();
  final RxMap<String, double> dataMap = RxMap();



  List<CategoryData> categoryData = [
    CategoryData(categoryName: AppString.expenses,),
    CategoryData(categoryName: AppString.food,),
    CategoryData(categoryName: AppString.transportation,),
    CategoryData(categoryName: AppString.utilities,),
    CategoryData(categoryName: AppString.pet,),
  ];
  RxString categoryName="".obs;

  clearFields(){
    expenseTitleController.clear();
    amountController.clear();
  }

  onExpenseSaved() {
    expenseList.add(
      ExpenseModel(
          expenseTitle: expenseTitleController.text,
          data: CategoryData(
            categoryName: categoryName.value,
          ),
          amount: double.parse(amountController.text)),
    );
    Get.back();
    clearFields();
    updateDataMap();
    update();
  }




  void updateDataMap() {
    dataMap.clear(); // Clear previous dataMap
    for (var expense in expenseList) {
      String category = expense.data!.categoryName;
      double amount = expense.amount;
      if (dataMap.containsKey(category)) {
        dataMap[category] = dataMap[category]! + amount;
      } else {
        dataMap[category] = amount;
      }
    }
  }
}
