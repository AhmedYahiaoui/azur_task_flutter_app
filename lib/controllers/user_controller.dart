import 'package:azur_tech_task_app/provider/user_provider.dart';
import '../models/user.dart';

class ProfileController {
  final UserProvider _userProvider;

  ProfileController(this._userProvider);

  User? getUser() {
    return _userProvider.user;
  }

  void updateUser(User user) {
    _userProvider.setUser(user);
  }
}
