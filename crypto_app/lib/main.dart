import 'package:flutter/material.dart';
import 'widgets/signup_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Signup Demo',
      theme: ThemeData.dark(),
      home: SignupForm(),
    );
  }
}