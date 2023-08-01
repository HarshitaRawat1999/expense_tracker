import 'package:get/get.dart';
import 'package:test_project/expenses_module/controller/add_expense_controller.dart';

class AddExpenseBinding extends Bindings{
  @override
  void dependencies() {
   Get.put(AddExpenseController());
  }

}