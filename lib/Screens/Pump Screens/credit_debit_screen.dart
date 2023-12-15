import 'package:flutter/material.dart';

class CreditDebitScreen extends StatefulWidget {
  const CreditDebitScreen({Key? key}) : super(key: key);

  @override
  _CreditDebitScreenState createState() => _CreditDebitScreenState();
}

class _CreditDebitScreenState extends State<CreditDebitScreen> {
  List<Transaction> transactions = [
    Transaction(
        type: TransactionType.credit,
        amount: 500,
        date: '2023-01-15',
        description: 'Supplier payment'),
    Transaction(
        type: TransactionType.debit,
        amount: 200,
        date: '2023-01-20',
        description: 'Maintenance expense'),
    // Add more transactions as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credit/Debit Transactions'),
        actions: [
          IconButton(
            onPressed: () {
              // Implement filter action
              // You can show a bottom sheet or navigate to a separate filter screen
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16.0),
          _buildTransactionList(),
          const SizedBox(height: 16.0),
          _buildTotalBalance(),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddTransactionScreen()),
              ).then((newTransaction) {
                if (newTransaction != null) {
                  _addTransaction(newTransaction);
                }
              });
            },
            child: const Text('Add New Transaction'),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    return Expanded(
      child: transactions.isEmpty
          ? const Center(
              child: Text(
                'No transactions available.\nAdd a new transaction to get started!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return TransactionCard(transaction: transactions[index]);
              },
            ),
    );
  }

  Widget _buildTotalBalance() {
    int totalCredit = transactions
        .where((transaction) => transaction.type == TransactionType.credit)
        .map((transaction) => transaction.amount)
        .fold(0, (a, b) => a + b);

    int totalDebit = transactions
        .where((transaction) => transaction.type == TransactionType.debit)
        .map((transaction) => transaction.amount)
        .fold(0, (a, b) => a + b);

    int totalBalance = totalCredit - totalDebit;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: totalBalance >= 0 ? Colors.green[100] : Colors.red[100],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          const Text(
            'Total Balance',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            ' \$$totalBalance',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
              color: totalBalance >= 0 ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void _addTransaction(Transaction newTransaction) {
    setState(() {
      transactions.add(newTransaction);
    });
  }
}

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange[400],
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4.0,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          transaction.type == TransactionType.credit ? 'Credit' : 'Debit',
          style: TextStyle(
              color: transaction.type == TransactionType.credit
                  ? Colors.green
                  : Colors.red,
              fontSize: 20),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            Text(
              'Amount: \$${transaction.amount}',
              style: const TextStyle(fontSize: 17.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Date: ${transaction.date}',
              style: const TextStyle(fontSize: 15.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Description: ${transaction.description}',
              style: const TextStyle(fontSize: 15.0),
            ),
          ],
        ),
      ),
    );
  }
}

class Transaction {
  final TransactionType type;
  final int amount;
  final String date;
  final String description;

  Transaction(
      {required this.type,
      required this.amount,
      required this.date,
      required this.description});
}

enum TransactionType { credit, debit }

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Transaction'),
      ),
      body: const Center(
        child: Text('This is the Add Transaction Screen'),
      ),
    );
  }
}
