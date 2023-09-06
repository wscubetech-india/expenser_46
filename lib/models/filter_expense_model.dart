import 'expense_model.dart';

class FilterExpenseModel{

  String date;
  String amt;
  List<ExpenseModel> arrExpense;

  FilterExpenseModel({required this.date, required this.amt, required this.arrExpense});
}



class FilterExpenseYearModel {
  String year;
  String amt;

  List<ExpenseModel> arrExpense;

  FilterExpenseYearModel(
      {required this.year, required this.amt, required this.arrExpense});
}
