// Floating action buttomn
// chat Ui
// add expense screen

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/database/drift_database.dart';
import 'package:test_project/expenses_module/controller/expense_home_controller.dart';
import 'package:test_project/routes/app_routes.dart';

class HomeScreen extends GetView<ExpenseHomeController> {
  final categoryId;
  HomeScreen({this.categoryId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingActionButton(),
      body: GetBuilder<ExpenseHomeController>(
          init: controller,
          builder: (context) {
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "My Expenses",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ).paddingSymmetric(vertical: 30),
                  _chart(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Title", style: TextStyle(fontWeight: FontWeight.w700),).paddingSymmetric(horizontal: 20),
                    Text("Amount", style: TextStyle(fontWeight: FontWeight.w700),).paddingSymmetric(horizontal: 20),
                   ],
                ).paddingOnly(top: 25, bottom: 10),
                  _list()
                ],
              ),
            );
          }),
    );
  }


  _chart() => GetBuilder<ExpenseHomeController>(
    builder: (controller) {
      return Container(
        height: 400,
        margin: EdgeInsets.symmetric(vertical: 20),
        child: controller.expenseData.isEmpty ? const Text(
          "No data available! Add data.",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize:20,
          ),
        ).paddingSymmetric(vertical: 50): PieChart(
          PieChartData(
            sections: controller.chartSections(controller.expenseData)
          ),
          swapAnimationDuration: Duration(milliseconds: 150), // Optional
          swapAnimationCurve: Curves.linear, // Optional
        )
      );
    }
  );



  _list() => Expanded(
        child: FutureBuilder<List<ExpenseTableData>>(
            future: controller.oldExpenses(),
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                return ListView.builder(
                    itemCount: snapShot.data!.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(snapShot.data![index].title).paddingSymmetric(horizontal: 20),
                          Text(snapShot.data![index].amount).paddingSymmetric(horizontal: 20),
                        ],
                      );
                    });
              }
              return SizedBox(
                  height: 30,
                  width: Get.width,
                  child: const CircularProgressIndicator());
            }),
      );

  _floatingActionButton() => FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          Get.toNamed(AppRoutes.addExpenseScreen);
        },
      );
}
