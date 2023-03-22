import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../add_transaction.dart';

class AddItemsScreen extends StatefulWidget {
  DateTime selectedDate = DateTime.now();
  String selectedValue = 'Expense';
  AddItemsScreen.internal({super.key});
  static AddItemsScreen instance = AddItemsScreen.internal();
  factory AddItemsScreen() {
    return instance;
  }

  @override
  State<AddItemsScreen> createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  @override
  void initState() {
    AddItemsScreen.instance.selectedDate = DateTime.now();
    AddItemsScreen.instance.selectedValue = 'Expense';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 71, 69, 69)),
        backgroundColor: Colors.transparent,
        title: const Text("Add items",
            style: TextStyle(
                color: Color.fromARGB(255, 71, 69, 69),
                fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12),
        child: ListView(
          children: [
            Form(
              child: Column(
                children: [
                  SizedBox(
                    width: 200,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now())
                            .then((date) {
                          if (date != null) {
                            setState(() {
                              AddItemsScreen.instance.selectedDate = date;
                            });
                          }
                        });
                      },
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 2.0),
                        child: Center(
                            child: Icon(
                          Icons.edit_calendar_outlined,
                          size: 20,
                          color: Color.fromARGB(255, 136, 128, 128),
                        )),
                      ),
                      label: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(right: 2.0),
                        child: Text(
                          DateFormat("dd,MMMM,yyyy")
                              .format(AddItemsScreen.instance.selectedDate),
                          style: const TextStyle(color: Colors.black),
                        ),
                      )),
                      style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xDFE0E0E0),
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                    ),
                  ),
                  DropdownButtonFormField(
                    value: AddItemsScreen.instance.selectedValue,
                    items: selectExpenseOrIncome.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        AddItemsScreen.instance.selectedValue =
                            value.toString();
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Container(
                    child: (AddItemsScreen.instance.selectedValue == "Expense")
                        ? const AddTransaction(
                            isExpense: true,
                          )
                        : const AddTransaction(isExpense: false),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
