import 'package:expenser_46/expense_bloc/expense_bloc.dart';
import 'package:expenser_46/models/filter_expense_model.dart';
import 'package:expenser_46/screens/add_transaction/add_trans_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../models/expense_model.dart';

class ExpenseYearPage extends StatefulWidget {
  const ExpenseYearPage({super.key});

  @override
  State<ExpenseYearPage> createState() => _ExpenseYearPageState();
}

class _ExpenseYearPageState extends State<ExpenseYearPage> {
  // List<FilterExpenseModel> arrFilterDateExpenses = [];
  List<FilterExpenseYearModel> arrFilterYearExpenses = [];


  @override
  void initState() {
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
              child: Text('${state.errorMsg}'),
            );
          } else if (state is ExpenseLoadedState) {
            var arrData = state.arrExpenses;
            getYearWiseTransaction(arrData);


            getYearWiseTransaction(arrData);
            return arrFilterYearExpenses.isNotEmpty
                ? ListView.builder(
                itemCount: arrFilterYearExpenses.length,
                itemBuilder: (_, index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(arrFilterYearExpenses[index].year),
                          Text(arrFilterYearExpenses[index].amt),
                        ],
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: arrFilterYearExpenses[index]
                              .arrExpense
                              .length,
                          itemBuilder: (_, subIndex) {
                            var eachTrans = arrFilterYearExpenses[index]
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
              child: Text('No Expenses yet!'),
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

  void getYearWiseTransaction(List<ExpenseModel> data) {
    arrFilterYearExpenses.clear();
    //getUniqueYear
    List<String> arrUniqueYear = [];

    for (ExpenseModel eachTrans in data) {
      var date = DateTime.parse(eachTrans.date);

      /// 28-08-2023
      var eachYear =
          "${date.year}";
      print(eachYear);

      if (!arrUniqueYear.contains(eachYear)) {
        arrUniqueYear.add(eachYear);
      }
    }
    print(arrUniqueYear);

    //2
    for (String eachYear in arrUniqueYear) {
      print("EachYear : $eachYear");

      List<ExpenseModel> eachYearTrans = [];
      num amt = 0;

      for (ExpenseModel eachTrans in data) {
        var date = DateTime.parse(eachTrans.date);

        /// 28-08-2023
        var mYear =
            "${date.year}";

        if (eachYear == mYear) {
          eachYearTrans.add(eachTrans);
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

      arrFilterYearExpenses.add(FilterExpenseYearModel(
        year: eachYear, amt: amt.toString(), arrExpense: eachYearTrans, ));
    }

    /*for(FilterExpenseModel model in arrFilterDateExpenses){
      print("Date: ${model.date}\nAmt: ${model.amt}\nTrans: ${model.arrExpense.length}");
    }*/
  }


}
