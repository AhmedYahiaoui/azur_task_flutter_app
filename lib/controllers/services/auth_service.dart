import 'dart:convert';
import 'package:azur_tech_task_app/models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String authUrl = "https://example.com/api";

  Future<User?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$authUrl/login'),
        body: {'email': email, 'password': password},
      );
      int code = response.statusCode;
      if (code == 200) {
        final data = json.decode(response.body);
        return User(
          id: data['id'],
          name: data['name'],
          email: data['email'],
          photoUrl: data['photoUrl'],
        );
      } else if (hasError(code)) {
        // Mockup for an unauthorized user
        return User(
          id: "mockUser",
          name: "Mock User",
          email: "mock@example.com",
          photoUrl: null,
        );
      }
      return null;
    } catch (e) {
      throw ('${DateTime.now()} | EXCEPTION | Error while login');
    }
  }

  Future<User?> signup(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$authUrl/signup'),
        body: {'name': name, 'email': email, 'password': password},
      );
      int code = response.statusCode;

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return User(
          id: data['id'],
          name: data['name'],
          email: data['email'],
          photoUrl: data['photoUrl'],
        );
      } else if (hasError(code)) {
        // Mockup for an unauthorized user
        return User(
          id: "mockUser",
          name: "Mock User",
          email: "mock@example.com",
          photoUrl: null,
        );
      }
    } catch (e) {
      throw ('${DateTime.now()} | EXCEPTION | Error while sign up');
    }
    return null;
  }

  bool hasError(int code) {
    if (code == 401 || code == 404 || code == 405 || code == 500) {
      return true;
    } else {
      return false;
    }
  }
}
