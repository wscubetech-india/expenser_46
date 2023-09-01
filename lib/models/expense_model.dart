import 'package:expenser_46/database_provider/app_database.dart';

class ExpenseModel {
  int? exp_id;
  int uid;
  String exp_title;
  String exp_desc;
  num exp_amt;
  num exp_bal;
  int cat_id;
  int exp_type;
  String date;

  ExpenseModel(
      {this.exp_id,
      required this.uid,
      required this.exp_title,
      required this.exp_desc,
      required this.exp_amt,
      required this.exp_bal,
      required this.cat_id,
      required this.exp_type,
      required this.date});

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
        exp_id: map[AppDataBase().EXPENSE_COLUMN_ID],
        uid: map[AppDataBase().USER_COLUMN_ID],
        exp_title: map[AppDataBase().EXPENSE_COLUMN_TITLE],
        exp_desc: map[AppDataBase().EXPENSE_COLUMN_DESC],
        exp_amt: map[AppDataBase().EXPENSE_COLUMN_AMT],
        exp_bal: map[AppDataBase().EXPENSE_COLUMN_BAL],
        cat_id: map[AppDataBase().EXPENSE_COLUMN_CAT_ID],
        exp_type: map[AppDataBase().EXPENSE_COLUMN_TYPE],
        date: map[AppDataBase().EXPENSE_COLUMN_DATE]);
  }

  Map<String, dynamic> toMap() => {
        AppDataBase().EXPENSE_COLUMN_ID: exp_id,
        AppDataBase().USER_COLUMN_ID: uid,
        AppDataBase().EXPENSE_COLUMN_TITLE: exp_title,
        AppDataBase().EXPENSE_COLUMN_DESC: exp_desc,
        AppDataBase().EXPENSE_COLUMN_AMT: exp_amt,
        AppDataBase().EXPENSE_COLUMN_BAL: exp_bal,
        AppDataBase().EXPENSE_COLUMN_TYPE: exp_type,
        AppDataBase().EXPENSE_COLUMN_CAT_ID: cat_id,
        AppDataBase().EXPENSE_COLUMN_DATE: date,
      };
}
