

import 'package:flutter/material.dart';
import 'package:holdit/home/new_transaction/screen/add_item_screen.dart';

import '../../common_widgets/add_new_category.dart';
import '../../common_widgets/category_selection_dropdown.dart';
import '../../db/transactions_db/transaction_db_functions.dart';
import '../../db/transactions_db/transaction_model.dart';

List<String> selectExpenseOrIncome = <String>['Expense', 'Income'];
class AddTransaction extends StatefulWidget {
  const AddTransaction({required this.isExpense, Key? key}) : super(key: key);
 final bool isExpense;

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final amountTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.isExpense
                    ? ExpenseCategoryDropDown()
                    : IncomeCategoryDropDown(),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      showCategoryDialog(context);
                    },
                    icon: const Icon(Icons.add_circle_outline_sharp),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: amountTextController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter an amount";
                }
                return null;
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.currency_rupee),
                  border: OutlineInputBorder(),
                  labelText: "Enter Amount"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter Description";
                }
                return null;
              },
              controller: descriptionTextController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.format_color_text_rounded),
                  border: OutlineInputBorder(),
                  labelText: "Description"),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addTransaction();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("New Transaction Added"),
                      duration: Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                    ));
                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: const Padding(
                  padding:  EdgeInsets.all(20.0),
                  child: Text("Add Transaction"),
                ),
              ),
            )
          ],
        ));
  }

  Future addTransaction() async {
    final amount = double.parse(amountTextController.text);
    final description = descriptionTextController.text;

    final model = TransactionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        date: AddItemsScreen.instance.selectedDate,
        isExpense: widget.isExpense,
        category: selectedCategoryModel!,
        amount: amount,
        description: description.trim());

    TransactionDB.instance.addTransactions(model);
    TransactionDB.instance.refresh();
  }
}

void showCategoryDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const AddCategoryDialogue();
    },
  );
}
