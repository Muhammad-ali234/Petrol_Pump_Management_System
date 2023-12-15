import 'package:flutter/material.dart';
import 'package:petrol_pump/Screens/Pump%20Screens/credit_debit_screen.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TransactionType selectedType = TransactionType.credit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Transaction Type:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Radio(
                  value: TransactionType.credit,
                  groupValue: selectedType,
                  onChanged: (value) {
                    setState(() {
                      selectedType = value as TransactionType;
                    });
                  },
                ),
                const Text('Credit'),
                Radio(
                  value: TransactionType.debit,
                  groupValue: selectedType,
                  onChanged: (value) {
                    setState(() {
                      selectedType = value as TransactionType;
                    });
                  },
                ),
                const Text('Debit'),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter Amount'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: dateController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: 'Enter Date'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: 'Enter Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveTransaction();
                Navigator.pop(context, _createNewTransaction());
              },
              child: const Text('Save Transaction'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveTransaction() {
    // Implement logic to save the transaction to your data structure or database
  }

  Transaction _createNewTransaction() {
    return Transaction(
      type: selectedType,
      amount: int.parse(amountController.text),
      date: dateController.text,
      description: descriptionController.text,
    );
  }
}
