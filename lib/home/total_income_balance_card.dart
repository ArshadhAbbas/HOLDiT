import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/transaction_db_functions.dart';

class IncomeExpenseCard extends StatelessWidget {
  const IncomeExpenseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.35,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color.fromARGB(255, 219, 219, 219)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Consumer<TransactionDBProvider>(
            // valueListenable: TransactionDB.instance.transactionListNotifier,
            builder: (BuildContext context,transactionsDBProvider,
                Widget? _) {
              double expenses = 0;
              double income = 0;
              final transactions=transactionsDBProvider.transactionListNotifier;
              for (var transaction in transactions) {
                if (transaction.isExpense == true) {
                  expenses += transaction.amount;
                } else {
                  income += transaction.amount;
                }
              }
              double balance = income - expenses;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.payments_outlined,
                        color: Color.fromARGB(255, 134, 127, 127),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          "- ₹ $expenses",
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Text(
                        "Expenses",
                        style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 134, 127, 127)),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.account_balance_wallet_outlined,
                        color: Color.fromARGB(255, 134, 127, 127),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          "₹ $balance",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 170, 65),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Text(
                        "Balance",
                        style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 134, 127, 127)),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.account_balance_outlined,
                        color: Color.fromARGB(255, 134, 127, 127),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          " + ₹ $income",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Text(
                        "Income",
                        style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 134, 127, 127)),
                      )
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}


