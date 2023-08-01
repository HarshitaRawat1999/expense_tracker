import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/database/drift_database.dart';
import 'package:test_project/expenses_module/model/expense_model.dart';
import 'package:test_project/routes/app_routes.dart';
import 'package:test_project/utils/common_utility.dart';


class AddExpenseController extends GetxController with GetTickerProviderStateMixin{
   final formKey = new GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController addCategoryController = TextEditingController();

  FocusNode titleNode = FocusNode();
  FocusNode amountNode = FocusNode();
  FocusNode focusNode = FocusNode();



  AppDatabase? database;
  var categoryId;

  bool isShow = false;
  late AnimationController expandController;
  late Animation<double> animation;
   OptionItem optionItemSelected = OptionItem(id: 0, title: "Select Category");


   String title = "";

  String amount = "";

  int? category = 0;

  @override
  void onInit() {
    database    = AppDatabase();
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isShow = false;
        runExpandCheck();
      }
    });
    focusNode = FocusNode();
    runExpandCheck();
    super.onInit();
  }

  void runExpandCheck() {
    if (isShow) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  addCategory(){
    if(dropListModel.listOptionItems.length < 10){
      dropListModel.listOptionItems.add(OptionItem(
          id: dropListModel.listOptionItems.last.id + 1,
          title: addCategoryController.text.trim()));
      Get.back();
      addCategoryController.clear();
      update();
      Utility.toast(Get.context!, "Category Added");
    }else{
      Utility.toast(Get.context!, "Cannot add more than 10 categories");
    }
  }

  submit() async {
    if (formKey.currentState!.validate()) {
      if ((category ?? 0) > 0) {
        title = titleController.text;
        amount = amountController.text;
        categoryId = await database!
            .insertData(
              ExpenseTableCompanion.insert(
                title: title,
                amount: amount,
                category: category.toString(),
              ),
            );
           Get.offAllNamed(AppRoutes.homeScreen);
        debugPrint("data inserted ${categoryId.toString()}");
        update();
      } else {
        Utility.toast(Get.context!, "Select something");
      }
    }
  }

  List<ExpenseModel> expences = [];

  //TODO: return List of category list
  List<String> categoryList() {
    List<String> categories = []; //take static data of your choice
    return categories;
  }

//TODO: add expense to expense list
  void addExpense() {
    ExpenseModel expense = ExpenseModel(title: "", category: "", amount: 0);
    expences.add(expense);
  }


//TODO: validation for add expence
  void validation() {}

//TODO: getItem by category
  expencesByCategory(String category) {
    return expences.where((element) => element.category == category).toList();
  }

}
