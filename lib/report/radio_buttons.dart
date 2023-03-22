import 'package:flutter/material.dart';

import 'all_transaction_chart.dart';
import 'expense_income_chart.dart';



class RadioButtons extends StatefulWidget {
  const RadioButtons({super.key});
  @override
  State<RadioButtons> createState() => RadioButtonsState();
}

class RadioButtonsState extends State<RadioButtons> {
   @override
  void initState() {
    radioVal=1;
    super.initState();
  }
  int? radioVal;
  Widget? _buildChild() {
    if (radioVal == 1) {
      return AllTransactionsProgressBar();
    } else if (radioVal == 2) {
      return const ExpenseorIncomeProgressBar(isExpense: true,);
    } else {
      return const ExpenseorIncomeProgressBar(isExpense: false,);
    }
  }
  

  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio(
                  activeColor: const Color.fromARGB(255, 102, 97, 97),
                  value: 1,
                  groupValue: radioVal,
                  onChanged: (value) {
                    setState(() {
                      radioVal = value!;
                    });
                  }),
              const Text("All",
                  style: TextStyle(color: Color.fromARGB(255, 80, 76, 76))),
              const Spacer(),
              Radio(
                  activeColor: const Color.fromARGB(255, 102, 97, 97),
                  value: 2,
                  groupValue: radioVal,
                  onChanged: (value) {
                    setState(() {
                      radioVal = value!;
                    });
                  }),
              const Text(
                "Expense",
                style: TextStyle(color: Color.fromARGB(255, 80, 76, 76)),
              ),
              const Spacer(),
              Radio(
                  activeColor: const Color.fromARGB(255, 102, 97, 97),
                  value: 3,
                  groupValue: radioVal,
                  onChanged: (value) {
                    setState(() {
                      radioVal = value!;
                    });
                  }),
              const Text("Income",
                  style: TextStyle(color: Color.fromARGB(255, 80, 76, 76))),
            ],
          ),
          Container(
            child: _buildChild(),
          )
        ],
      ),
    );
  }
}
