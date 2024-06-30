import 'package:flutter/material.dart';
import 'package:SpeedyServe/screens/auth_screens/login_screen.dart'; // Import your login screen if needed
import 'package:SpeedyServe/screens/auth_screens/register.dart'; // Import your registration screen if needed

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.redAccent, // Replace with your desired background color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  'images/rice.png', // Replace with your asset image path
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'SpeedyServe',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Order your favorite Meals Here!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(), // Navigate to your login screen
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.redAccent, backgroundColor: Colors.white, // Text color
                  padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                ),
                child: const Text('Sign in'),
              ),
              const SizedBox(height: 20.0),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Registration(), // Navigate to your registration screen
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white, side: const BorderSide(color: Colors.white), // Border color
                  padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                ),
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
