import 'package:flutter/material.dart';
import 'package:petrol_pump/Pump/Credit_Debit/Models/user.dart';
import '../../Daily_Overview/Screens/daily_overview.dart';
import '../Models/transaction.dart';

class CreditsDebitsScreen extends StatelessWidget {
  final User user;
  List<User> users = [];

  CreditsDebitsScreen({Key? key, required this.user, required this.users})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credits/Debits'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTransactionList('Credits', 'Credit', Colors.green),
            const SizedBox(height: 16),
            _buildTransactionList('Debits', 'Debit', Colors.red),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DailyOverviewScreen(
                              users: [],
                            )),
                  );
                },
                child: const Text("press"))
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList(String title, String type, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: color),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: user.transactions
              .where((transaction) => transaction.type == type)
              .map((transaction) => _buildTransactionItem(transaction))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            transaction.amount,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            'Date: ${_formatDate(transaction.date)}',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
