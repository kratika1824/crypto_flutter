import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _identifierController = TextEditingController(); // Email / Phone
  final _passwordController = TextEditingController();
  bool _stayLoggedIn = false;

  void _loginUser() {
    print("Identifier: ${_identifierController.text}");
    print("Password: ${_passwordController.text}");
    print("Stay logged in: $_stayLoggedIn");

    // TODO: Backend API call here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0D1E),
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF14172B),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Log In",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Email/Phone input
              TextField(
                controller: _identifierController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Email / Sub-Account / Mobile',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.email, color: Colors.grey),
                  filled: true,
                  fillColor: Color(0xFF1F2238),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Password input
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.lock, color: Colors.grey),
                  filled: true,
                  fillColor: Color(0xFF1F2238),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Stay logged in checkbox
              Row(
                children: [
                  Checkbox(
                    value: _stayLoggedIn,
                    onChanged: (val) {
                      setState(() => _stayLoggedIn = val!);
                    },
                    activeColor: Colors.blue,
                  ),
                  const Expanded(
                    child: Text(
                      "Stay logged in on this device for 5 days",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Log In button
              ElevatedButton(
                onPressed: _loginUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2275E3),
                  minimumSize: const Size(double.infinity, 45),
                ),
                child: const Text("Log In", style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 10),

              // Forgot + Signup
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text("Forgot Password?", style: TextStyle(color: Colors.grey)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // goes back to SignUp screen
                    },
                    child: const Text("Sign up now!", style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),

              // Login with Google
              const Text("or log in with", style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.g_mobiledata, size: 40, color: Colors.white),
                    onPressed: () {
                      // TODO: Add Google Login
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}