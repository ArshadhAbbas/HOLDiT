import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../db/transactions_db/transaction_db_functions.dart';
import '../db/transactions_db/transaction_model.dart';
import 'update_transaction.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Variables for date range
  DateTime? startDate;
  DateTime? endDate;
  // dropdownbutton items
  List<String> searchTransactionTypeItems = ["All", "Expenses", "Income"];

  List<TransactionModel> totalTransactionList =
      TransactionDB.instance.transactionListNotifier.value;
  ValueNotifier<String> selectedTransactionType = ValueNotifier('All');
  ValueNotifier<List<TransactionModel>> outputList = ValueNotifier([]);
  TextEditingController searchTextController = TextEditingController();
  String query = '';

  @override
  void initState() {
    outputList.value = totalTransactionList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 71, 69, 69)),
        backgroundColor: Colors.transparent,
        title: const Text("Search",
            style: TextStyle(
                color: Color.fromARGB(255, 71, 69, 69),
                fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xDFE0E0E0)),
              child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                      height: 10,
                      alignedDropdown: true,
                      child: DropdownButton(
                          borderRadius: BorderRadius.circular(20),
                          iconSize: 20,
                          value: selectedTransactionType.value,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: searchTransactionTypeItems.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedTransactionType.value = newValue!;
                              selectedTransactionType.notifyListeners();
                            });
                          }))),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Card(
                color: const Color.fromARGB(255, 231, 231, 231),
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: TextFormField(
                      controller: searchTextController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search for transactions',
                        suffixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) => setState(() {
                        query = value;
                      }),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue, width: 2)),
                onPressed: () {
                  showCustomDateRangePicker(
                    context,
                    dismissible: true,
                    minimumDate: DateTime(2010),
                    maximumDate: DateTime.now(),
                    endDate: endDate,
                    startDate: startDate,
                    onApplyClick: (start, end) {
                      setState(() {
                        endDate = end;
                        startDate = start;
                      });
                    },
                    onCancelClick: () {
                      setState(() {
                        endDate = null;
                        startDate = null;
                      });
                    },
                  );
                },
                child: startDate == null
                    ? const Text(
                        "Choose a date range",
                        style: TextStyle(color: Colors.grey),
                      )
                    : Text(
                        style: const TextStyle(color: Colors.grey),
                        '${startDate != null ? DateFormat("dd/MMM/yyyy").format(startDate!) : '-'} - ${endDate != null ? DateFormat("dd/MMM/yyyy").format(endDate!) : '-'}',
                      ),
              ),
              ValueListenableBuilder(
                  valueListenable: selectedTransactionType,
                  builder: (context, selectedType, _) {
                    List<TransactionModel> filteredList =
                        totalTransactionList.where((element) {
                      bool matchesQuery = element.category!.name
                              .trim()
                              .toLowerCase()
                              .contains(query.trim().toLowerCase()) ||
                          element.description
                              .trim()
                              .toLowerCase()
                              .contains(query.trim().toLowerCase());

                      if (selectedType == searchTransactionTypeItems[0]) {
                        return matchesQuery;
                      } else if (selectedType ==
                          searchTransactionTypeItems[1]) {
                        return element.isExpense == true && matchesQuery;
                      } else {
                        return element.isExpense == false && matchesQuery;
                      }
                    }).toList();

                    if (startDate != null && endDate != null) {
                      filteredList = filteredList
                          .where((element) =>
                              element.date.isBefore(
                                  endDate!.add(const Duration(days: 1))) &&
                              element.date.isAfter(
                                  startDate!.subtract(const Duration(days: 1))))
                          .toList();
                    }

                    outputList.value = filteredList;
                    outputList.notifyListeners();

                    if (outputList.value.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/search_result-null.gif",
                              height: MediaQuery.of(context).size.width * 0.6,
                            ),
                            const Text("No data found")
                          ],
                        ),
                      );
                    } else {
                      return ValueListenableBuilder(
                          valueListenable: outputList,
                          builder:
                              (context, List<TransactionModel> newList, _) {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: outputList.value.length,
                                itemBuilder: (context, index) {
                                  TransactionModel value = newList[index];
                                  return ListTile(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateScreen(
                                                      id: value.id,
                                                      selectedValue:
                                                          value.isExpense
                                                              ? "Expense"
                                                              : "Income",
                                                      selectedDate: value.date,
                                                      selectedCategory:
                                                          value.category!,
                                                      selectedAmount:
                                                          value.amount,
                                                      selectedDescription:
                                                          value.description)),
                                        );
                                      },
                                      leading: Stack(children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              value.category!.color,
                                        ),
                                        Positioned.fill(
                                            child: Icon(value.category!.icon))
                                      ]),
                                      title: Text(value.description),
                                      subtitle: Text(value.category!.name),
                                      trailing: value.isExpense
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "- ₹ ${value.amount}",
                                                  style: const TextStyle(
                                                      color: Colors.red),
                                                ),
                                                Text(DateFormat("dd/MMM/yyyy")
                                                    .format(value.date))
                                              ],
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("+ ₹ ${value.amount}"),
                                                Text(DateFormat("dd/MMM/yyyy")
                                                    .format(value.date))
                                              ],
                                            ));
                                });
                          });
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
