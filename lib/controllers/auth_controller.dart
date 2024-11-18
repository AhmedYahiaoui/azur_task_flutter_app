import 'package:azur_tech_task_app/controllers/services/auth_service.dart';
import 'package:azur_tech_task_app/models/user.dart';

class AuthController {
  final AuthService _authService;
  User? _user;

  AuthController(this._authService);

  User? get user => _user;

  Future<bool> signIn(String email, String password) async {
    final result = await _authService.login(email, password);
    if (result != null) {
      _user = result;
      return true;
    }
    return false;
  }

  Future<bool> signUp(String name, String email, String password) async {
    final result = await _authService.signup(name, email, password);
    if (result != null) {
      _user = result;
      return true;
    }
    return false;
  }

  // Log out method if needed
  void logOut() {
    _user = null;
  }
}
