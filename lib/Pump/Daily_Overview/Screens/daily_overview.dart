import 'package:flutter/material.dart';

import '../../Credit_Debit/Models/user.dart';

class DailyOverviewScreen extends StatelessWidget {
  final List<User>? users;

  const DailyOverviewScreen({Key? key, this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalCreditsToday = 0.0;
    double totalDebitsToday = 0.0;

    if (users != null) {
      // Calculate total credits and debits for today across all users
      for (var user in users!) {
        for (var transaction in user.transactions) {
          if (transaction.type == 'Credit') {
            totalCreditsToday += double.parse(transaction.amount);
          } else if (transaction.type == 'Debit') {
            totalDebitsToday += double.parse(transaction.amount);
          }
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Overview'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildOverviewCard(
                  'Today Credit', '$totalCreditsToday', Colors.green),
              _buildOverviewCard(
                  'Today Debit', '$totalDebitsToday', Colors.red),
              _buildOverviewCard('Today Expense', '50', Colors.orange),
              const SizedBox(height: 16),
              _buildOverviewCard('Net Amount', '250', Colors.blue),
              _buildOverviewCard('Today Sale', '1000', Colors.purple),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildOverviewCard(String title, String amount, Color color) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '\$$amount',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}
