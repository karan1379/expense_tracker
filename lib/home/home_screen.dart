import 'package:expense_tracker/controller/home_controller.dart';
import 'package:expense_tracker/utils/app_images.dart';
import 'package:expense_tracker/utils/app_strings.dart';
import 'package:expense_tracker/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppString.myExpense),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.addExpense),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Obx(()=>
               homeController.dataMap.isEmpty
                   ? Image.asset(AppImages.noExpenseImage)
                  : PieChart(
                        dataMap: Map.from(homeController.dataMap),
                        // Convert RxMap to regular Map
                        animationDuration: const Duration(milliseconds: 800),
                        chartLegendSpacing: 50.0,
                        chartRadius: MediaQuery.of(context).size.width,
                        initialAngleInDegree: 0,
                        chartType: ChartType.disc,
                        ringStrokeWidth: 32,
                        centerText: "Expenses",
                        centerTextStyle:
                            const TextStyle(fontSize: 10, color: Colors.black),
                        legendOptions: const LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: LegendPosition.right,
                          showLegends: true,
                          legendTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        chartValuesOptions: const ChartValuesOptions(
                          chartValueStyle: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          showChartValueBackground: false,
                          showChartValues: true,
                          showChartValuesInPercentage: true,
                          showChartValuesOutside: false,
                        ),
                      ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child:
              Obx(()=>
                homeController.expenseList.isEmpty?
                    Text("After you add, the expenses will be show here!",textAlign: TextAlign.center,
                      style: TextStyle(
                      color: Colors.cyan,
                      fontSize:24,
                      fontWeight: FontWeight.bold
                    ),)
                    : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    itemCount: homeController.expenseList.length,
                    itemBuilder: (context, index) {
                      var model=homeController.expenseList[index];
                      return Container(
                        decoration: const BoxDecoration(),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${index+1}.",style: TextStyle(
                                    color: Colors.black,
                                    fontSize:18
                                ),),
                                SizedBox(
                                  width: 5,
                                ),
                                 Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(model.expenseTitle,style: TextStyle(
                                        color: Colors.black,
                                        fontSize:20,
                                      fontWeight: FontWeight.bold
                                    )),
                                    Text(model.data?.categoryName??"",style: TextStyle(
                                        color: Colors.black87,
                                        fontSize:16,
                                        fontWeight: FontWeight.bold
                                    )),
                                  ],
                                ),
                              ],
                            ),

                            Text( "\$ ${model.amount.toString()}",style: TextStyle(
                              color: Colors.black54,
                              fontSize:16
                            ),),
                          ],
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
