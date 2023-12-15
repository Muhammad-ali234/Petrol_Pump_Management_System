import 'package:flutter/material.dart';

class DailyExpenseScreen extends StatefulWidget {
  const DailyExpenseScreen({Key? key}) : super(key: key);

  @override
  _DailyExpenseScreenState createState() => _DailyExpenseScreenState();
}

class _DailyExpenseScreenState extends State<DailyExpenseScreen> {
  List<Expense> expenses = [
    Expense(
        name: 'Fuel',
        amount: 50,
        date: '2023-01-15',
        category: ExpenseCategory.transportation),
    Expense(
        name: 'Food',
        amount: 30,
        date: '2023-01-15',
        category: ExpenseCategory.food),
    // Add more expenses as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Expenses'),
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
          _buildExpenseList(),
          const SizedBox(height: 16.0),
          _buildTotalExpense(),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddExpenseScreen()),
              ).then((newExpense) {
                if (newExpense != null) {
                  _addExpense(newExpense);
                }
              });
            },
            child: const Text('Add New Expense'),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseList() {
    return Expanded(
      child: expenses.isEmpty
          ? const Center(
              child: Text(
                'No expenses available.\nAdd a new expense to get started!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return ExpenseCard(expense: expenses[index]);
              },
            ),
    );
  }

  Widget _buildTotalExpense() {
    int totalExpense =
        expenses.map((expense) => expense.amount).fold(0, (a, b) => a + b);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.red[100],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          const Text(
            'Total Expense',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            ' \$$totalExpense',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void _addExpense(Expense newExpense) {
    setState(() {
      expenses.add(newExpense);
    });
  }
}

class ExpenseCard extends StatelessWidget {
  final Expense expense;

  const ExpenseCard({Key? key, required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4.0,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          expense.name,
          style: TextStyle(color: getCategoryColor(expense.category)),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            Text(
              'Amount: \$${expense.amount}',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Date: ${expense.date}',
              style: const TextStyle(fontSize: 14.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Category: ${getCategoryName(expense.category)}',
              style: const TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }

  Color getCategoryColor(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.food:
        return Colors.orange;
      case ExpenseCategory.transportation:
        return Colors.blue;
      // Add more categories and colors as needed
      default:
        return Colors.grey;
    }
  }

  String getCategoryName(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.food:
        return 'Food';
      case ExpenseCategory.transportation:
        return 'Transportation';
      // Add more categories as needed
      default:
        return 'Other';
    }
  }
}

class Expense {
  final String name;
  final int amount;
  final String date;
  final ExpenseCategory category;

  Expense(
      {required this.name,
      required this.amount,
      required this.date,
      required this.category});
}

enum ExpenseCategory { food, transportation, other }

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Expense'),
      ),
      body: const Center(
        child: Text('This is the Add Expense Screen'),
      ),
    );
  }
}
