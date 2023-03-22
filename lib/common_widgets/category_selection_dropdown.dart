import 'package:flutter/material.dart';

import '../db/category_db/category_db_functions.dart';
import '../db/category_db/category_db_model.dart';
import 'categories_list_style.dart';


// Income categories dropdown list

class IncomeCategoryDropDown extends StatefulWidget {
  String? selectedIncomeItem;

  IncomeCategoryDropDown.internal({super.key});
  static IncomeCategoryDropDown instance = IncomeCategoryDropDown.internal();
  factory IncomeCategoryDropDown() {
    return instance;
  }

  @override
  IncomeDropDownState createState() => IncomeDropDownState();
}

class IncomeDropDownState extends State<IncomeCategoryDropDown> {
  List<DropdownMenuItem<String>> catitems = [];

  @override
  void initState() {
    super.initState();
    IncomeCategoryDropDown.instance.selectedIncomeItem = null;
    loadInitialCategories();
  }

  Future<void> loadInitialCategories() async {
    final catItems = await CategoryLoader.loadCategories(
      isExpense: false,
      selectedCategory: IncomeCategoryDropDown.instance.selectedIncomeItem,
      context: context,
    );
    setState(() {
      catitems = catItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    loadInitialCategories();
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ButtonTheme(
        child: DropdownButtonFormField<String>(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Select a category";
            }
            return null;
          },
          decoration: const InputDecoration(
            hintText: "Select Category",
            border: OutlineInputBorder(),
          ),
          items: catitems,
          value: IncomeCategoryDropDown.instance.selectedIncomeItem,
          onChanged: (value) {
            setState(() {
              IncomeCategoryDropDown.instance.selectedIncomeItem = value;
            });
          },
        ),
      ),
    );
  }
}

// Expense categories dropdown list

class ExpenseCategoryDropDown extends StatefulWidget {
  String? selectedExpenseItem;

  ExpenseCategoryDropDown.internal({super.key});
  static ExpenseCategoryDropDown instance = ExpenseCategoryDropDown.internal();
  factory ExpenseCategoryDropDown() {
    return instance;
  }
  @override
  ExpenseDropDownState createState() => ExpenseDropDownState();
}

class ExpenseDropDownState extends State<ExpenseCategoryDropDown> {
  List<DropdownMenuItem<String>> catitems = [];
  @override
  void initState() {
    ExpenseCategoryDropDown.instance.selectedExpenseItem = null;
    super.initState();
    loadInitialCategories();
  }

  Future<void> loadInitialCategories() async {
    final catItems = await CategoryLoader.loadCategories(
      isExpense: true,
      selectedCategory: ExpenseCategoryDropDown.instance.selectedExpenseItem,
      context: context,
    );
    setState(() {
      catitems = catItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    loadInitialCategories();
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ButtonTheme(
                child: DropdownButtonFormField<String>(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Select a category";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Select Category",
                    border: OutlineInputBorder(),
                  ),
                  items: catitems,
                  value: ExpenseCategoryDropDown.instance.selectedExpenseItem,
                  onChanged: (value) {
                    setState(() {
                      ExpenseCategoryDropDown.instance.selectedExpenseItem =
                          value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Category loader method
CategoryModel? selectedCategoryModel;

class CategoryLoader {
  static Future<List<DropdownMenuItem<String>>> loadCategories({
    required bool isExpense,
    required String? selectedCategory,
    required BuildContext context,
  }) async {
    final categories = await CategoryDB().getCategories();
    final catItems = categories
        .where((category) => category.isExpense == isExpense)
        .map((category) {
      final isSelected = category.name == selectedCategory;
      return DropdownMenuItem(
        onTap: () {
          selectedCategoryModel = category;
        },
        value: category.name,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StockCatitem(
                catcolour: category.color,
                caticon: category.icon,
                catname: category.name),
            if (!isSelected)
              GestureDetector(
                child: const Icon(
                  Icons.close,
                  color: Color.fromARGB(255, 161, 159, 159),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Delete'),
                        content: const Text(
                            'Do you sure want to delete this Category?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              CategoryDB.instance.deleteCategory(category.id);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("${category.name} is deleted"),
                                duration: const Duration(seconds: 1),
                                behavior: SnackBarBehavior.floating,
                              ));
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
              )
          ],
        ),
      );
    }).toList();
    return catItems;
  }
}
