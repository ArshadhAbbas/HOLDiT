import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'splash/splash_screen.dart';
import 'db/category_db/category_db_functions.dart';
import 'db/category_db/category_db_model.dart';
import 'db/transactions_db/transaction_model.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(IconDataAdapter());
    Hive.registerAdapter(ColorAdapter());
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  final prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('predefCategoryCalled')) {
    CategoryDB.instance.predefCategory();
    await prefs.setBool('predefCategoryCalled', true);
  }

  runApp(const Holdit());
}

class Holdit extends StatelessWidget {
  const Holdit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        home: const SplashScreen());
  }
}
