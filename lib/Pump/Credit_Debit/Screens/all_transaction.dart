import 'package:flutter/material.dart';

import '../Models/transaction.dart';
import '../Models/user.dart';
import 'user_detailed.dart';

class AllTransactionsScreen extends StatelessWidget {
  final List<User> users;

  const AllTransactionsScreen({Key? key, required this.users})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get today's date
    DateTime today = DateTime.now();

    // Filter transactions for today
    List<Transaction> allTransactions = users
        .expand((user) => user.transactions)
        .where((transaction) =>
            transaction.date.year == today.year &&
            transaction.date.month == today.month &&
            transaction.date.day == today.day)
        .toList();

    // Calculate total credits and debits for today
    double totalCreditsToday = allTransactions
        .where((transaction) => transaction.type == 'Credit')
        .map((transaction) => double.parse(transaction.amount))
        .fold(0, (a, b) => a + b);

    double totalDebitsToday = allTransactions
        .where((transaction) => transaction.type == 'Debit')
        .map((transaction) => double.parse(transaction.amount))
        .fold(0, (a, b) => a + b);

    return Scaffold(
        appBar: AppBar(
          title: const Text('All Transactions'),
        ),
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            List<Transaction> userTransactions = users[index].transactions;

            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  users[index].name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: userTransactions
                      .map((transaction) => _buildTransactionItem(transaction))
                      .toList(),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserDetailsScreen(user: users[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          child: SingleChildScrollView(
            // Wrap with SingleChildScrollView
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: [
                  Text(
                    'Total Credits Today: $totalCreditsToday',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Total Debits Today: $totalDebitsToday',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildTransactionItem(Transaction transaction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${transaction.type}: ${transaction.amount}',
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
