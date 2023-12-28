import 'package:flutter/material.dart';
import 'package:petrol_pump/Pump/Expense/Screens/daily_expense.dart';
import 'package:petrol_pump/Pump/login_screen.dart';
import 'package:petrol_pump/Pump/Daily_Overview/Screens/daily_overview.dart';
import 'package:petrol_pump/Pump/pump_dashboared_screen.dart';

import 'package:petrol_pump/Pump/Stocks/Screens/stocks_screen.dart';

import 'package:petrol_pump/splash_screen.dart';
import 'package:petrol_pump/Pump/Credit_Debit/Screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/dashboardScreen': (context) => const DashboardScreen(),
        '/stock': (context) => const StocksScreen(),
        '/daily_expense': (context) => const DailyExpenseScreen(),
        '/daily_overview': (context) => const DailyOverviewScreen(
              users: [],
            ),
        '/userscreen': (context) => const MainScreen(),
      },
    );
  }
}
