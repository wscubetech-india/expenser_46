import 'package:expenser_46/constants.dart';
import 'package:expenser_46/models/expense_model.dart';
import 'package:expenser_46/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../expense_bloc/expense_bloc.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  var titleController = TextEditingController();
  var descController = TextEditingController();
  var amtController = TextEditingController();

  var selectedCat = -1;

  List<String> arrTransactionType = ['Debit', 'Credit'];
  String selectedTransactionType = 'Debit';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(hintText: "Title"),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(hintText: "desc"),
                controller: descController,
              ),
              TextField(
                decoration: InputDecoration(hintText: "amo"),
                controller: amtController,
              ),

              hSpacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(21),
                                  topRight: Radius.circular(21))),
                          builder: (context) {
                            return SizedBox(
                              height: 300,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: GridView.builder(
                                    itemCount: AppConstants.categories.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4),
                                    itemBuilder: (_, index) {
                                      return InkWell(
                                        onTap: () {
                                          selectedCat = index;
                                          setState(() {});
                                          Navigator.pop(context);
                                        },
                                        child: Column(
                                          children: [
                                            Image.asset(
                                                AppConstants.categories[index]
                                                    ['img'],
                                                width: 50),
                                            hSpacer(),
                                            Text(
                                              AppConstants.categories[index]
                                                  ['name'],
                                              style: mTextStyle12(),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            );
                          });
                    },
                    child: selectedCat >= 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppConstants.categories[selectedCat]['img'],
                                width: 30,
                              ),
                              wSpacer(),
                              Text(
                                AppConstants.categories[selectedCat]['name'],
                                style:
                                    mTextStyle16(mColor: AppColors.whiteColor),
                              )
                            ],
                          )
                        : Text('Choose Category')),
              ),
              hSpacer(),
              DropdownButton(
                  value: selectedTransactionType,
                  items: arrTransactionType
                      .map((e) => DropdownMenuItem(child: Text(e), value: e))
                      .toList(),
                  onChanged: (value) {
                    selectedTransactionType = value!;
                    setState(() {});
                  }),
              hSpacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<ExpenseBloc>().add(AddExpenseEvent(
                        newExpense: ExpenseModel(
                            uid: 1,
                            exp_title: titleController.text.toString(),
                            exp_desc: descController.text.toString(),
                            exp_amt: int.parse(amtController.text.toString()),
                            exp_bal: 0,
                            cat_id: int.parse(
                                AppConstants.categories[selectedCat]['id']),
                            exp_type:
                                selectedTransactionType == 'Debit' ? 0 : 1,
                            date: DateTime.now().toString())));

                    Navigator.pop(context);
                  },
                  child: Text('Add Transaction'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
