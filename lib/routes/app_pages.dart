import 'package:get/get.dart';
import 'package:test_project/expenses_module/bindings/expense_binding.dart';
import 'package:test_project/expenses_module/bindings/expense_home_binding.dart';
import 'package:test_project/expenses_module/view/add_expense.dart';
import 'package:test_project/expenses_module/view/expences_home.dart';
import 'package:test_project/routes/app_routes.dart';

class AppPages{

  static String initialRoute = AppRoutes.homeScreen;

  static List<GetPage> routes = [
  GetPage(
  name: AppRoutes.homeScreen,
  page: () =>  HomeScreen(),
    binding: ExpenseHomeBinding()
  ),
  GetPage(
  name: AppRoutes.addExpenseScreen,
  page: () =>  AddExpensesScreen(),
    binding:   AddExpenseBinding()
  ),

  ];


}