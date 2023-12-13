import 'package:flutter/material.dart';
import 'package:petrol_pump/Screens/credit_debit_screen.dart';
import 'package:petrol_pump/Screens/daily_expense%20screen.dart';
import 'package:petrol_pump/Screens/dashboared_screen.dart';
import 'package:petrol_pump/Screens/inventry_screen.dart';
import 'package:petrol_pump/Screens/login_screen.dart';
import 'package:petrol_pump/Screens/profit_sales_screen.dart';
import 'package:petrol_pump/Screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const AuthScreen(),
        '/dashboardScreen': (context) => const DashboardScreen(),
        '/inventory': (context) => const InventoryScreen(),
        '/credit_debit': (context) => const CreditDebitScreen(),
        '/daily_expense': (context) => const DailyExpenseScreen(),
        '/profit_sales': (context) => const ProfitSalesScreen(),
      },
    );
  }
}
