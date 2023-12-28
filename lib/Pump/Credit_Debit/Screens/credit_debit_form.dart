import 'package:flutter/material.dart';

import '../Models/transaction.dart';
import '../Models/user.dart';

class CreditDebitFormScreen extends StatefulWidget {
  final User user;
  final String type;
  final Function onCreditDebitAdded;

  const CreditDebitFormScreen(
      {super.key,
      required this.user,
      required this.type,
      required this.onCreditDebitAdded});

  @override
  _CreditDebitFormScreenState createState() =>
      _CreditDebitFormScreenState(user: user, type: type);
}

class _CreditDebitFormScreenState extends State<CreditDebitFormScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final User user;
  final String type;

  _CreditDebitFormScreenState({required this.user, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add $type'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            TextField(
              controller: dateController,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _addCreditDebit();
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _addCreditDebit() {
    setState(() {
      String amount = amountController.text;
      String dateText = dateController.text;

      if (amount.isNotEmpty && dateText.isNotEmpty) {
        DateTime date = DateTime.parse(dateText);

        Transaction transaction = Transaction(
          type: type,
          amount: amount,
          date: date,
        );

        widget.user.transactions.add(transaction);
        widget.onCreditDebitAdded();
      }
    });
  }
}
