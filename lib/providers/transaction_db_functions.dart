

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:holdit/db/transactions_db/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-db';
class TransactionDBProvider extends ChangeNotifier {

  List<TransactionModel> transactionListNotifier = [];


  Future<void> addTransactions(TransactionModel obj) async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await db.put(obj.id, obj);
    
  }


  Future<void>refresh()async
  {
    final list=await getAllTransactions();
    transactionListNotifier.clear();
    transactionListNotifier.addAll(list);
    notifyListeners();
    
  }

 
  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return db.values.toList();
  }
  
 
  Future<void> deleteTransaction(String id) async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await db.delete(id);
    refresh();
  }
  

  Future<void> updateTransaction(TransactionModel updatedTransaction) async {
  final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
  final transaction = db.get(updatedTransaction.id);
  if (transaction != null) {
    await db.put(updatedTransaction.id, updatedTransaction);
    await refresh();
  }
}
}
