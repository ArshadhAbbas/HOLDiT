import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../common_widgets/month_picker.dart';
import '../db/transactions_db/transaction_db_functions.dart';
import '../db/transactions_db/transaction_model.dart';

class AllTransactionsProgressBar extends StatelessWidget {
  AllTransactionsProgressBar({super.key});
  final List<TransactionModel> trans = [];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DateTime>(
        valueListenable: MonthPicker.instance.selectedMonthNotifier,
        builder: (BuildContext context, DateTime selectedMonth, _) {
          return ValueListenableBuilder<List<TransactionModel>>(
            valueListenable: TransactionDB.instance.transactionListNotifier,
            builder:
                (BuildContext context, List<TransactionModel> transactions, _) {
              double expenses = 0;
              double income = 0;
              for (var transaction in transactions) {
                if (transaction.date.month ==
                        MonthPicker.instance.selectedMonth.month &&
                    transaction.date.year ==
                        MonthPicker.instance.selectedMonth.year) {
                  if (transaction.isExpense == true) {
                    expenses += transaction.amount;
                  } else {
                    income += transaction.amount;
                  }
                }
              }
              String formattedDate = DateFormat('MMM-yyyy')
                  .format(MonthPicker.instance.selectedMonth);
              Map incomeMap = {'name': 'Income', "amount": income};
              Map expenseMap = {"name": "Expense", "amount": expenses};
              List<Map> totalMap = [incomeMap, expenseMap];
              return (expenses != 0 || income != 0)
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: SfCircularChart(
                        title: ChartTitle(
                            text: "$formattedDate Report",
                            textStyle: const TextStyle(fontSize: 20)),
                        series: <CircularSeries>[
                          DoughnutSeries<Map, String>(
                            explode: true,
                            explodeAll: true,
                            innerRadius: "50%",
                            dataSource: totalMap,
                            xValueMapper: (Map data, _) => data['name'],
                            yValueMapper: (Map data, _) => data['amount'],
                            dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                            ),
                            pointColorMapper: (Map data, _) {
                              if (data['name'] == 'Expense') {
                                return const Color.fromARGB(255, 167, 45, 36);
                              } else {
                                return const Color.fromARGB(255, 35, 104, 38);
                              }
                            },
                          )
                        ],
                        legend: Legend(
                            isVisible: true,
                            iconHeight: 20,
                            position: LegendPosition.bottom,
                            orientation: LegendItemOrientation.vertical),
                      ),
                    )
                  : Column(
                    children: [
                      Image.asset(
                          "assets/Empty_report.gif",
                          height: MediaQuery.of(context).size.width * 0.8,
                          width: MediaQuery.of(context).size.width * 0.8,
                        ),
                        Text("No Transaction Has Added For $formattedDate")
                    ],
                  );
            },
          );
        });
  }
}
