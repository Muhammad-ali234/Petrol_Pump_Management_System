import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your splash screen content here
            const Text(
              'Welcome to PetroLink',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            const Image(image: AssetImage("assets/png1.png")),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 50),
                  backgroundColor: Colors.orange),
              onPressed: () {
                // Navigate to the login screen
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text("Let's Go"),
            ),
          ],
        ),
      ),
    );
  }
}
