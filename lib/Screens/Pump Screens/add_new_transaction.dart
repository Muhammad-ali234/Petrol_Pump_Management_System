import 'package:flutter/material.dart';
import 'package:petrol_pump/Screens/Pump%20Screens/credit_debit_screen.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.isMobile) {
            return _buildMobileLayout();
          } else {
            return _buildWebLayout();
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTransactionTypeRow(),
          const SizedBox(height: 20),
          _buildAmountTextField(),
          const SizedBox(height: 20),
          _buildDateTextField(),
          const SizedBox(height: 20),
          _buildDescriptionTextField(),
          const SizedBox(height: 20),
          _buildSaveTransactionButton(),
        ],
      ),
    );
  }

  Widget _buildWebLayout() {
    return Center(
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTransactionTypeRow(),
              const SizedBox(height: 20),
              _buildAmountTextField(),
              const SizedBox(height: 20),
              _buildDateTextField(),
              const SizedBox(height: 20),
              _buildDescriptionTextField(),
              const SizedBox(height: 20),
              _buildSaveTransactionButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionTypeRow() {
    return Row(
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
    );
  }

  Widget _buildAmountTextField() {
    return TextField(
      controller: amountController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Enter Amount',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDateTextField() {
    return TextField(
      controller: dateController,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Enter Date',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDescriptionTextField() {
    return TextField(
      controller: descriptionController,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Enter Description',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildSaveTransactionButton() {
    return ElevatedButton(
      onPressed: () {
        _saveTransaction();
        Navigator.pop(context, _createNewTransaction());
      },
      child: const Text('Save Transaction'),
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
