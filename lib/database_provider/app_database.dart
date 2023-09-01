import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/expense_model.dart';
import '../models/user_model.dart';

class AppDataBase{
  var USER_TABLE = "user";
  var USER_COLUMN_ID = "uid";
  var USER_COLUMN_EMAIL = "email";
  var USER_COLUMN_PASS = "password";
  var USER_COLUMN_ADDR = "address";
  var USER_COLUMN_GENDER = "gender";
  var USER_COLUMN_MOBNO = "mobno";

  //expense Table
  var EXPENSE_TABLE = "expense";
//var USER_COLUMN_ID = "uid";
  var EXPENSE_COLUMN_ID = "exp_id";
  var EXPENSE_COLUMN_TITLE = "exp_title";
  var EXPENSE_COLUMN_DESC = "exp_desc";
  var EXPENSE_COLUMN_AMT = "exp_amt";
  var EXPENSE_COLUMN_BAL = "exp_bal";
  var EXPENSE_COLUMN_TYPE = "exp_type"; //0 for debit & 1 for credit
  var EXPENSE_COLUMN_CAT_ID = "exp_cat_id";
  var EXPENSE_COLUMN_DATE = "exp_date"; //current milli stored here




  Future<Database> openDB() async{

    //directory path
    var mDirectory = await getApplicationDocumentsDirectory();

    //created the path
    await mDirectory.create(recursive: true);

    var dbPath = "$mDirectory/mainDB.db";

    return await openDatabase(dbPath, version: 1, onCreate: (db, version){

      var createTableQuery = "create table $USER_TABLE ( $USER_COLUMN_ID integer primary key autoincrement, $USER_COLUMN_EMAIL text unique, $USER_COLUMN_PASS text, $USER_COLUMN_ADDR text, $USER_COLUMN_GENDER text, $USER_COLUMN_MOBNO text)";

      var createExpenseQuery = "create table $EXPENSE_TABLE ( $EXPENSE_COLUMN_ID integer primary key autoincrement, $USER_COLUMN_ID integer, $EXPENSE_COLUMN_TITLE text, $EXPENSE_COLUMN_DESC text, $EXPENSE_COLUMN_AMT real, $EXPENSE_COLUMN_BAL real, $EXPENSE_COLUMN_TYPE integer, $EXPENSE_COLUMN_CAT_ID integer, $EXPENSE_COLUMN_DATE text)";

      db.execute(createTableQuery);
      db.execute(createExpenseQuery);
      //db.insert(NOTE_TABLE, {});
    });


  }

  Future<bool> createUser(UserModel user) async{
    var db = await openDB();
    if(await checkIfEmailAlreadyExists(user.email)){
      return false;
    } else {
      var check = await db.insert(USER_TABLE, user.toMap());
      return check>0;
    }
  }

  Future<bool> checkIfEmailAlreadyExists(String email) async{
    var db = await openDB();
    var check = await db.query(USER_TABLE, where: "$USER_COLUMN_EMAIL = ?", whereArgs: [email]);
    return check.isNotEmpty;
  }

  Future<bool> authenticateUser(String email, String pass) async{
    var db = await openDB();
    var check = await db.query(USER_TABLE, where: "$USER_COLUMN_EMAIL = ? and $USER_COLUMN_PASS = ?", whereArgs: [email, pass]);
    return check.isNotEmpty;
  }

  // forget password
  // reset password

  Future<bool> addNewNote(ExpenseModel newExpense) async {
    var db = await openDB();

    var check = await db.insert(EXPENSE_TABLE, newExpense.toMap());

    return check>0;
  }

  Future<List<ExpenseModel>> getAllExpenses() async{

    var db = await openDB();

    List<Map<String, dynamic>> expenses = await db.query(EXPENSE_TABLE);

    List<ExpenseModel> arrExpenses = [];

    for(Map<String, dynamic> eachExpense in expenses){
      var eachModel = ExpenseModel.fromMap(eachExpense);
      arrExpenses.add(eachModel);
    }

    return arrExpenses;
  }



}