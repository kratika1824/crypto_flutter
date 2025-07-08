import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../screens/otp_screen.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool agree = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset('assets/connect_logo.jpg', height: 28, width: 28),
                    const SizedBox(width: 8),
                    const Text("ConnectPlus", style: TextStyle(color: Colors.yellow, fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                const Text("Welcome to ConnectPlus", style: TextStyle(color: Colors.white70, fontSize: 16)),
                const SizedBox(height: 30),

                TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _buildInputDecoration("Email/Phone", Icons.alternate_email),
                ),
                const SizedBox(height: 20),

                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: _buildInputDecoration("Password", Icons.lock),
                ),
                const SizedBox(height: 20),

                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: _buildInputDecoration("Confirm Password", Icons.lock_outline),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Checkbox(
                      value: agree,
                      onChanged: (val) => setState(() => agree = val!),
                      activeColor: Colors.yellow,
                    ),
                    Expanded(
                      child: Text(
                        "By creating an account, I agree to ConnectPlus's Terms of Service and Privacy Notice.",
                        style: TextStyle(color: Colors.grey[400], fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: _isLoading ? null : _handleGetOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text("Get OTP", style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? ", style: TextStyle(color: Colors.white70)),
                    GestureDetector(
                      onTap: () {
                        // Navigate to login
                      },
                      child: const Text("Login", style: TextStyle(color: Colors.yellow)),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[700])),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("or", style: TextStyle(color: Colors.white70)),
                    ),
                    Expanded(child: Divider(color: Colors.grey[700])),
                  ],
                ),
                const SizedBox(height: 20),

                Column(
                  children: [
                    _buildSocialButton("Continue with Google", "assets/google_logo.png"),
                    const SizedBox(height: 12),
                    _buildSocialButton("Continue with Apple", "assets/apple_logo.png"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      prefixIcon: Icon(icon, color: Colors.grey),
      filled: true,
      fillColor: Colors.transparent,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.yellow),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.yellow, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildSocialButton(String label, String assetPath) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Image.asset(assetPath, height: 22),
      label: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2C2C2C),
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  Future<void> _handleGetOtp() async {
    if (!agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please accept Terms & Conditions"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields"), backgroundColor: Colors.red),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match"), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isLoading = true);

    final otpSent = await ApiService.sendOtp(email);
    print("OTP Response: $otpSent");

    setState(() => _isLoading = false);

    if (otpSent) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("OTP sent successfully"), backgroundColor: Colors.green),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OtpScreen(email: email, password: password),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to send OTP"), backgroundColor: Colors.red),
      );
    }
  }
}
