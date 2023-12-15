import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedPetrolPump;

  List<String> petrolPumps = ["Pump 1", "Pump 2", "Pump 3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "Login",
      //     style: TextStyle(fontSize: 30),
      //   ),
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Image(
                image: AssetImage("assets/png1.png"),
                height: 200,
                width: 200,
              ),
              const SizedBox(
                height: 30,
              ),
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
              ElevatedButton(
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
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
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
            ],
          ),
        ),
      ),
    );
  }
}
