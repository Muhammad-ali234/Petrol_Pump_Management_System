import 'package:flutter/material.dart';
import 'package:petrol_pump/Screens/Pump%20Screens/daily_expense%20screen.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  ExpenseCategory selectedCategory = ExpenseCategory.food;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Expense'),
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
          _buildTextField(nameController, 'Expense Name'),
          const SizedBox(height: 20),
          _buildTextField(
              amountController, 'Expense Amount', TextInputType.number),
          const SizedBox(height: 20),
          _buildTextField(dateController, 'Expense Date', TextInputType.text),
          const SizedBox(height: 20),
          _buildCategoryDropdown(),
          const SizedBox(height: 20),
          _buildSaveButton(),
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
              _buildTextField(nameController, 'Expense Name'),
              const SizedBox(height: 20),
              _buildTextField(
                  amountController, 'Expense Amount', TextInputType.number),
              const SizedBox(height: 20),
              _buildTextField(
                  dateController, 'Expense Date', TextInputType.text),
              const SizedBox(height: 20),
              _buildCategoryDropdown(),
              const SizedBox(height: 20),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      [TextInputType keyboardType = TextInputType.text]) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<ExpenseCategory>(
      value: selectedCategory,
      onChanged: (value) {
        setState(() {
          selectedCategory = value!;
        });
      },
      items: ExpenseCategory.values.map((category) {
        return DropdownMenuItem<ExpenseCategory>(
          value: category,
          child: Text(getCategoryName(category)),
        );
      }).toList(),
      decoration: const InputDecoration(
        labelText: 'Expense Category',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        _saveExpense();
        Navigator.pop(context, _createNewExpense());
      },
      child: const Text('Save Expense'),
    );
  }

  void _saveExpense() {
    // Implement logic to save the expense to your data structure or database
  }

  Expense _createNewExpense() {
    return Expense(
      name: nameController.text,
      amount: int.parse(amountController.text),
      date: dateController.text,
      category: selectedCategory,
    );
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
