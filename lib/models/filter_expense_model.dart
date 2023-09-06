import 'expense_model.dart';

class FilterExpenseModel {
  String date;

  String amt;
  List<ExpenseModel> arrExpense;

  FilterExpenseModel(
      {required this.date, required this.amt, required this.arrExpense});
}

class FilterMonthExpenseModal {
  String month;
  String amt;
  List<ExpenseModel> arrExpense;
  FilterMonthExpenseModal(
      {required this.month, required this.amt, required this.arrExpense});
}
