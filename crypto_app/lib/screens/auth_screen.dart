import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool agreeToTerms = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _buildEmailForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Email", style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextField(
          controller: _emailController,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration("Enter your email", Icons.email),
        ),
        const SizedBox(height: 20),
        const Text("Password", style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextField(
          controller: _passwordController,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration("Enter your password", Icons.lock),
        ),
        const SizedBox(height: 20),
        const Text("Confirm Password", style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextField(
          controller: _confirmPasswordController,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration("Confirm password", Icons.lock_outline),
        ),
      ],
    );
  }

  Widget _buildMobileForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Mobile Number", style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextField(
          controller: _mobileController,
          keyboardType: TextInputType.phone,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration("Enter your mobile number", Icons.phone_android),
        ),
        const SizedBox(height: 20),
        const Text("Password", style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextField(
          controller: _passwordController,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration("Enter your password", Icons.lock),
        ),
        const SizedBox(height: 20),
        const Text("Confirm Password", style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextField(
          controller: _confirmPasswordController,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration("Confirm password", Icons.lock_outline),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      prefixIcon: Icon(icon, color: Colors.grey),
      filled: true,
      fillColor: Colors.black26,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.amber),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181A20),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2329),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_outline, color: Colors.amber),
                    SizedBox(width: 8),
                    Text("ConnectPlus", style: TextStyle(color: Colors.amber, fontSize: 26, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 30),
                const Center(
                  child: Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),

                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: "Email"),
                    Tab(text: "Mobile"),
                  ],
                  indicatorColor: Colors.amber,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                ),
                const SizedBox(height: 20),

                SizedBox(
                  height: 330,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildEmailForm(),
                      _buildMobileForm(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Checkbox(
                      value: agreeToTerms,
                      onChanged: (val) {
                        setState(() {
                          agreeToTerms = val ?? false;
                        });
                      },
                      activeColor: Colors.amber,
                    ),
                    Expanded(
                      child: RichText(
                        text: const TextSpan(
                          text: "By creating an account, I agree to ConnectPlus's ",
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                          children: [
                            TextSpan(text: "Terms of Service", style: TextStyle(color: Colors.blue)),
                            TextSpan(text: " and "),
                            TextSpan(text: "Privacy Policy", style: TextStyle(color: Colors.blue)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: agreeToTerms ? () {
                      if (_tabController.index == 0) {
                        print("Email: ${_emailController.text}");
                      } else {
                        print("Mobile: ${_mobileController.text}");
                      }
                      print("Password: ${_passwordController.text}");
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      disabledBackgroundColor: Colors.grey.shade800,
                    ),
                    child: const Text("Get OTP", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 20),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to login screen
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: Colors.white70),
                        children: [
                          TextSpan(
                            text: "Login",
                            style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                const Center(
                  child: Text("Or continue with", style: TextStyle(color: Colors.white70)),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            // TODO: Google sign-in
                          },
                          child: Image.asset(
                            'assets/google_logo.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text("Google", style: TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            // TODO: Apple sign-in
                          },
                          child: Image.asset(
                            'assets/apple_logo.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text("Apple", style: TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}