import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedPetrolPump;

  List<String> petrolPumps = ["Pump 1", "Pump 2", "Pump 3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.isDesktop) {
            return _buildWebLayout();
          } else {
            return _buildMobileLayout();
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _buildFormFields(),
        ),
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildFormFields(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    return [
      const Center(
        child: Image(
          image: AssetImage("assets/png1.png"),
          height: 200,
          width: 200,
        ),
      ),
      const SizedBox(height: 30),
      TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "Email",
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.orange[400],
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your email';
          }
          return null;
        },
      ),
      const SizedBox(height: 16.0),
      TextFormField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Password",
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.orange[400],
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
      ),
      const SizedBox(height: 16.0),
      DropdownButtonFormField(
        value: _selectedPetrolPump,
        items: petrolPumps.map((pump) {
          return DropdownMenuItem(
            value: pump,
            child: Text(pump),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedPetrolPump = value;
          });
        },
        decoration: const InputDecoration(
          labelText: "Select Petrol Pump",
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null) {
            return 'Please select a petrol pump';
          }
          return null;
        },
      ),
      const SizedBox(height: 32.0),
      Center(
        child: ElevatedButton(
          onPressed: () {
            // if (_formKey.currentState!.validate()) {
            // Perform login or signup logic here
            // You can use _emailController.text, _passwordController.text, and _selectedPetrolPump
            // print("Email: ${_emailController.text}");
            // print("Password: ${_passwordController.text}");
            // print("Petrol Pump: $_selectedPetrolPump");

            // Navigate to the dashboard screen
            Navigator.pushNamed(context, "/dashboardScreen");
            // }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
                vertical: 25.0, horizontal: 100), // Adjust the height here
            backgroundColor: Colors.orange[400],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    ];
  }
}
