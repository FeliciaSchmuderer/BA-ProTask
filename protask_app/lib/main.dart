import 'package:flutter/material.dart';
import 'package:protask_app/navigation/navigation_screen.dart';
import 'package:protask_app/provider/daily_budget_provider.dart';
import 'package:protask_app/provider/todo_provider.dart';
import 'package:protask_app/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('de_DE', '');
  runApp(
    // makes TodoProvider and DailyBudgetProvider available to all screens below
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TodoProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DailyBudgetProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme,
      home: const NavigationScreen(),
    );
  }
}
