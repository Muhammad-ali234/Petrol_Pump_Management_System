import 'package:flutter/material.dart';
import 'package:petrol_pump/Pump/Credit_Debit/Models/user.dart';

class AddUserScreen extends StatefulWidget {
  final Function(User) onUserAdded;

  const AddUserScreen({Key? key, required this.onUserAdded}) : super(key: key);

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
        backgroundColor: Colors.blue, // Set app bar background color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(nameController, 'Name'),
            const SizedBox(height: 16),
            _buildTextField(emailController, 'Email'),
            const SizedBox(height: 16),
            _buildTextField(contactController, 'Contact'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                User newUser = User(
                  name: nameController.text,
                  email: emailController.text,
                  contact: contactController.text,
                );
                widget.onUserAdded(newUser);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Set button background color
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.blue), // Set label text color
        focusedBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.blue), // Set border color when focused
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey), // Set border color when not focused
        ),
      ),
    );
  }
}
