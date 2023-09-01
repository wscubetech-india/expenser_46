import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expenser_46/models/expense_model.dart';
import 'package:meta/meta.dart';
import 'package:expenser_46/database_provider/app_database.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  AppDataBase db;
  ExpenseBloc({required this.db}) : super(ExpenseInitialState()) {

    on<AddExpenseEvent>((event, emit) async{
      emit(ExpenseLoadingState());
      var check = await db.addNewNote(event.newExpense);
      if(check){
        var data = await db.getAllExpenses();
        emit(ExpenseLoadedState(arrExpenses: data));
      } else {
        emit(ExpenseErrorState(errorMsg: "Expense Not Added!!"));
      }
    });

    on<FetchAllExpenseEvent>((event, emit) async{
      emit(ExpenseLoadingState());
      var data = await db.getAllExpenses();
      emit(ExpenseLoadedState(arrExpenses: data));
    });
  }
}
