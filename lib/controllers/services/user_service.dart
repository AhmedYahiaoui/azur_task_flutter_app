import 'dart:convert';
import 'package:azur_tech_task_app/models/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String signupUrl = "https://example.com/api/signup/";
  final String loginUrl = "https://example.com/api/login/";

  // Method for user signup
  Future<User?> signupUser(Map<String, String> userData) async {
    try {
      final response = await http.post(
        Uri.parse(signupUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Signup failed: ${response.statusCode}');
      }
    } catch (e) {
      print("Error signing up: $e");
      return null;
    }
  }

  // Method for user login
  Future<User?> loginUser(Map<String, String> credentials) async {
    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(credentials),
      );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      print("Error logging in: $e");
      return null;
    }
  }
}
