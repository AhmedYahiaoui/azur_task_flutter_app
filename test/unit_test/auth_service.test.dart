import 'package:azur_tech_task_app/controllers/services/auth_service.dart';
import 'package:azur_tech_task_app/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([AuthService])
void main() {
  late AuthService authService;

  setUp(() {
    authService = AuthService();
  });

  group('AuthService', () {
    test('login returns true on successful login', () async {
      when(authService.login('user@example.com', 'password123')).thenAnswer(
        (_) async => User(
          id: "mockUser",
          name: "Mock User",
          email: "mock@example.com",
          photoUrl: null,
        ),
      );

      final result = await authService.login('user@example.com', 'password123');
      expect(result, true);
    });

    test('login returns false on failed login', () async {
      when(authService.login('user@example.com', 'wrongpassword')).thenAnswer(
        (_) async => User(
          id: "mockUser",
          name: "Mock User",
          email: "mock@example.com",
          photoUrl: null,
        ),
      );

      final result =
          await authService.login('user@example.com', 'wrongpassword');
      expect(result, false);
    });

    test('register returns true on successful registration', () async {
      when(authService.signup('user', 'user@example.com', 'password123'))
          .thenAnswer(
        (_) async => User(
          id: "mockUser",
          name: "Mock User",
          email: "mock@example.com",
          photoUrl: null,
        ),
      );

      final result =
          await authService.signup('user', 'user@example.com', 'password123');
      expect(result, true);
    });
  });
}
