import 'package:expenser_46/expense_bloc/expense_bloc.dart';
import 'package:expenser_46/models/expense_model.dart';
import 'package:expenser_46/models/filter_expense_model.dart';
import 'package:expenser_46/screens/add_transaction/add_trans_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Expense_Month extends StatefulWidget {
  const Expense_Month({super.key});

  @override
  State<Expense_Month> createState() => _Expense_MonthState();
}

class _Expense_MonthState extends State<Expense_Month> {
  List<FilterMonthExpenseModal> arrFilterMonthExpense = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ExpenseBloc>().add(FetchAllExpenseEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (_, state) {
          if (state is ExpenseLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ExpenseErrorState) {
            return Center(
              child: Text("${state.errorMsg}"),
            );
          } else if (state is ExpenseLoadedState) {
            var arrData = state.arrExpenses.reversed.toList();
            getMonthWiseTransaction(arrData);
            return arrFilterMonthExpense.isNotEmpty
                ? ListView.builder(
                    itemCount: arrFilterMonthExpense.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(arrFilterMonthExpense[index].month),
                              Text(arrFilterMonthExpense[index].amt),
                            ],
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: arrFilterMonthExpense[index]
                                  .arrExpense
                                  .length,
                              itemBuilder: (_, subIndex) {
                                var eachTrans = arrFilterMonthExpense[index]
                                    .arrExpense[subIndex];
                                return ListTile(
                                  title: Text(eachTrans.exp_title),
                                  subtitle: Text(eachTrans.exp_desc),
                                  trailing: Text("\$ ${eachTrans.exp_amt}"),
                                );
                              })
                        ],
                      );
                    })
                : Center(
                    child: Text("No Expenser Addend"),
                  );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTransactionPage(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void getMonthWiseTransaction(List<ExpenseModel> data) {
    arrFilterMonthExpense.clear();
    //getUniqueDates
    List<String> arrUniqueDate = [];

    for (ExpenseModel eachTrans in data) {
      var date = DateTime.parse(eachTrans.date);

      /// 09-2023
      var eachDate =
          "${date.month.toString().length < 2 ? '0${date.month}' : date.month}-${date.year}";
      print(eachDate);

      if (!arrUniqueDate.contains(eachDate)) {
        arrUniqueDate.add(eachDate);
      }
    }
    print(arrUniqueDate);

    //2
    for (String eachDate in arrUniqueDate) {
      print("EachDate : $eachDate");

      List<ExpenseModel> eachDateTrans = [];
      num amt = 0;

      for (ExpenseModel eachTrans in data) {
        var date = DateTime.parse(eachTrans.date);

        /// 08-2023
        var mDate =
            "${date.month.toString().length < 2 ? '0${date.month}' : date.month}-${date.year}";

        if (eachDate == mDate) {
          eachDateTrans.add(eachTrans);
          if (eachTrans.exp_type == 0) {
            //debit
            amt -= eachTrans.exp_amt;
          } else {
            //credit
            amt += eachTrans.exp_amt;
          }
        }

        //continue from here..
      }

      arrFilterMonthExpense.add(FilterMonthExpenseModal(
          month: eachDate, amt: amt.toString(), arrExpense: eachDateTrans));
    }

  
  }
}
