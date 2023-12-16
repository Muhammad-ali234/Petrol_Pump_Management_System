import 'package:flutter/material.dart';
import 'package:petrol_pump/Screens/Pump%20Screens/credit_debit_screen.dart';
import 'package:petrol_pump/Screens/Pump%20Screens/daily_expense%20screen.dart';
import 'package:petrol_pump/Screens/Pump%20Screens/login_screen.dart';
import 'package:petrol_pump/Screens/Pump%20Screens/profit_sales_screen.dart';
import 'package:petrol_pump/Screens/Pump%20Screens/pump_dashboared_screen.dart';

import 'package:petrol_pump/Screens/Pump%20Screens/stocks_screen.dart';

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
        '/login': (context) => const LoginScreen(),
        '/dashboardScreen': (context) => const DashboardScreen(),
        '/stock': (context) => const StocksScreen(),
        '/credit_debit': (context) => const CreditDebitScreen(),
        '/daily_expense': (context) => const DailyExpenseScreen(),
        '/profit_sales': (context) => const ProfitSalesScreen(),
      },
    );
  }
}
