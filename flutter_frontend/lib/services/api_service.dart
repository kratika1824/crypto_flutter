import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrlOtp = "http://localhost:8080/api/otp";
  static const String baseUrlUser = "http://localhost:8080/api/users";


  // ✅ Send OTP
  static Future<bool> sendOtp(String email) async {
    final url = Uri.parse("$baseUrlOtp/send");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({"email": email}),
      );

      print("Send OTP ➤ Status: ${response.statusCode}");
      print("Send OTP ➤ Body: ${response.body}");

      return response.statusCode == 200 &&
          response.body.toLowerCase().contains("otp sent");
    } catch (e) {
      print("Send OTP Error: $e");
      return false;
    }
  }

  // ✅ Verify OTP
  static Future<bool> verifyOtp(String email, String otp) async {
    final url = Uri.parse("$baseUrlOtp/verify");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "otp": otp}),
      );

      print("Verify OTP ➤ Status: ${response.statusCode}");
      print("Verify OTP ➤ Body: ${response.body}");

      // ✅ FIXED: sirf status code check karo
      return response.statusCode == 200;
    } catch (e) {
      print("Verify OTP Error: $e");
      return false;
    }
  }


  // ✅ Register
  static Future<String> registerUser(String email, String password) async {
    final url = Uri.parse("$baseUrlUser/register");

    try {
      final response = await http.post(url, body: {
        "email": email,
        "password": password,
      });
      print("Register ➤ Status: ${response.statusCode}");
      print("Register ➤ Body: ${response.body}");

      return response.statusCode == 200 ? "Signup Success" : "Signup Failed";
    } catch (e) {
      print("Register Error: $e");
      return "Signup Failed";
    }
  }
}
