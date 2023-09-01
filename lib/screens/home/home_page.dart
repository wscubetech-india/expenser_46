import 'package:expenser_46/constants.dart';
import 'package:expenser_46/expense_bloc/expense_bloc.dart';
import 'package:expenser_46/models/filter_expense_model.dart';
import 'package:expenser_46/screens/add_transaction/add_trans_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/expense_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FilterExpenseModel> arrFilterDateExpenses = [];

  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(FetchAllExpenseEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (_, state){
          if(state is ExpenseLoadingState){
            return Center(child: CircularProgressIndicator(),);
          } else if(state is ExpenseErrorState){
            return Center(child: Text('${state.errorMsg}'),);
          } else if(state is ExpenseLoadedState){
            var arrData = state.arrExpenses;
            getDateWiseTransaction(arrData);
            return arrFilterDateExpenses.isNotEmpty ? ListView.builder(
                itemCount: arrFilterDateExpenses.length,
                itemBuilder: (_, index) {
                  return Column(
                    children: [
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(arrFilterDateExpenses[index].date),
                        Text(arrFilterDateExpenses[index].amt),
                      ],
                    ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: arrFilterDateExpenses[index].arrExpense.length,
                          itemBuilder: (_, subIndex){
                          var eachTrans = arrFilterDateExpenses[index].arrExpense[subIndex];
                        return ListTile(
                          title: Text(eachTrans.exp_title),
                          subtitle: Text(eachTrans.exp_desc),
                          trailing: Text("\$ ${eachTrans.exp_amt}"),
                        );
                      })
                    ],
                  );
                }) : Center(child: Text('No Expenses yet!'),);
          }
          return Container();
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTransactionPage(),));
        },
        child: Icon(Icons.add),
      ),
    );
  }


  void getDateWiseTransaction(List<ExpenseModel> data){
    arrFilterDateExpenses.clear();
    //getUniqueDates
    List<String> arrUniqueDate =[];

    for(ExpenseModel eachTrans in data){
      var date = DateTime.parse(eachTrans.date);
      /// 28-08-2023
      var eachDate = "${date.day}-${date.month.toString().length<2 ? '0${date.month}': date.month}-${date.year}";
      print(eachDate);

      if(!arrUniqueDate.contains(eachDate)){
        arrUniqueDate.add(eachDate);
      }

    }
    print(arrUniqueDate);

    //2
    for(String eachDate in arrUniqueDate){
      print("EachDate : $eachDate");

      List<ExpenseModel> eachDateTrans = [];
      num amt = 0;

      for(ExpenseModel eachTrans in data){
        var date = DateTime.parse(eachTrans.date);
        /// 28-08-2023
        var mDate = "${date.day}-${date.month.toString().length<2 ? '0${date.month}': date.month}-${date.year}";

        if(eachDate==mDate){
          eachDateTrans.add(eachTrans);
          if(eachTrans.exp_type==0){
            //debit
            amt -= eachTrans.exp_amt;
          } else {
            //credit
            amt += eachTrans.exp_amt;
          }
        }

        //continue from here..

      }

      arrFilterDateExpenses.add(FilterExpenseModel(date: eachDate, amt: amt.toString(), arrExpense: eachDateTrans));
    }


    /*for(FilterExpenseModel model in arrFilterDateExpenses){
      print("Date: ${model.date}\nAmt: ${model.amt}\nTrans: ${model.arrExpense.length}");
    }*/

  }
}
