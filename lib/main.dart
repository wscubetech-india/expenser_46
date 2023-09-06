import 'package:expenser_46/database_provider/app_database.dart';
import 'package:expenser_46/expense_bloc/expense_bloc.dart';
import 'package:expenser_46/screens/add_transaction/add_trans_page.dart';
import 'package:expenser_46/screens/home/home_page.dart';
import 'package:expenser_46/screens/splash/splash_page.dart';
import 'package:expenser_46/yearwise_expense/year_wise_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp( BlocProvider(
    create: (context) => ExpenseBloc(db: AppDataBase()),
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExpenseYearPage(),
    ),
  ));
}
