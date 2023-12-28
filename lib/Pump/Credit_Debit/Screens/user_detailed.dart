import 'package:flutter/material.dart';
import 'package:petrol_pump/Pump/Credit_Debit/Screens/credit_debit_form.dart';

import '../Models/user.dart';
import 'credit_debit.dart';

class UserDetailsScreen extends StatefulWidget {
  final User user;

  const UserDetailsScreen({Key? key, required this.user}) : super(key: key);

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  double totalCredits = 0.0;
  double totalDebits = 0.0;
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    // Calculate total credits and debits
    totalCredits = 0.0;
    totalDebits = 0.0;

    for (var transaction in widget.user.transactions) {
      if (transaction.type == 'Credit') {
        totalCredits += double.parse(transaction.amount);
      } else {
        totalDebits += double.parse(transaction.amount);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Implement edit user functionality if needed
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoTile('Name', widget.user.name, Icons.person),
            _buildInfoTile('Email', widget.user.email, Icons.email),
            _buildInfoTile('Contact', widget.user.contact, Icons.phone),
            const SizedBox(height: 16),
            _buildTotalTile('Total Credits', totalCredits, Icons.arrow_upward,
                Colors.green),
            _buildTotalTile(
                'Total Debits', totalDebits, Icons.arrow_downward, Colors.red),
            const SizedBox(height: 32),
            _buildElevatedButton(
                'Add Credit', 'Credit', Icons.add, Colors.green),
            const SizedBox(height: 16),
            _buildElevatedButton(
                'Add Debit', 'Debit', Icons.remove, Colors.red),
            const SizedBox(height: 16),
            _buildElevatedButton(
                'View Credits/Debits', 'View', Icons.list, Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String subtitle, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }

  Widget _buildTotalTile(
      String title, double total, IconData icon, Color iconColor) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text('$title: $total'),
    );
  }

  Widget _buildElevatedButton(
      String text, String type, IconData icon, Color color) {
    return ElevatedButton(
      onPressed: () {
        _navigateToCreditDebitFormScreen(context, type);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }

  void _navigateToCreditDebitFormScreen(BuildContext context, String type) {
    if (type == 'Credit' || type == 'Debit') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreditDebitFormScreen(
            user: widget.user,
            type: type,
            onCreditDebitAdded: _updateUser,
          ),
        ),
      );
    } else if (type == 'View') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreditsDebitsScreen(
            user: widget.user,
            users: users,
          ),
        ),
      );
    }
  }

  void _updateUser() {
    setState(() {
      // Update the user details
    });
  }
}
