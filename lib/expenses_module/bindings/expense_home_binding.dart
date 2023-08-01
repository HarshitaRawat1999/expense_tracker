import 'package:get/get.dart';
import 'package:test_project/expenses_module/controller/expense_home_controller.dart';

class ExpenseHomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ExpenseHomeController());
  }

}