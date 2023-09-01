import 'expense_model.dart';

class FilterExpenseModel{

  String date;
  String amt;
  List<ExpenseModel> arrExpense;

  FilterExpenseModel({required this.date, required this.amt, required this.arrExpense});
}