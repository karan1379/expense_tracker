import 'package:dropdown_search/dropdown_search.dart';
import 'package:expense_tracker/controller/home_controller.dart';
import 'package:expense_tracker/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddExpenseScreen extends StatelessWidget {
  AddExpenseScreen({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppString.addExpense),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextFormField(
              inputFormatters: [LengthLimitingTextInputFormatter(10)],
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: AppString.title,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                ),
              ),
              controller: homeController.expenseTitleController,
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              inputFormatters: [
                LengthLimitingTextInputFormatter(6),

                FilteringTextInputFormatter.allow(
                    RegExp(r'^(?:\d{1,6}(?:\.\d{0,6})?|\.\d{1,6})$'))

                // FilteringTextInputFormatter.allow(RegExp(r'^(?:\d{1,6}(?:\.\d{0,6})?|\.\d)$'))]
                // FilteringTextInputFormatter.allow(
                //     RegExp(r'^(?=.*\d)\d{0,6}(\.\d{0,5})?$'))
              ],
              decoration: const InputDecoration(
                hintText: AppString.amount,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                ),
              ),
              controller: homeController.amountController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 25,
            ),
            specialListDrop(),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                if (homeController.expenseTitleController.text.trim().isEmpty) {
                  Get.showSnackbar(const GetSnackBar(
                    duration: Duration(seconds: 2),
                    isDismissible: true,
                    backgroundColor: Colors.red,
                    message: "Please enter title",
                    title: "Expense App",
                    titleText: Text(
                      AppString.error,
                      style: TextStyle(color: Colors.white),
                    ),
                  ));
                  return;
                } else if (homeController.amountController.text
                    .trim()
                    .isEmpty) {
                  Get.showSnackbar(const GetSnackBar(
                    duration: Duration(seconds: 2),
                    isDismissible: true,
                    message: "Please enter amount",
                    backgroundColor: Colors.red,
                    title: "Expense App",
                    titleText: Text(
                      AppString.error,
                      style: TextStyle(color: Colors.white),
                    ),
                  ));
                  return;
                } else if (homeController.amountController.text
                    .trim()
                    .isEmpty) {
                  Get.showSnackbar(const GetSnackBar(
                    duration: Duration(seconds: 2),
                    isDismissible: true,
                    message: "Please enter amount",
                    backgroundColor: Colors.red,
                    title: "Expense App",
                    titleText: Text(
                      AppString.error,
                      style: TextStyle(color: Colors.white),
                    ),
                  ));
                  return;
                } else if (homeController.amountController.text.endsWith(".")) {
                  Get.showSnackbar(const GetSnackBar(
                    duration: Duration(seconds: 2),
                    isDismissible: true,
                    message: "Please enter correct amount",
                    backgroundColor: Colors.red,
                    title: "Expense App",
                    titleText: Text(
                      AppString.error,
                      style: TextStyle(color: Colors.white),
                    ),
                  ));
                  return;
                } else if (homeController.categoryName.value == "") {
                  Get.showSnackbar(const GetSnackBar(
                    duration: Duration(seconds: 2),
                    isDismissible: true,
                    message: "Please select category",
                    backgroundColor: Colors.red,
                    title: "Expense App",
                    titleText: Text(
                      "Error",
                      style: TextStyle(color: Colors.white),
                    ),
                  ));
                  return;
                }
                homeController.onExpenseSaved();
              },
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }

  Widget specialListDrop() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            const BoxShadow(
                color: Color(0x17000000), offset: Offset(0, 5), blurRadius: 10)
          ]),
      child: DropdownSearch(
        popupProps: const PopupProps.menu(),
        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 10, top: 15),
          ),
        ),
        onChanged: (data) {
          homeController.categoryName.value = data.categoryName;
          print(data.categoryName);
        },
        items: homeController.categoryData,
        selectedItem: "Select Category",
      ),
    );
  }
}
